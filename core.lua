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