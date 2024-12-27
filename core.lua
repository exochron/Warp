local _, ADDON = ...

ADDON.Events = CreateFromMixins(EventRegistry)
ADDON.Events:OnLoad()
ADDON.Events:SetUndefinedEventsAllowed(true)

ADDON.Events:RegisterFrameEventAndCallback("PLAYER_ENTERING_WORLD", function(_, isLogin, isReload)
    if isLogin or isReload then
        ADDON.Events:TriggerEvent("OnInit")
        ADDON.Events:TriggerEvent("OnLogin")
        ADDON.Events:UnregisterEvents({"OnInit", "OnLogin"})
        ADDON.Events:UnregisterFrameEvent("PLAYER_ENTERING_WORLD")
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

function ADDON:PlayerHasItemInBag(itemId)
    for bagID = 0, NUM_BAG_SLOTS do
        local numSlots = C_Container.GetContainerNumSlots(bagID)
        for slotID = 1, numSlots do
            if C_Container.GetContainerItemID(bagID, slotID) == itemId then
                return true
            end
        end
    end
    return false
end