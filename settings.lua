local ADDON_NAME, ADDON = ...

local categoryID

local function registerSettings()
    local L = ADDON.L

    local category, layout = Settings.RegisterVerticalLayoutCategory(C_AddOns.GetAddOnMetadata(ADDON_NAME, "Title"))

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

    local function HearthstoneOptions()
        local container = Settings.CreateControlTextContainer();
        local hearthstones = tFilter(ADDON.db, function(row)
            return row.toy and row.category == ADDON.Category.Hearthstone and PlayerHasToy(row.toy)
        end, true)
        for _, row in pairs(hearthstones) do
            container:Add(row.toy, "|T" .. (C_Item.GetItemIconByID(row.toy) or "") .. ":0|t "..(C_Item.GetItemNameByID(row.toy) or ""))
        end
        return container:GetData();
    end
    local hearthstonesSetting = Settings.RegisterAddOnSetting(category, ADDON_NAME.."_HEARTHSTONES", "hearthstones",
            ScottyGlobalSettings, "table", "Choose favorite Hearthstones", {})
    if #HearthstoneOptions() > 0 then
        ADDON:CreateMultiSelectDropdownButton(layout, hearthstonesSetting, HearthstoneOptions, "You can narrow down your favorite Hearthstones for the Randomizer. With an empty list, it automatically uses all available Hearthstones.", function(dropdown)
            dropdown:SetDefaultText(ALL)
            if dropdown:GetText() == CUSTOM then
                dropdown:SetText(ALL)
            end
        end)
    end

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