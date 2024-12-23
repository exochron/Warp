local _, ADDON = ...

ADDON.Category = {
    ["Hearthstone"] = 1,
    ["SeasonInstance"] = 2,
}

ADDON.db = {

    --see: https://warcraft.wiki.gg/wiki/InstanceID

    -- seasonal dungeon port
    {spell = 445416, instance = 2669, continent=2601, category = ADDON.Category.SeasonInstance}, -- City of Threads
    {spell = 445417, instance = 2660, continent=2601, category = ADDON.Category.SeasonInstance}, -- Ara Kara: City of Echoes
    {spell = 354464, instance = 2290, continent=2222, category = ADDON.Category.SeasonInstance}, -- Mists of Tirna Scithe
    {spell = 445418, instance = 1822, continent=1643, category = ADDON.Category.SeasonInstance}, -- Siege of Boralus
    {spell = 464256, instance = 1822, continent=1643, category = ADDON.Category.SeasonInstance}, -- Siege of Boralus
    {spell = 445414, instance = 2662, continent=2601, category = ADDON.Category.SeasonInstance}, -- The Dawnbreaker
    {spell = 445269, instance = 2652, continent=2601, category = ADDON.Category.SeasonInstance}, -- Stonevault
    {spell = 445424, instance = 670, continent=0, category = ADDON.Category.SeasonInstance}, -- Grim Batol
    {spell = 354462, instance = 2286, continent=2222, category = ADDON.Category.SeasonInstance}, -- Necrotic Wake


    -- hearthstone toys
    {toy = 54452, category = ADDON.Category.Hearthstone},
    {toy = 64488, category = ADDON.Category.Hearthstone},
    {toy = 93672, category = ADDON.Category.Hearthstone},
    {toy = 142542, category = ADDON.Category.Hearthstone},
    {toy = 162973, category = ADDON.Category.Hearthstone},
    {toy = 163045, category = ADDON.Category.Hearthstone},
    {toy = 165669, category = ADDON.Category.Hearthstone},
    {toy = 165670, category = ADDON.Category.Hearthstone},
    {toy = 165802, category = ADDON.Category.Hearthstone},
    {toy = 166746, category = ADDON.Category.Hearthstone},
    {toy = 166747, category = ADDON.Category.Hearthstone},
    {toy = 168907, category = ADDON.Category.Hearthstone},
    {toy = 172179, category = ADDON.Category.Hearthstone},
    {toy = 180290, category = ADDON.Category.Hearthstone},
    {toy = 182773, category = ADDON.Category.Hearthstone},
    {toy = 183716, category = ADDON.Category.Hearthstone},
    {toy = 184353, category = ADDON.Category.Hearthstone},
    {toy = 184871, category = ADDON.Category.Hearthstone},
    {toy = 188952, category = ADDON.Category.Hearthstone},
    {toy = 190196, category = ADDON.Category.Hearthstone},
    {toy = 190237, category = ADDON.Category.Hearthstone},
    {toy = 193588, category = ADDON.Category.Hearthstone},
    {toy = 200630, category = ADDON.Category.Hearthstone},
    {toy = 206195, category = ADDON.Category.Hearthstone},
    {toy = 209035, category = ADDON.Category.Hearthstone},
    {toy = 208704, category = ADDON.Category.Hearthstone},
    {toy = 210455, category = ADDON.Category.Hearthstone},
    {toy = 212337, category = ADDON.Category.Hearthstone},
    {toy = 228940, category = ADDON.Category.Hearthstone},
    {toy = 235016, category = ADDON.Category.Hearthstone},
}