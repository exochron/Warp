local ADDON_NAME, ADDON = ...

local function buildHearthstoneButton()
    local button = CreateFrame("Button", nil, nil, "SecureActionButtonTemplate")

    local function GetRandomHearthstoneToy()
        local stones = {}

        for _, row in ipairs(ADDON.db) do
            if row.category == ADDON.Category.Hearthstone and row.toy and PlayerHasToy(row.toy) then
                stones[#stones+1] = row.toy
            end
        end

        return GetRandomArrayEntry(stones)
    end
    local function SetupHearthstone()
        local toy = GetRandomHearthstoneToy()
        if toy then
            button:SetAttribute("type", "toy")
            button:SetAttribute("typerelease", "toy")
            button:SetAttribute("toy", toy)
            return
        end

        local item = C_Container.PlayerHasHearthstone and C_Container.PlayerHasHearthstone() or PlayerHasHearthstone()
        if item then
            button:SetAttribute("type", "item")
            button:SetAttribute("typerelease", "item")
            button:SetAttribute("item", item)
        end
    end

    button:SetAttribute("pressAndHoldAction", 1)
    button:RegisterForClicks("LeftButtonUp")
    button:SetPropagateMouseClicks(true)
    button:SetPropagateMouseMotion(true)
    button:SetFrameStrata("DIALOG")
    button:SetSize(1,1)
    button:SetPoint("RIGHT", -10, -10)
    button:Show()
    SetupHearthstone()
    button:HookScript("PreClick", function()
        if not InCombatLockdown() and button:GetParent():IsDragging() then
            button:SetAttribute("type", "")
            button:SetAttribute("typerelease", "")
        end
    end)
    button:HookScript("PostClick", function()
        if not InCombatLockdown() then
            SetupHearthstone()
        end
    end)

    return button
end

ADDON.Events:RegisterCallback("OnLogin", function()
    local ldb = LibStub and LibStub("LibDataBroker-1.1", true)
    if not ldb then
        return
    end

    local hearthstoneButton = buildHearthstoneButton()

    local menu
    local tooltipProxy = CreateFrame("Frame")
    tooltipProxy:Hide()
    tooltipProxy:HookScript("OnShow", function()
        if not InCombatLockdown() then
            local point, relativeTo, relativePoint, offsetX, offsetY = tooltipProxy:GetPoint(1)
            hearthstoneButton:SetParent(relativeTo)
            hearthstoneButton:SetAllPoints(relativeTo)
        end
    end)
    tooltipProxy:HookScript("OnHide", function()
        if menu and not menu:IsMouseOver() then
            menu:Close()
        end
    end)

    local hearthstoneItem = hearthstoneButton:GetAttribute("toy") or hearthstoneButton:GetAttribute("item")
    local ldbDataObject = ldb:NewDataObject( ADDON_NAME, {
        type = "data source",
        text = GetBindLocation(),
        label = C_Item.GetItemNameByID(hearthstoneItem),
        icon = C_Item.GetItemIconByID(hearthstoneItem),
        tooltip = tooltipProxy,

        OnClick = function(_, button)
            if button == "RightButton" then
            else
            end
        end,
    } )

    hearthstoneButton:HookScript("OnAttributeChanged", function(_, name, value)
        if name == "toy" or name == "item" then
            ldbDataObject.label = C_Item.GetItemNameByID(value)
            ldbDataObject.icon = C_Item.GetItemIconByID(value)
        end
    end)

    ADDON.Events:RegisterFrameEventAndCallback("HEARTHSTONE_BOUND", function()
        ldbDataObject.text = GetBindLocation()
    end, 'ldb-plugin')

end, "ldb-plugin")