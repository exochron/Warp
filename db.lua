local _, ADDON = ...

ADDON.Category = {
    ["Hearthstone"] = 1,
    ["SeasonInstance"] = 2,
}

ADDON.db = {

    --see: https://warcraft.wiki.gg/wiki/InstanceID

    -- seasonal dungeon port
    {spell = 445416, instance = 2669, continent = 2601, category = ADDON.Category.SeasonInstance}, -- City of Threads
    {spell = 445417, instance = 2660, continent = 2601, category = ADDON.Category.SeasonInstance}, -- Ara Kara: City of Echoes
    {spell = 354464, instance = 2290, continent = 2222, category = ADDON.Category.SeasonInstance}, -- Mists of Tirna Scithe
    {spell = 445418, instance = 1822, continent = 1643, category = ADDON.Category.SeasonInstance}, -- Siege of Boralus
    {spell = 464256, instance = 1822, continent = 1643, category = ADDON.Category.SeasonInstance}, -- Siege of Boralus
    {spell = 445414, instance = 2662, continent = 2601, category = ADDON.Category.SeasonInstance}, -- The Dawnbreaker
    {spell = 445269, instance = 2652, continent = 2601, category = ADDON.Category.SeasonInstance}, -- Stonevault
    {spell = 445424, instance = 670, continent = 0, category = ADDON.Category.SeasonInstance}, -- Grim Batol
    {spell = 354462, instance = 2286, continent = 2222, category = ADDON.Category.SeasonInstance}, -- Necrotic Wake

    -- older dungeon portsc
    {spell = 393273, instance = 2526, continent = 2444}, -- Algeth'ar Academy
    {spell = 393267, instance = 2520, continent = 2444}, -- Brackenhide Hollow
    {spell = 393283, instance = 2527, continent = 2444}, -- Halls of Infusion
    {spell = 393276, instance = 2519, continent = 2444}, -- Neltharus
    {spell = 393256, instance = 2521, continent = 2444}, -- Ruby Life Pools
    {spell = 393279, instance = 2515, continent = 2444}, -- The Azure Vault
    {spell = 393262, instance = 2516, continent = 2444}, -- The Nokhud Offensive
    {spell = 424197, instance = 2579, continent = 2444}, -- Dawn of the Infinite
    {spell = 432257, instance = 2569, continent = 2444}, -- Aberrus
    {spell = 432254, instance = 2522, continent = 2444}, -- Vault of the Incarnates
    {spell = 432258, instance = 2549, continent = 2444}, -- Amirdrassil, the Dream's Hope
    {spell = 393222, instance = 2451, continent = 0}, -- Uldaman: Legacy of Tyr
    {spell = 354469, instance = 2284, continent = 2222}, -- Sanguine Depths
    {spell = 354466, instance = 2285, continent = 2222}, -- Spires of Ascension
    {spell = 354465, instance = 2287, continent = 2222}, -- Halls of Atonement
    {spell = 354463, instance = 2289, continent = 2222}, -- Plaguefall
    {spell = 354468, instance = 2291, continent = 2222}, -- De Other Side
    {spell = 354467, instance = 2293, continent = 2222}, -- Theater of Pain
    {spell = 367416, instance = 2441, continent = 2222}, -- Tazavesh the Veiled Market
    {spell = 373190, instance = 2296, continent = 2222}, -- Castle Nathria
    {spell = 373191, instance = 2450, continent = 2222}, -- Sanctum of Domination
    {spell = 373192, instance = 2481, continent = 2222}, -- Sepulcher of the First Ones
    {spell = 410071, instance = 1754, continent = 1643}, -- Freehold
    {spell = 424187, instance = 1763, continent = 1642}, -- Atal'Dazar
    {spell = 373274, instance = 2097, continent = 1643}, -- Operation: Mechagon
    {spell = 424167, instance = 1862, continent = 1643}, -- Waycrest Manor
    {spell = 410074, instance = 1841, continent = 1642}, -- The Underrot
    {spell = 373262, instance = 532, continent = 0}, -- Karazhan
    {spell = 393764, instance = 1477, continent = 1220}, -- Halls of Valor
    {spell = 393766, instance = 1571, continent = 1220}, -- Court of Stars
    {spell = 410078, instance = 1458, continent = 1220}, -- Neltharion's Lair
    {spell = 424153, instance = 1501, continent = 1220}, -- Black Rook Hold
    {spell = 424163, instance = 1466, continent = 1220}, -- Darkheart Thicket
    {spell = 159895, instance = 1175, continent = 1116}, -- Bloodmaul Slag Mines
    {spell = 159896, instance = 1195, continent = 1116}, -- Iron Docks
    {spell = 159897, instance = 1182, continent = 1116}, -- Auchindoun
    {spell = 159898, instance = 1209, continent = 1116}, -- Skyreach
    {spell = 159899, instance = 1176, continent = 1116}, -- Shadowmoon Burial Grounds
    {spell = 159900, instance = 1208, continent = 1116}, -- Grimrail Depot
    {spell = 159901, instance = 1279, continent = 1116}, -- The Everbloom
    {spell = 131204, instance = 960, continent = 870}, -- Temple of the Jade Serpent
    {spell = 131205, instance = 961, continent = 870}, -- Stormstout Brewery
    {spell = 131206, instance = 959, continent = 870}, -- Shado-Pan Monastery
    {spell = 131222, instance = 994, continent = 870}, -- Mogu'shan Palace
    {spell = 131225, instance = 962, continent = 870}, -- Gate of the Setting Sun
    {spell = 131228, instance = 1011, continent = 870}, -- Siege of Niuzao Temple
    {spell = 410080, instance = 657, continent = 1}, -- The Vortex Pinnacle
    {spell = 424142, instance = 643, continent = 0}, -- Throne of the Tides
    {spell = 131229, instance = 1004, continent = 0}, -- Scarlet Monastery
    {spell = 131231, instance = 1001, continent = 0}, -- Scarlet Halls
    {spell = 131232, instance = 1007, continent = 0}, -- Scholomance
    {spell = 159902, instance = 1358, continent = 0}, -- Upper Blackrock Spire

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