local ADDON_NAME, ADDON = ...

local hearthstoneButton
local menuActionButton
local function buildMenuActionButton()
    local button = CreateFrame("Button", nil, nil, "InsecureActionButtonTemplate")
    button:SetAttribute("pressAndHoldAction", 1)
    button:RegisterForClicks("LeftButtonUp")
    button:SetPropagateMouseClicks(true)
    button:SetPropagateMouseMotion(true)
    button:Hide()

    return button
end

local function generateTeleportMenu(_, root)
    root:SetTag(ADDON_NAME.."-LDB-Teleport")
    root:SetScrollMode(GetScreenHeight() - 100)

    root:CreateTitle("Teleports")

    local function buildToyEntry(itemId, location)
        local icon = C_Item.GetItemIconByID(itemId)
        local element = root:CreateButton("|T" .. icon .. ":0|t "..location)
        element:SetOnEnter(function(frame)
            menuActionButton:SetAttribute("type", "toy")
            menuActionButton:SetAttribute("typerelease", "toy")
            menuActionButton:SetAttribute("toy", itemId)
            menuActionButton:SetParent(frame)
            menuActionButton:SetAllPoints(frame)
            menuActionButton:SetFrameStrata("FULLSCREEN_DIALOG")
            menuActionButton:SetFrameLevel(600)
            menuActionButton:Show()

            GameTooltip:SetOwner(frame, "ANCHOR_NONE")
            GameTooltip:SetPoint("TOPLEFT", frame, "TOPRIGHT")
            GameTooltip:ClearLines()
            GameTooltip:SetToyByItemID(itemId)
            GameTooltip:Show()
        end)
        element:SetOnLeave(function()
            GameTooltip:Hide()
            menuActionButton:Hide()
        end)
        local cooldownTimer = C_Container.GetItemCooldown(itemId)
        if cooldownTimer > 0 then
            element:AddInitializer(function(button)
                button.fontString:SetAlpha(0.5)
            end)
        end
        return element
    end

    local function buildItemEntry(itemId, location)
        local icon = C_Item.GetItemIconByID(itemId)
        local element = root:CreateButton("|T" .. icon .. ":0|t "..location)
        element:SetOnEnter(function(frame)
            menuActionButton:SetAttribute("type", "item")
            menuActionButton:SetAttribute("typerelease", "item")
            menuActionButton:SetAttribute("item", itemId)
            menuActionButton:SetParent(frame)
            menuActionButton:SetAllPoints(frame)
            menuActionButton:SetFrameStrata("FULLSCREEN_DIALOG")
            menuActionButton:SetFrameLevel(600)
            menuActionButton:Show()

            GameTooltip:SetOwner(frame, "ANCHOR_NONE")
            GameTooltip:SetPoint("TOPLEFT", frame, "TOPRIGHT")
            GameTooltip:ClearLines()
            GameTooltip:SetToyByItemID(itemId)
            GameTooltip:Show()
        end)
        element:SetOnLeave(function()
            GameTooltip:Hide()
            menuActionButton:Hide()
        end)
        local cooldownTimer = C_Container.GetItemCooldown(itemId)
        if cooldownTimer > 0 then
            element:AddInitializer(function(button)
                button.fontString:SetAlpha(0.5)
            end)
        end
        return element
    end

    -- Hearthstone
    if hearthstoneButton:GetAttribute("toy") then
        buildToyEntry(hearthstoneButton:GetAttribute("toy"), GetBindLocation()):SetResponder(function()
            hearthstoneButton:ShuffleHearthstone()
            return MenuResponse.CloseAll
        end)
    else
        buildItemEntry(hearthstoneButton:GetAttribute("item"), GetBindLocation())
    end
    root:QueueSpacer()

    -- season dungeons

    -- continents
end

local function OpenMenu(anchorSource, generator)
    local menuDescription = MenuUtil.CreateRootMenuDescription(MenuVariants.GetDefaultContextMenuMixin())

    local point, relativeTo, relativePoint, offsetX, offsetY = anchorSource:GetPoint(1)

    Menu.PopulateDescription(generator, relativeTo, menuDescription)

    local anchor = CreateAnchor(point, relativeTo, relativePoint, offsetX, offsetY)
    local menu = Menu.GetManager():OpenMenu(relativeTo, menuDescription, anchor)
    if menu then
        menu:HookScript("OnLeave", function()
            if not menu:IsMouseOver() then
                menu:Close()
            end
        end) -- OnLeave gets reset every time
    end

    return menu
end

local function buildHearthstoneButton()
    local button = CreateFrame("Button", nil, nil, "SecureActionButtonTemplate")

    local function GetRandomHearthstoneToy()
        local stones = {}

        for _, row in ipairs(ADDON.db) do
            if row.category == ADDON.Category.Hearthstone and row.toy and PlayerHasToy(row.toy) then
                stones[#stones+1] = row.toy
            end
        end

        -- avoid last used hearthstone
        if #stones > 1 and button:GetAttribute("toy") then
            local skipToy = button:GetAttribute("toy")
            stones = tFilter(stones, function(v) return v ~= skipToy end, true)
        end

        return GetRandomArrayEntry(stones)
    end
    button.ShuffleHearthstone = function(self)
        local toy = GetRandomHearthstoneToy()
        if toy then
            self:SetAttribute("type", "toy")
            self:SetAttribute("typerelease", "toy")
            self:SetAttribute("toy", toy)
            self:SetAttribute("item", nil)
            return
        end

        local item = C_Container.PlayerHasHearthstone and C_Container.PlayerHasHearthstone() or PlayerHasHearthstone()
        if item then
            self:SetAttribute("type", "item")
            self:SetAttribute("typerelease", "item")
            self:SetAttribute("item", item)
            self:SetAttribute("toy", nil)
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
    button:ShuffleHearthstone()
    button:HookScript("PreClick", function()
        if not InCombatLockdown() and button:GetParent():IsDragging() then
            button:SetAttribute("type", "")
            button:SetAttribute("typerelease", "")
        end
    end)
    button:HookScript("PostClick", function(self)
        if not InCombatLockdown() then
            self:ShuffleHearthstone()
        end
    end)

    return button
end

ADDON.Events:RegisterCallback("OnLogin", function()
    local ldb = LibStub and LibStub("LibDataBroker-1.1", true)
    if not ldb then
        return
    end

    menuActionButton = buildMenuActionButton()
    hearthstoneButton = buildHearthstoneButton()

    local menu
    local tooltipProxy = CreateFrame("Frame")
    tooltipProxy:Hide()
    tooltipProxy:HookScript("OnShow", function()
        if not InCombatLockdown() then
            local point, relativeTo, relativePoint, offsetX, offsetY = tooltipProxy:GetPoint(1)
            hearthstoneButton:SetParent(relativeTo)
            hearthstoneButton:SetAllPoints(relativeTo)

            menu = OpenMenu(tooltipProxy, generateTeleportMenu)
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
        if value and (name == "toy" or name == "item") then
            ldbDataObject.label = C_Item.GetItemNameByID(value)
            ldbDataObject.icon = C_Item.GetItemIconByID(value)
        end
    end)

    ADDON.Events:RegisterFrameEventAndCallback("HEARTHSTONE_BOUND", function()
        ldbDataObject.text = GetBindLocation()
    end, 'ldb-plugin')

end, "ldb-plugin")