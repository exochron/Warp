local ADDON_NAME, ADDON = ...

local categoryID

local function registerSettings()
    local L = ADDON.L

    local category = Settings.RegisterVerticalLayoutCategory(C_AddOns.GetAddOnMetadata(ADDON_NAME, "Title"))

    local minimapSetting = Settings.RegisterAddOnSetting(category, ADDON_NAME.."_MINIMAP", "showMinimap",
            ADDON.settings, Settings.VarType.Boolean, L.SETTING_MINIMAP, Settings.Default.True)
    minimapSetting:SetValueChangedCallback(function(_, value)
        ADDON.settings.minimap.hide = not value
        LibStub("LibDBIcon-1.0"):Refresh(ADDON_NAME, ADDON.settings.minimap)
    end)
    Settings.CreateCheckbox(category, minimapSetting)

    local groupSeasonSetting = Settings.RegisterAddOnSetting(category, ADDON_NAME.."_GROUP_SEASON", "groupSeason",
        ADDON.settings, Settings.VarType.Boolean, L.SETTING_GROUP_SEASON, Settings.Default.False)
    Settings.CreateCheckbox(category, groupSeasonSetting)

    Settings.RegisterAddOnCategory(category)
    categoryID = category.ID
end

function ADDON:OpenSettings()
    Settings.OpenToCategory(categoryID)
end

ADDON.Events:RegisterCallback("OnInit", function()
    local defaults = {
        groupSeason = false,
        showMinimap = true,
        minimap = {} -- for LibDBIcon
    }

    ScottyGlobalSettings = ScottyGlobalSettings or defaults
    ADDON.settings = ScottyGlobalSettings

    registerSettings()
end, "settings")