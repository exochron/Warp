local _, ADDON = ...

local function alert(msg)
    print("Scotty: "..msg)
end

local function CheckNameAvailable(row)
    if row.instance ~= nil and nil == GetRealZoneText(row.instance) then
        alert("no Name detected for Instance: ".. row.instance)
    end
    if row.map ~= nil and nil == C_Map.GetMapInfo(row.map) then
        alert("no Name detected for Map: ".. row.map)
    end
end

local function CheckPortalExistsAsWell(row)
    if row.spell and row.portal and false == C_Spell.DoesSpellExist(row.portal) then
        alert("Teleport Portal does not exist: ".. row.portal)
    end
end

local function TestDB()
    for _, row in ipairs(ADDON.db) do
        if (row.item and ADDON.DoesItemExistInGame(row.item))
            or (row.toy and ADDON.DoesItemExistInGame(row.toy))
            or (row.spell and C_Spell.DoesSpellExist(row.spell))
        then
            CheckNameAvailable(row)
            CheckPortalExistsAsWell(row)
        end
    end
end

ADDON.Events:RegisterCallback("OnLogin", function()
    TestDB()
end, "tests")