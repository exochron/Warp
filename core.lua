local _, ADDON = ...

ADDON.Events = CreateFromMixins(EventRegistry)
ADDON.Events:OnLoad()
ADDON.Events:SetUndefinedEventsAllowed(true)

local function loadDataIntoCache()
    for _, row in ipairs(ADDON.db) do
        if row.toy then
            C_Item.RequestLoadItemDataByID(row.toy)
        elseif row.item then
            C_Item.RequestLoadItemDataByID(row.item)
        end
    end
end

ADDON.Events:RegisterFrameEventAndCallback("PLAYER_ENTERING_WORLD", function(_, isLogin, isReload)
    if isLogin or isReload then
        loadDataIntoCache()
        ADDON.Events:TriggerEvent("OnInit")
        ADDON.Events:TriggerEvent("OnLogin")
        ADDON.Events:UnregisterEvents({"OnInit", "OnLogin"})
        ADDON.Events:UnregisterFrameEvent("PLAYER_ENTERING_WORLD")
    end
end, "init")