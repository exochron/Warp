local ADDON_NAME, ADDON = ...

local tFilter = tFilter

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

    --root:CreateTitle("Teleports")

    local function buildEntry(root, type, id, icon, location, tooltipSetter, hasCooldown)
        local element = root:CreateButton("|T" .. icon .. ":0|t "..location)
        element:SetOnEnter(function(frame)
            menuActionButton:SetAttribute("type", type)
            menuActionButton:SetAttribute("typerelease", type)
            menuActionButton:SetAttribute(type, id)
            menuActionButton:SetParent(frame)
            menuActionButton:SetAllPoints(frame)
            menuActionButton:SetFrameStrata("FULLSCREEN_DIALOG")
            menuActionButton:SetFrameLevel(10000)
            menuActionButton:Show()

            GameTooltip:SetOwner(frame, "ANCHOR_NONE")
            GameTooltip:SetPoint("TOPLEFT", frame, "TOPRIGHT")
            GameTooltip:ClearLines()
            tooltipSetter(GameTooltip, id)
            GameTooltip:Show()
        end)
        element:SetOnLeave(function()
            GameTooltip:Hide()
            menuActionButton:Hide()
        end)
        if hasCooldown then
            element:AddInitializer(function(button)
                button.fontString:SetAlpha(0.5)
            end)
        end
        return element
    end

    local function buildToyEntry(root, itemId, location)
        return buildEntry(
                root,
            "toy",
            itemId,
            C_Item.GetItemIconByID(itemId),
            location,
            GameTooltip.SetToyByItemID,
            C_Container.GetItemCooldown(itemId) > 0
        )
    end

    local function buildItemEntry(root, itemId, location)
        return buildEntry(
                root,
            "item",
            itemId,
            C_Item.GetItemIconByID(itemId),
            location,
            GameTooltip.SetItemByID,
            C_Container.GetItemCooldown(itemId) > 0
        )
    end

    local function buildSpellEntry(root, spellId, location)
        return buildEntry(
                root,
            "spell",
            spellId,
            C_Spell.GetSpellTexture(spellId),
            location,
            GameTooltip.SetSpellByID,
            not C_Spell.IsSpellUsable(spellId)
        )
    end

    -- Hearthstone
    if hearthstoneButton:GetAttribute("toy") then
        buildToyEntry(root, hearthstoneButton:GetAttribute("toy"), GetBindLocation()):SetResponder(function()
            hearthstoneButton:ShuffleHearthstone()
            return MenuResponse.CloseAll
        end)
    else
        buildItemEntry(root, hearthstoneButton:GetAttribute("item"), GetBindLocation())
    end
    root:QueueSpacer()

    -- season dungeons
    local seasonSpells = tFilter(ADDON.db, function(row)
        return row.category == ADDON.Category.SeasonInstance and row.spell and IsSpellKnown(row.spell)
    end, true)
    table.sort(seasonSpells, function(a, b) return GetRealZoneText(a.instance) < GetRealZoneText(b.instance) end)
    for _, row in ipairs(seasonSpells) do
        buildSpellEntry(root, row.spell, GetRealZoneText(row.instance))
    end
    root:QueueSpacer()

    -- continents
    local groupedByContinent = {}
    for _, row in ipairs(ADDON.db) do
        if row.continent then
            if not groupedByContinent[row.continent] then
                groupedByContinent[row.continent] = {}
            end
            table.insert(groupedByContinent[row.continent], row)
        end
    end
    local continents = GetKeysArray(groupedByContinent)
    table.sort(continents)
    for _, continent in ipairs(continents) do
        local list = groupedByContinent[continent]
        list = tFilter(list, function(row) return row.spell and IsSpellKnown(row.spell) end, true)
        if #list > 0 then
            table.sort(list, function(a, b)
                return GetRealZoneText(a.instance) < GetRealZoneText(b.instance)
            end)

            local continentRoot = root:CreateButton(GetRealZoneText(continent))
            for _, row in ipairs(list) do
                if row.instance then
                    buildSpellEntry(continentRoot, row.spell, GetRealZoneText(row.instance))
                end
            end
        end
    end
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
        local stones = tFilter(ADDON.db, function(row)
            return row.category == ADDON.Category.Hearthstone and row.toy and PlayerHasToy(row.toy)
        end, true)
        stones = TableUtil.Transform(stones, function(row) return row.toy end)

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