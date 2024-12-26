local _, ADDON = ...

ADDON.Events = CreateFromMixins(EventRegistry)
ADDON.Events:OnLoad()
ADDON.Events:SetUndefinedEventsAllowed(true)

local function loadDataIntoCache(onDone)
    local itemsToLoad = {}
    local countOfUnloadedItems = 0

    for _, row in ipairs(ADDON.db) do
        if row.toy then
            itemsToLoad[row.toy] = true
            countOfUnloadedItems = countOfUnloadedItems + 1
        elseif row.item then
            itemsToLoad[row.item] = true
            countOfUnloadedItems = countOfUnloadedItems + 1
        end
    end
    ADDON.Events:RegisterFrameEventAndCallback("ITEM_DATA_LOAD_RESULT", function(_, itemId, success)
        if itemsToLoad[itemId] then
            countOfUnloadedItems = countOfUnloadedItems - 1

            if countOfUnloadedItems == 0 then
                onDone()
                ADDON.Events:UnregisterFrameEventAndCallback("ITEM_DATA_LOAD_RESULT", 'async item loader')
            end
        end
    end, 'async item loader')
    for itemId, _ in pairs(itemsToLoad) do
        C_Item.RequestLoadItemDataByID(itemId)
    end
end

ADDON.Events:RegisterFrameEventAndCallback("PLAYER_ENTERING_WORLD", function(_, isLogin, isReload)
    if isLogin or isReload then
        loadDataIntoCache(function()
            ADDON.Events:TriggerEvent("OnInit")
            ADDON.Events:TriggerEvent("OnLogin")
            ADDON.Events:UnregisterEvents({"OnInit", "OnLogin"})
            ADDON.Events:UnregisterFrameEvent("PLAYER_ENTERING_WORLD")
        end)
    end
end, "init")

function ADDON:GetItemSlot(itemId)
    local invTypeId = C_Item.GetItemInventoryTypeByID(itemId)
    -- from https://warcraft.wiki.gg/wiki/Enum.InventoryType
    if invTypeId < 12 then
        return invTypeId
    end
    if invTypeId == 20 then return  5 end
    if invTypeId == 12 then return 13 end
    if invTypeId == 16 then return 15 end
    if invTypeId == 13 or invTypeId == 15 or invTypeId == 17 or invTypeId == 21 or invTypeId == 22 or invTypeId == 25 or invTypeId == 26 then
        return 16
    end
    if invTypeId == 14 or invTypeId == 23 then
        return 17
    end
    if invTypeId == 19 then return 19 end
end