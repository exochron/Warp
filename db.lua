local _, ADDON = ...

-- see: https://warcraft.wiki.gg/wiki/UiMapID & https://warcraft.wiki.gg/wiki/InstanceID

local EASTERN_KINGDOMS = 0
local KALIMDOR = 1
local OUTLAND = 530
local NORTHREND = 571
local PANDARIA = 870
local DRAENOR = 1116
local BROKEN_ISLES = 1220
local ARGUS = 1669
local ZANDALAR = 1642
local KUL_TIRAS = 1643
local SHADOWLANDS = 2222
local DRAGON_ISLES = 2444
local KHAZ_ALGAR = 2601

local isAlliance = UnitFactionGroup("player") == "Alliance"

ADDON.Category = {
    Hearthstone = 1,
    SeasonInstance = 2,
}

ADDON.db = {
    --todo: various items
    --todo: mage ports & portals
    --todo: druid ports

    --various items
    {item = 21711, map = 80, continent = KALIMDOR}, -- Lunar Festival Invitation
    {item = 22631, map = 42, continent = EASTERN_KINGDOMS}, -- Atiesh, Greatstaff of the Guardian
    {item = 37863, map = 35, continent = EASTERN_KINGDOMS}, -- Direbrew's Remote
    {item = 40585, map = 125, continent = NORTHREND}, -- Signet of the Kirin Tor
    {item = 40586, map = 125, continent = NORTHREND}, -- Band of the Kirin Tor
    {item = 44934, map = 125, continent = NORTHREND}, -- Loop of the Kirin Tor
    {item = 44935, map = 125, continent = NORTHREND}, -- Ring of the Kirin Tor
    {item = 45688, map = 125, continent = NORTHREND}, -- Inscribed Band of the Kirin Tor
    {item = 45689, map = 125, continent = NORTHREND}, -- Inscribed Loop of the Kirin Tor
    {item = 45690, map = 125, continent = NORTHREND}, -- Inscribed Ring of the Kirin Tor
    {item = 45691, map = 125, continent = NORTHREND}, -- Inscribed Signet of the Kirin Tor
    {item = 46874, map = 118, continent = NORTHREND}, -- Argent Crusader's Tabard
    {item = 48954, map = 125, continent = NORTHREND}, -- Etched Band of the Kirin Tor
    {item = 48955, map = 125, continent = NORTHREND}, -- Etched Loop of the Kirin Tor
    {item = 48956, map = 125, continent = NORTHREND}, -- Etched Ring of the Kirin Tor
    {item = 48957, map = 125, continent = NORTHREND}, -- Etched Signet of the Kirin Tor
    {item = 50287, map = 210, continent = EASTERN_KINGDOMS}, -- Boots of the Bay
    {item = 51557, map = 125, continent = NORTHREND}, -- Runed Signet of the Kirin Tor
    {item = 51558, map = 125, continent = NORTHREND}, -- Runed Loop of the Kirin Tor
    {item = 51559, map = 125, continent = NORTHREND}, -- Runed Ring of the Kirin Tor
    {item = 51560, map = 125, continent = NORTHREND}, -- Runed Band of the Kirin Tor
    {item = 52251, map = 125, continent = NORTHREND}, -- Jaina's Locket
    {item = 52251, map = 125, continent = NORTHREND}, -- Potion of Deepholm
    {item = 63206, map = 84, continent = EASTERN_KINGDOMS}, -- Wrap of Unity
    {item = 63207, map = 85, continent = KALIMDOR}, -- Wrap of Unity
    {item = 63352, map = 84, continent = EASTERN_KINGDOMS}, -- Shroud of Cooperation
    {item = 63353, map = 85, continent = KALIMDOR}, -- Shroud of Cooperation
    {item = 63378, map = 245, continent = EASTERN_KINGDOMS}, -- Hellscream's Reach Tabard
    {item = 63379, map = 245, continent = EASTERN_KINGDOMS}, -- Baradin's Wardens Tabard
    {item = 65274, map = 85, continent = KALIMDOR}, -- Cloak of Coordination
    {item = 65360, map = 84, continent = EASTERN_KINGDOMS}, -- Cloak of Coordination
    {item = 95050, map = 503, continent = KALIMDOR}, -- The Brassiest Knuckle
    {item = 95051, map = 500, continent = EASTERN_KINGDOMS}, -- The Brassiest Knuckle
    {item = 103678, map = 554, continent = PANDARIA}, -- Time-Lost Artifact
    {item = 118662, map = 624, continent = DRAENOR}, -- Bladespire Relic
    {item = 118663, map = 622, continent = DRAENOR}, -- Relic of Karabor
    {item = 118907, map = 500, continent = EASTERN_KINGDOMS}, -- Pit Fighter's Punching Ring
    {item = 118908, map = 503, continent = KALIMDOR}, -- Pit Fighter's Punching Ring
    {item = 128353, map = (isAlliance and 539 or 525), continent = DRAENOR}, -- Admiral's Compass
    {item = 139590, map = 25, continent = EASTERN_KINGDOMS}, -- Scroll of Teleport: Ravenholdt
    {item = 139599, map = 627, continent = BROKEN_ISLES}, -- Empowered Ring of the Kirin Tor
    {item = 144391, map = 500, continent = EASTERN_KINGDOMS}, -- Pugilist's Powerful Punching Ring
    {item = 144392, map = 503, continent = KALIMDOR}, -- Pugilist's Powerful Punching Ring
    {item = 166559, map = 1165, continent = ZANDALAR}, -- Commander's Signet of Battle
    {item = 166560, map = 1161, continent = KUL_TIRAS}, -- Commander's Signet of Battle
    {toy = 95567, map = 504, continent = PANDARIA}, -- Kirin Tor Beacon
    {toy = 95568, map = 504, continent = PANDARIA}, -- Sunreaver Beacon
    {toy = 110560, map = (isAlliance and 539 or 525), continent = DRAENOR}, -- Garrison Hearthstone
    {toy = 140192, map = 627, continent = BROKEN_ISLES}, -- Dalaran Hearthstone
    {toy = 142469, map = 42, continent = EASTERN_KINGDOMS}, -- Violet Seal of the Grand Magus
    {toy = 151016, map = 104, continent = OUTLAND}, -- Fractured Necrolyte Skull


    --engineer items
    {toy = 18984, map = 83, continent = KALIMDOR}, -- Dimensional Ripper - Everlook
    {toy = 18986, map = 71, continent = KALIMDOR}, -- Ultrasafe Transporter: Gadgetzan
    {toy = 30542, map = 109, continent = OUTLAND}, -- Dimensional Ripper - Area 52
    {toy = 30544, map = 105, continent = OUTLAND}, -- Ultrasafe Transporter: Toshley's Station
    {toy = 48933, map = 113, continent = NORTHREND}, -- Wormhole Generator: Northrend
    {toy = 87215, map = 424, continent = PANDARIA}, -- Wormhole Generator: Pandaria
    {toy = 112059, map = 572, continent = DRAENOR}, -- Wormhole Centrifuge
    {toy = 151652, map = 994, continent = ARGUS}, -- Wormhole Generator: Argus
    {toy = 168807, map = 992, continent = KUL_TIRAS}, -- Wormhole Generator: Kul Tiras
    {toy = 168808, map = 991, continent = ZANDALAR}, -- Wormhole Generator: Zandalar
    {toy = 172924, map = 1550, continent = SHADOWLANDS}, -- Wormhole Generator: Shadowlands
    {toy = 198156, map = 1978, continent = DRAGON_ISLES}, -- Wormhole Generator: Dragon Isles
    {toy = 221966, map = 2274, continent = KHAZ_ALGAR}, -- Wormhole Generator: Khaz Algar

    -- seasonal dungeon port
    {spell = 445416, instance = 2669, continent = KHAZ_ALGAR, category = ADDON.Category.SeasonInstance}, -- City of Threads
    {spell = 445417, instance = 2660, continent = KHAZ_ALGAR, category = ADDON.Category.SeasonInstance}, -- Ara Kara: City of Echoes
    {spell = 354464, instance = 2290, continent = SHADOWLANDS, category = ADDON.Category.SeasonInstance}, -- Mists of Tirna Scithe
    {spell = 445418, instance = 1822, continent = KUL_TIRAS, category = ADDON.Category.SeasonInstance}, -- Siege of Boralus
    {spell = 464256, instance = 1822, continent = KUL_TIRAS, category = ADDON.Category.SeasonInstance}, -- Siege of Boralus
    {spell = 445414, instance = 2662, continent = KHAZ_ALGAR, category = ADDON.Category.SeasonInstance}, -- The Dawnbreaker
    {spell = 445269, instance = 2652, continent = KHAZ_ALGAR, category = ADDON.Category.SeasonInstance}, -- Stonevault
    {spell = 445424, instance = 670, continent = EASTERN_KINGDOMS, category = ADDON.Category.SeasonInstance}, -- Grim Batol
    {spell = 354462, instance = 2286, continent = SHADOWLANDS, category = ADDON.Category.SeasonInstance}, -- Necrotic Wake

    -- older dungeon portsc
    {spell = 393273, instance = 2526, continent = DRAGON_ISLES}, -- Algeth'ar Academy
    {spell = 393267, instance = 2520, continent = DRAGON_ISLES}, -- Brackenhide Hollow
    {spell = 393283, instance = 2527, continent = DRAGON_ISLES}, -- Halls of Infusion
    {spell = 393276, instance = 2519, continent = DRAGON_ISLES}, -- Neltharus
    {spell = 393256, instance = 2521, continent = DRAGON_ISLES}, -- Ruby Life Pools
    {spell = 393279, instance = 2515, continent = DRAGON_ISLES}, -- The Azure Vault
    {spell = 393262, instance = 2516, continent = DRAGON_ISLES}, -- The Nokhud Offensive
    {spell = 424197, instance = 2579, continent = DRAGON_ISLES}, -- Dawn of the Infinite
    {spell = 432257, instance = 2569, continent = DRAGON_ISLES}, -- Aberrus
    {spell = 432254, instance = 2522, continent = DRAGON_ISLES}, -- Vault of the Incarnates
    {spell = 432258, instance = 2549, continent = DRAGON_ISLES}, -- Amirdrassil, the Dream's Hope
    {spell = 393222, instance = 2451, continent = EASTERN_KINGDOMS}, -- Uldaman: Legacy of Tyr
    {spell = 354469, instance = 2284, continent = SHADOWLANDS}, -- Sanguine Depths
    {spell = 354466, instance = 2285, continent = SHADOWLANDS}, -- Spires of Ascension
    {spell = 354465, instance = 2287, continent = SHADOWLANDS}, -- Halls of Atonement
    {spell = 354463, instance = 2289, continent = SHADOWLANDS}, -- Plaguefall
    {spell = 354468, instance = 2291, continent = SHADOWLANDS}, -- De Other Side
    {spell = 354467, instance = 2293, continent = SHADOWLANDS}, -- Theater of Pain
    {spell = 367416, instance = 2441, continent = SHADOWLANDS}, -- Tazavesh the Veiled Market
    {spell = 373190, instance = 2296, continent = SHADOWLANDS}, -- Castle Nathria
    {spell = 373191, instance = 2450, continent = SHADOWLANDS}, -- Sanctum of Domination
    {spell = 373192, instance = 2481, continent = SHADOWLANDS}, -- Sepulcher of the First Ones
    {spell = 410071, instance = 1754, continent = KUL_TIRAS}, -- Freehold
    {spell = 424187, instance = 1763, continent = ZANDALAR}, -- Atal'Dazar
    {spell = 373274, instance = 2097, continent = KUL_TIRAS}, -- Operation: Mechagon
    {spell = 424167, instance = 1862, continent = KUL_TIRAS}, -- Waycrest Manor
    {spell = 410074, instance = 1841, continent = ZANDALAR}, -- The Underrot
    {spell = 373262, instance = 532, continent = EASTERN_KINGDOMS}, -- Karazhan
    {spell = 393764, instance = 1477, continent = BROKEN_ISLES}, -- Halls of Valor
    {spell = 393766, instance = 1571, continent = BROKEN_ISLES}, -- Court of Stars
    {spell = 410078, instance = 1458, continent = BROKEN_ISLES}, -- Neltharion's Lair
    {spell = 424153, instance = 1501, continent = BROKEN_ISLES}, -- Black Rook Hold
    {spell = 424163, instance = 1466, continent = BROKEN_ISLES}, -- Darkheart Thicket
    {spell = 159895, instance = 1175, continent = DRAENOR}, -- Bloodmaul Slag Mines
    {spell = 159896, instance = 1195, continent = DRAENOR}, -- Iron Docks
    {spell = 159897, instance = 1182, continent = DRAENOR}, -- Auchindoun
    {spell = 159898, instance = 1209, continent = DRAENOR}, -- Skyreach
    {spell = 159899, instance = 1176, continent = DRAENOR}, -- Shadowmoon Burial Grounds
    {spell = 159900, instance = 1208, continent = DRAENOR}, -- Grimrail Depot
    {spell = 159901, instance = 1279, continent = DRAENOR}, -- The Everbloom
    {spell = 131204, instance = 960, continent = PANDARIA}, -- Temple of the Jade Serpent
    {spell = 131205, instance = 961, continent = PANDARIA}, -- Stormstout Brewery
    {spell = 131206, instance = 959, continent = PANDARIA}, -- Shado-Pan Monastery
    {spell = 131222, instance = 994, continent = PANDARIA}, -- Mogu'shan Palace
    {spell = 131225, instance = 962, continent = PANDARIA}, -- Gate of the Setting Sun
    {spell = 131228, instance = 1011, continent = PANDARIA}, -- Siege of Niuzao Temple
    {spell = 410080, instance = 657, continent = KALIMDOR}, -- The Vortex Pinnacle
    {spell = 424142, instance = 643, continent = EASTERN_KINGDOMS}, -- Throne of the Tides
    {spell = 131229, instance = 1004, continent = EASTERN_KINGDOMS}, -- Scarlet Monastery
    {spell = 131231, instance = 1001, continent = EASTERN_KINGDOMS}, -- Scarlet Halls
    {spell = 131232, instance = 1007, continent = EASTERN_KINGDOMS}, -- Scholomance
    {spell = 159902, instance = 1358, continent = EASTERN_KINGDOMS}, -- Upper Blackrock Spire

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