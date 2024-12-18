local core_mainmenu = require("core_mainmenu")
local lib_helpers = require("solylib.helpers")
local lib_characters = require("solylib.characters")
local lib_unitxt = require("solylib.unitxt")
local lib_items = require("solylib.items.items")
local lib_items_list = require("solylib.items.items_list")
local lib_items_cfg = require("solylib.items.items_configuration")
local lib_menu = require("solylib.menu")
local cfg = require("Damage Analysis.configuration")
local cfgMonsters = require("Damage Analysis.monsters")
local optionsLoaded, options = pcall(require, "Damage Analysis.options")
local drop_charts = {
  ["Normal"] = require("Damage Analysis/Drops.normal"),
  ["Hard"] = require("Damage Analysis/Drops.hard"),
  ["Very Hard"] = require("Damage Analysis/Drops.very-hard"),
  ["Ultimate"] = require("Damage Analysis/Drops.ultimate")
}

local optionsFileName = "addons/Damage Analysis/options.lua"
local firstPresent = {
	foRec   = true,
	rate    = true,
	room    = true,
	target  = true,
	target2 = true,
}
local ConfigurationWindow

if optionsLoaded then
    -- If options loaded, make sure we have all those we need
    options.configurationEnableWindow = lib_helpers.NotNilOrDefault(options.configurationEnableWindow, true)
    options.enable                    = lib_helpers.NotNilOrDefault(options.enable, true)
	options.reso4K					  = lib_helpers.NotNilOrDefault(options.reso4K, false)
	options.ShowRares 	     		  = lib_helpers.NotNilOrDefault(options.ShowRares , true)
	options.ShowMonsterName     	  = lib_helpers.NotNilOrDefault(options.ShowMonsterName, true)
	options.ShowHealthBar     	      = lib_helpers.NotNilOrDefault(options.ShowHealthBar, true)

	options.targetEnableWindow        = lib_helpers.NotNilOrDefault(options.targetEnableWindow, true)
	options.ShowDamage   	     	  = lib_helpers.NotNilOrDefault(options.ShowDamage , true)
	options.ShowHit 	     		  = lib_helpers.NotNilOrDefault(options.ShowHit , true)
    options.targetChanged             = lib_helpers.NotNilOrDefault(options.targetChanged, false)
    options.targetAnchor              = lib_helpers.NotNilOrDefault(options.targetAnchor, 6)
    options.targetX                   = lib_helpers.NotNilOrDefault(options.targetX, 0)
    options.targetY                   = lib_helpers.NotNilOrDefault(options.targetY, -240)
    options.targetW                   = lib_helpers.NotNilOrDefault(options.targetW, 285)
    options.targetH                   = lib_helpers.NotNilOrDefault(options.targetH, 190)
    options.targetNoTitleBar          = lib_helpers.NotNilOrDefault(options.targetNoTitleBar, "NoTitleBar")
    options.targetNoResize            = lib_helpers.NotNilOrDefault(options.targetNoResize, "NoResize")
    options.targetNoMove              = lib_helpers.NotNilOrDefault(options.targetNoMove, "NoMove")
    options.targetNoScrollbar         = lib_helpers.NotNilOrDefault(options.targetNoScrollbar, "NoScrollbar")
    options.targetTransparentWindow   = lib_helpers.NotNilOrDefault(options.targetTransparentWindow, false)
    options.targetHardThreshold       = lib_helpers.NotNilOrDefault(options.targetHardThreshold, 90)
	options.targetSpecialThreshold    = lib_helpers.NotNilOrDefault(options.targetSpecialThreshold, 90)
	
	options.mhpEnableWindow				= lib_helpers.NotNilOrDefault(options.mhpEnableWindow, true)
	options.invertMonsterList         	= lib_helpers.NotNilOrDefault(options.invertMonsterList, false)
    options.showCurrentRoomOnly       	= lib_helpers.NotNilOrDefault(options.showCurrentRoomOnly, true)
	options.showMonsterResist         	= lib_helpers.NotNilOrDefault(options.showMonsterResist, true)
    options.showMonsterStatus         	= lib_helpers.NotNilOrDefault(options.showMonsterStatus, true)
    options.showMonsterID             	= lib_helpers.NotNilOrDefault(options.showMonsterID, true)
    options.customRareMonsterColorEnabled = lib_helpers.NotNilOrDefault(options.customRareMonsterColorEnabled, true)
    options.customRareMonsterSpeed     	= lib_helpers.NotNilOrDefault(options.customRareMonsterSpeed, 15)
    options.customRareMonsterColorStart	= lib_helpers.NotNilOrDefault(options.customRareMonsterColorStart, 0xFFBF5814)
    options.customRareMonsterColorEnd	= lib_helpers.NotNilOrDefault(options.customRareMonsterColorEnd,   0xFFFCAA33)
	options.mhpHideWhenMenu           	= lib_helpers.NotNilOrDefault(options.mhpHideWhenMenu, true)
    options.mhpHideWhenSymbolChat     	= lib_helpers.NotNilOrDefault(options.mhpHideWhenSymbolChat, true)
    options.mhpHideWhenMenuUnavailable	= lib_helpers.NotNilOrDefault(options.mhpHideWhenMenuUnavailable, true)
    options.mhpChanged           		= lib_helpers.NotNilOrDefault(options.mhpChanged, false)
    options.mhpAnchor            		= lib_helpers.NotNilOrDefault(options.mhpAnchor, 4)
    options.mhpX                 		= lib_helpers.NotNilOrDefault(options.mhpX, 0)
    options.mhpY                 		= lib_helpers.NotNilOrDefault(options.mhpY, 55)
    options.mhpW                 		= lib_helpers.NotNilOrDefault(options.mhpW, 900)
    options.mhpH                 		= lib_helpers.NotNilOrDefault(options.mhpH, 200)
    options.mhpNoTitleBar        		= lib_helpers.NotNilOrDefault(options.mhpNoTitleBar, "NoTitleBar")
    options.mhpNoResize          		= lib_helpers.NotNilOrDefault(options.mhpNoResize, "")
    options.mhpNoMove            		= lib_helpers.NotNilOrDefault(options.mhpNoMove, "")
    options.mhpTransparentWindow 		= lib_helpers.NotNilOrDefault(options.mhpTransparentWindow, true)
	
	options.foRecEnableWindow        = lib_helpers.NotNilOrDefault(options.foRecEnableWindow, true)
	options.foRecShowEfficiencyBased = lib_helpers.NotNilOrDefault(options.foRecShowEfficiencyBased, false)
	options.foRecShowDamage	 		 = lib_helpers.NotNilOrDefault(options.foRecShowDamage, true)
    options.foRecChanged             = lib_helpers.NotNilOrDefault(options.foRecChanged, false)
    options.foRecAnchor              = lib_helpers.NotNilOrDefault(options.foRecAnchor, 6)
    options.foRecX                   = lib_helpers.NotNilOrDefault(options.foRecX, -280)
    options.foRecY                   = lib_helpers.NotNilOrDefault(options.foRecY, -300)
    options.foRecW                   = lib_helpers.NotNilOrDefault(options.foRecW, 270)
    options.foRecH                   = lib_helpers.NotNilOrDefault(options.foRecH, 150)
    options.foRectNoTitleBar         = lib_helpers.NotNilOrDefault(options.foRecNoTitleBar, "NoTitleBar")
    options.foRecNoResize            = lib_helpers.NotNilOrDefault(options.foRecNoResize, "NoResize")
    options.foRecNoMove              = lib_helpers.NotNilOrDefault(options.foRecNoMove, "NoMove")
    options.foRecNoScrollbar         = lib_helpers.NotNilOrDefault(options.foRecNoScrollbar, "NoScrollbar")
    options.foRecTransparentWindow   = lib_helpers.NotNilOrDefault(options.foRecTransparentWindow, false)
	
	options.target2EnableWindow        = lib_helpers.NotNilOrDefault(options.target2EnableWindow, true)
    options.target2Changed             = lib_helpers.NotNilOrDefault(options.target2Changed, false)
    options.target2Anchor              = lib_helpers.NotNilOrDefault(options.target2Anchor, 6)
    options.target2X                   = lib_helpers.NotNilOrDefault(options.target2X, 215)
    options.target2Y                   = lib_helpers.NotNilOrDefault(options.target2Y, -275)
    options.target2W                   = lib_helpers.NotNilOrDefault(options.target2W, 145)
    options.target2H                   = lib_helpers.NotNilOrDefault(options.target2H, 130)
    options.targe2tNoTitleBar          = lib_helpers.NotNilOrDefault(options.target2NoTitleBar, "NoTitleBar")
    options.target2NoResize            = lib_helpers.NotNilOrDefault(options.target2NoResize, "NoResize")
    options.target2NoMove              = lib_helpers.NotNilOrDefault(options.target2NoMove, "NoMove")
    options.target2NoScrollbar         = lib_helpers.NotNilOrDefault(options.target2NoScrollbar, "NoScrollbar")
    options.target2TransparentWindow   = lib_helpers.NotNilOrDefault(options.target2TransparentWindow, false)
	
	options.RateEnableWindow          = lib_helpers.NotNilOrDefault(options.RateEnableWindow, true)
    options.RateChanged               = lib_helpers.NotNilOrDefault(options.RateChanged, false)
    options.RateAnchor                = lib_helpers.NotNilOrDefault(options.RateAnchor, 6)
    options.RateX                     = lib_helpers.NotNilOrDefault(options.RateX, 350)
    options.RateY                     = lib_helpers.NotNilOrDefault(options.RateY, -240)
    options.RateW                     = lib_helpers.NotNilOrDefault(options.RateW, 120)
    options.RateH                     = lib_helpers.NotNilOrDefault(options.RateH, 170)
    options.targe2tNoTitleBar         = lib_helpers.NotNilOrDefault(options.RateNoTitleBar, "NoTitleBar")
    options.RateNoResize              = lib_helpers.NotNilOrDefault(options.RateNoResize, "NoResize")
    options.RateNoMove                = lib_helpers.NotNilOrDefault(options.RateNoMove, "NoMove")
    options.RateNoScrollbar           = lib_helpers.NotNilOrDefault(options.RateNoScrollbar, "NoScrollbar")
    options.RateTransparentWindow     = lib_helpers.NotNilOrDefault(options.RateTransparentWindow, false)
	options.RateEnableActivationRates = lib_helpers.NotNilOrDefault(options.RateEnableActivationRates, true)
	
	 if options.RateEnableActivationRateItems == nil or type(options.RateEnableActivationRateItems) ~= "table" then
        options.RateEnableActivationRateItems = {}
    end
    options.RateEnableActivationRateItems.Hell     = lib_helpers.NotNilOrDefault(options.RateEnableActivationRateItems.hell, true)
    options.RateEnableActivationRateItems.Dark     = lib_helpers.NotNilOrDefault(options.RateEnableActivationRateItems.dark, true)
    options.RateEnableActivationRateItems.Blizzard = lib_helpers.NotNilOrDefault(options.RateEnableActivationRateItems.blizzard, true)
    options.RateEnableActivationRateItems.Arrest   = lib_helpers.NotNilOrDefault(options.RateEnableActivationRateItems.arrest, true)
    options.RateEnableActivationRateItems.Seize    = lib_helpers.NotNilOrDefault(options.RateEnableActivationRateItems.seize, true)
    options.RateEnableActivationRateItems.Chaos    = lib_helpers.NotNilOrDefault(options.RateEnableActivationRateItems.chaos, true)
    options.RateEnableActivationRateItems.Havoc    = lib_helpers.NotNilOrDefault(options.RateEnableActivationRateItems.havoc, true)
    
else
    options =
    {
        configurationEnableWindow = true,
        enable = true,
		reso4K = false,
		ShowRares = true,
		ShowMonsterName = true,
		ShowHealthBar = true,
		
		targetEnableWindow = true,
		ShowDamage = true,
		ShowHit = true,
        targetChanged = false,
        targetAnchor = 6,
        targetX = 0,
        targetY = -240,
        targetW = 285,
        targetH = 190,
        targetNoTitleBar = "NoTitleBar",
        targetNoResize = "NoResize",
        targetNoMove = "NoMove",
        targetNoScrollbar = "NoScrollbar",
        targetTransparentWindow = false,
        targetHardThreshold = 90,
		targetSpecialThreshold = 90,
		
		mhpEnableWindow = true,
		invertMonsterList = false,
        showCurrentRoomOnly = true,
		showMonsterResist = true,
        showMonsterStatus = true,
        showMonsterID = true,
		customRareMonsterColorEnabled = true,
		customRareMonsterSpeed = 15,
		customRareMonsterColorStart = 0xFFBF5814,
		customRareMonsterColorEnd = 0xFFFCAA33,
		mhpHideWhenMenu = true,
        mhpHideWhenSymbolChat = true,
        mhpHideWhenMenuUnavailable = true,
        mhpChanged = false,
        mhpAnchor = 4,
        mhpX = 0,
        mhpY = 55,
        mhpW = 900,
        mhpH = 200,
        mhpNoTitleBar = "NoTitleBar",
        mhpNoResize = "",
        mhpNoMove = "",
        mhpTransparentWindow = true,
		
		foRecEnableWindow = true,
		foRecShowEfficiencyBased = false,
		foRecShowDamage = true,
        foRecChanged = false,
        foRecAnchor = 6,
        foRecX = -280,
        foRecY = -300,
        foRecW = 270,
        foRecH = 150,
        foRecNoTitleBar = "NoTitleBar",
        foRecNoResize = "NoResize",
        foRecNoMove = "NoMove",
        foRecNoScrollbar = "NoScrollbar",
        foRecTransparentWindow = false,
		
		target2EnableWindow = true,
        target2Changed = false,
        target2Anchor = 6,
        target2X = 215,
        target2Y = -275,
        target2W = 145,
        target2H = 130,
        target2NoTitleBar = "NoTitleBar",
        target2NoResize = "NoResize",
        target2NoMove = "NoMove",
        target2NoScrollbar = "NoScrollbar",
        target2TransparentWindow = false,
		
		RateEnableWindow = true,
        RateChanged = false,
        RateAnchor = 6,
        RateX = 350,
        RateY = -240,
        RateW = 120,
        RateH = 170,
        RateNoTitleBar = "NoTitleBar",
        RateNoResize = "NoResize",
        RateNoMove = "NoMove",
        RateNoScrollbar = "NoScrollbar",
        RateTransparentWindow = false,
		RateEnableActivationRates = true,
        RateEnableActivationRateItems = {
            hell = true,
            dark = true,
            blizzard = true,
            arrest = true,
            seize = true,
            chaos = true,
            havoc = true,
        },

    }
end

local function SaveOptions(options)
    local file = io.open(optionsFileName, "w")
    if file ~= nil then
        io.output(file)

        io.write("return\n")
        io.write("{\n")
        io.write(string.format("    configurationEnableWindow = %s,\n", tostring(options.configurationEnableWindow)))
        io.write(string.format("    enable = %s,\n", tostring(options.enable)))
		io.write(string.format("    reso4K = %s,\n", tostring(options.reso4K)))
		io.write(string.format("    ShowRares = %s,\n", tostring(options.ShowRares)))
		io.write(string.format("    ShowMonsterName = %s,\n", tostring(options.ShowMonsterName)))
		io.write(string.format("    ShowHealthBar = %s,\n", tostring(options.ShowHealthBar)))
        io.write("\n")
		io.write(string.format("    targetEnableWindow = %s,\n", tostring(options.targetEnableWindow)))
		io.write(string.format("    ShowDamage = %s,\n", tostring(options.ShowDamage)))
		io.write(string.format("    ShowHit = %s,\n", tostring(options.ShowHit)))
        io.write(string.format("    targetChanged = %s,\n", tostring(options.targetChanged)))
        io.write(string.format("    targetAnchor = %i,\n", options.targetAnchor))
        io.write(string.format("    targetX = %i,\n", options.targetX))
        io.write(string.format("    targetY = %i,\n", options.targetY))
        io.write(string.format("    targetW = %i,\n", options.targetW))
        io.write(string.format("    targetH = %i,\n", options.targetH))
        io.write(string.format("    targetNoTitleBar = \"%s\",\n", options.targetNoTitleBar))
        io.write(string.format("    targetNoResize = \"%s\",\n", options.targetNoResize))
        io.write(string.format("    targetNoMove = \"%s\",\n", options.targetNoMove))
        io.write(string.format("    targetNoScrollbar = \"%s\",\n", options.targetNoScrollbar))
        io.write(string.format("    targetTransparentWindow = %s,\n", tostring(options.targetTransparentWindow)))
        io.write(string.format("    targetHardThreshold = %s,\n", tostring(options.targetHardThreshold)))
		io.write(string.format("    targetSpecialThreshold = %s,\n", tostring(options.targetSpecialThreshold)))
		io.write("\n")
        io.write(string.format("    mhpEnableWindow = %s,\n", tostring(options.mhpEnableWindow)))
		io.write(string.format("    invertMonsterList = %s,\n", tostring(options.invertMonsterList)))
        io.write(string.format("    showCurrentRoomOnly = %s,\n", tostring(options.showCurrentRoomOnly)))
		io.write(string.format("    showMonsterResist = %s,\n", tostring(options.showMonsterResist)))
        io.write(string.format("    showMonsterStatus = %s,\n", tostring(options.showMonsterStatus)))
        io.write(string.format("    showMonsterID = %s,\n", tostring(options.showMonsterID)))
        io.write(string.format("    customRareMonsterColorEnabled = %s,\n", tostring(options.customRareMonsterColorEnabled)))
        io.write(string.format("    customRareMonsterSpeed = %s,\n", tostring(options.customRareMonsterSpeed)))
        io.write(string.format("    customRareMonsterColorStart = %s,\n", tostring(options.customRareMonsterColorStart)))
        io.write(string.format("    customRareMonsterColorEnd = %s,\n", tostring(options.customRareMonsterColorEnd)))
		io.write(string.format("    mhpHideWhenMenu = %s,\n", tostring(options.mhpHideWhenMenu)))
        io.write(string.format("    mhpHideWhenSymbolChat = %s,\n", tostring(options.mhpHideWhenSymbolChat)))
        io.write(string.format("    mhpHideWhenMenuUnavailable = %s,\n", tostring(options.mhpHideWhenMenuUnavailable)))
        io.write(string.format("    mhpChanged = %s,\n", tostring(options.mhpChanged)))
        io.write(string.format("    mhpAnchor = %i,\n", options.mhpAnchor))
        io.write(string.format("    mhpX = %i,\n", options.mhpX))
        io.write(string.format("    mhpY = %i,\n", options.mhpY))
        io.write(string.format("    mhpW = %i,\n", options.mhpW))
        io.write(string.format("    mhpH = %i,\n", options.mhpH))
        io.write(string.format("    mhpNoTitleBar = \"%s\",\n", options.mhpNoTitleBar))
        io.write(string.format("    mhpNoResize = \"%s\",\n", options.mhpNoResize))
        io.write(string.format("    mhpNoMove = \"%s\",\n", options.mhpNoMove))
        io.write(string.format("    mhpTransparentWindow = %s,\n", tostring(options.mhpTransparentWindow)))
		io.write("\n")
		io.write(string.format("    foRecEnableWindow = %s,\n", tostring(options.foRecEnableWindow)))
		io.write(string.format("    foRecShowEfficiencyBased = %s,\n", tostring(options.foRecShowEfficiencyBased)))
		io.write(string.format("    foRecShowDamage = %s,\n", tostring(options.foRecShowDamage)))
        io.write(string.format("    foRecChanged = %s,\n", tostring(options.foRecChanged)))
        io.write(string.format("    foRecAnchor = %i,\n", options.foRecAnchor))
        io.write(string.format("    foRecX = %i,\n", options.foRecX))
        io.write(string.format("    foRecY = %i,\n", options.foRecY))
        io.write(string.format("    foRecW = %i,\n", options.foRecW))
        io.write(string.format("    foRecH = %i,\n", options.foRecH))
        io.write(string.format("    foRecNoTitleBar = \"%s\",\n", options.foRecNoTitleBar))
        io.write(string.format("    foRecNoResize = \"%s\",\n", options.foRecNoResize))
        io.write(string.format("    foRecNoMove = \"%s\",\n", options.foRecNoMove))
        io.write(string.format("    foRecNoScrollbar = \"%s\",\n", options.foRecNoScrollbar))
        io.write(string.format("    foRecTransparentWindow = %s,\n", tostring(options.foRecTransparentWindow)))
		io.write("\n")
		io.write(string.format("    target2EnableWindow = %s,\n", tostring(options.target2EnableWindow)))
        io.write(string.format("    target2Changed = %s,\n", tostring(options.target2Changed)))
        io.write(string.format("    target2Anchor = %i,\n", options.target2Anchor))
        io.write(string.format("    target2X = %i,\n", options.target2X))
        io.write(string.format("    target2Y = %i,\n", options.target2Y))
        io.write(string.format("    target2W = %i,\n", options.target2W))
        io.write(string.format("    target2H = %i,\n", options.target2H))
        io.write(string.format("    target2NoTitleBar = \"%s\",\n", options.target2NoTitleBar))
        io.write(string.format("    target2NoResize = \"%s\",\n", options.target2NoResize))
        io.write(string.format("    target2NoMove = \"%s\",\n", options.target2NoMove))
        io.write(string.format("    target2NoScrollbar = \"%s\",\n", options.target2NoScrollbar))
        io.write(string.format("    target2TransparentWindow = %s,\n", tostring(options.target2TransparentWindow)))
		io.write("\n")
		io.write(string.format("    RateEnableWindow = %s,\n", tostring(options.RateEnableWindow)))
        io.write(string.format("    RateChanged = %s,\n", tostring(options.RateChanged)))
        io.write(string.format("    RateAnchor = %i,\n", options.RateAnchor))
        io.write(string.format("    RateX = %i,\n", options.RateX))
        io.write(string.format("    RateY = %i,\n", options.RateY))
        io.write(string.format("    RateW = %i,\n", options.RateW))
        io.write(string.format("    RateH = %i,\n", options.RateH))
        io.write(string.format("    RateNoTitleBar = \"%s\",\n", options.RateNoTitleBar))
        io.write(string.format("    RateNoResize = \"%s\",\n", options.RateNoResize))
        io.write(string.format("    RateNoMove = \"%s\",\n", options.RateNoMove))
        io.write(string.format("    RateNoScrollbar = \"%s\",\n", options.RateNoScrollbar))
        io.write(string.format("    RateTransparentWindow = %s,\n", tostring(options.RateTransparentWindow)))
		io.write(string.format("    RateEnableActivationRates = %s,\n", tostring(options.RateEnableActivationRates)))
		io.write(string.format("    RateEnableActivationRateItems = {\n"))
        io.write(string.format("        hell = %s,\n", options.RateEnableActivationRateItems.hell))
        io.write(string.format("        dark = %s,\n", options.RateEnableActivationRateItems.dark))
        io.write(string.format("        blizzard = %s,\n", options.RateEnableActivationRateItems.blizzard))
        io.write(string.format("        arrest = %s,\n", options.RateEnableActivationRateItems.arrest))
        io.write(string.format("        seize = %s,\n", options.RateEnableActivationRateItems.seize))
        io.write(string.format("        chaos = %s,\n", options.RateEnableActivationRateItems.chaos))
        io.write(string.format("        havoc = %s,\n", options.RateEnableActivationRateItems.havoc))
        io.write(string.format("    },\n"))
        io.write("}\n")

        io.close(file)
    end
end

local function splitDropChartTargets()
    local dt = {}
    for difficulty, charts in pairs(drop_charts) do
        dt[difficulty] = {}
        for episode, chart in pairs(charts) do
            dt[difficulty][episode] = {}
            for sectionid, section_sub in pairs(chart) do
                dt[difficulty][episode][sectionid] = {}

                for targets, drops in pairs(section_sub) do
                    for target in string.gmatch(targets, "[^/]+") do
                        dt[difficulty][episode][sectionid][target] = drops
                    end
                end

            end
        end
    end
    drop_charts = dt
end
splitDropChartTargets()

-- section id list 
local section = {
	"BLUEFULL",
	"GREENILL",
	"ORAN",
	"PINKAL",
	"PURPLENUM",
	"REDRIA",
	"SKYLY",
	"VIRIDIA",
	"YELLOWBOZE",
	"WHITILL"
	}
-- section id colors
local section_color = {
	["BLUEFULL"]    = 0xFF0088F4,
	["GREENILL"]    = 0xFF74FB40,
	["ORAN"]        = 0xFFFFAA00,
	["PINKAL"]      = 0xFFFF3898,
	["PURPLENUM"]   = 0xFFA020F0,
	["REDRIA"]      = 0xFFFF2031,
	["SKYLY"]       = 0xFF00DDF4,
	["VIRIDIA"]     = 0xFF00AE6C,
	["YELLOWBOZE"]  = 0xFFEAF718,
	["WHITILL"]     = 0xFFFFFFFF
}

local episodes = {
  [0] = "EPISODE 1",
  [1] = "EPISODE 2",
  [2] = "EPISODE 4"
}

-- episode order
local episode = {
  "EPISODE 1",
  "EPISODE 1 BOXES",
  "EPISODE 2",
  "EPISODE 2 BOXES",
  "EPISODE 4",
  "EPISODE 4 BOXES",
  "QUEST"
}

-- difficulty list
local difficulty = {
  [1] = "Normal",
  [2] = "Hard",
  [3] = "Very Hard",
  [4] = "Ultimate"
}

-- memory addresses
local _SideMessage = pso.base_address + 0x006AECC8
local _PlayerArray = 0x00A94254
local _PlayerIndex = 0x00A9C4F4
local _PlayerCount = 0x00AAE168
local _Difficulty = 0x00A9CD68
local _Ultimate
local _Episode = 0xAAFDB8
local _Episode2 = 0x00A9B1C8

local party = { }
local cacheSide = false

local _ID = 0x1C
local _Room = 0x28
local _Room2 = 0x2E
local _PosX = 0x38
local _PosY = 0x3C
local _PosZ = 0x40

local _targetPointerOffset = 0x18
local _targetOffset = 0x108C

local _EntityCount = 0x00AAE164
local _EntityArray = 0

local _MonsterUnitxtID = 0x378
local _MonsterHP = 0x334
local _MonsterHPMax = 0x2BC
local _MonsterEvp = 0x2D0
local _MonsterAtp = 0x2CC
local _MonsterDfp = 0x2D2
local _MonsterMst = 0x2BE
local _MonsterAta = 0x2D4
local _MonsterLck = 0x2D6
local _MonsterEfr = 0x2F6
local _MonsterEth = 0x2F8
local _MonsterEic = 0x2FA
local _MonsterEdk = 0x2FC
local _MonsterElt = 0x2FE

local _MonsterBpPtr = 0x2B4
local _MonsterBpAtp = 0x0
local _MonsterBpMst = 0x2
local _MonsterBpEvp = 0x4
local _MonsterBpHp  = 0x6
local _MonsterBpDfp = 0x8
local _MonsterBpAta = 0xA
local _MonsterBpLck = 0xC
local _MonsterBpEsp = 0xE
local _MonsterBpExp = 0x1C

-- Special addresses for De Rol Le
local _BPDeRolLeData = 0x00A43CC8
local _MonsterDeRolLeHP = 0x6B4
local _MonsterDeRolLeHPMax = 0x6B0
local _MonsterDeRolLeSkullHP = 0x6B8
local _MonsterDeRolLeSkullHPMax = 0x20
local _MonsterDeRolLeShellHP = 0x39C
local _MonsterDeRolLeShellHPMax = 0x1C

-- Special addresses for Barba Ray
local _BPBarbaRayData = 0x00A43CC8
local _MonsterBarbaRayHP = 0x704
local _MonsterBarbaRayHPMax = 0x700
local _MonsterBarbaRaySkullHP = 0x708
local _MonsterBarbaRaySkullHPMax = 0x20
local _MonsterBarbaRayShellHP = 0x7AC
local _MonsterBarbaRayShellHPMax = 0x1C

-- Special address for Ephinea
local _ephineaMonsterArrayPointer = 0x00B5F800
local _ephineaMonsterHPScale = 0x00B5F804

-- read side message from memory buffer
local function get_side_text()
	local ptr = pso.read_u32(_SideMessage)
	if ptr ~= 0 then
		local text = pso.read_wstr(ptr + 0x14, 0xFF)
		return text
	end
	return ""
end

-- extract party dar, rare boosts, section id, and grab episode and difficulty
local function parse_side_message(text)
	local data = { }

	-- logic in identifying dar and rare boost
    local dropIndex = string.find(text, "Drop")
	local rareIndex = string.find(text, "Rare")
	local dropRareFormated  = string.find(text, "Drop/Rare")
	local idIndex = string.find(text, "ID")

	local dropStr,rareStr
	if dropRareFormated then
		local dropRareStr = string.sub(text, dropRareFormated,-1)
		for k,v in string.gmatch(dropRareStr, ":(.*)") do
			dropRareStr = k
			break
		end
		local i = 1
		for k,v in string.gmatch(dropRareStr, "(%d+)") do
			if i == 1 then
				dropStr = k
			elseif i == 2 then
				rareStr = k
			else
				break
			end
			i = i + 1
		end
	else
		dropStr = string.sub(text, dropIndex, rareIndex-1)
		rareStr = string.sub(text, rareIndex, -1)
	end

	local idStr = string.sub(text, idIndex+2, dropIndex-1)

	-- other data
	local _difficulty = pso.read_u32(_Difficulty)
	local _episode = pso.read_u32(_Episode2)
	
    data.dar  = tonumber(string.match(dropStr, "%d+"))
    data.rare = tonumber(string.match(rareStr, "%d+"))
    data.id   = string.upper( string.match(idStr,"%a+") )
    data.difficulty = difficulty[_difficulty + 1]
    data.episode = episodes[_episode]

	if data.dar == nil then
		data.dar = -1
	end
	if data.rare == nil then
		data.rare = -1
	end
	if data.id == nil then
		data.id = -1
	end
	if data.difficulty == nil then
		data.difficulty = -1
	end
	if data.episode == nil then
		data.episode = -1
	end
	
	return data
end

local function refresh_side_text()
	local side = get_side_text()
	if string.find(side, "ID") and string.find(side, "Drop") and string.find(side, "Rare") then
		party = parse_side_message(side)
		cacheSide = true
	end
end

local function CopyMonster(monster)
    local copy = {}

    copy.address  = monster.address
    copy.index    = monster.index
    copy.id       = monster.id
    copy.room     = monster.room
    copy.posX     = monster.posX
    copy.posY     = monster.posY
    copy.posZ     = monster.posZ
    copy.unitxtID = monster.unitxtID
    copy.HP       = monster.HP
    copy.HPMax    = monster.HPMax
    copy.HP2      = monster.HP2
    copy.HP2Max   = monster.HP2Max
    copy.name     = monster.name
	copy.attribute  = monster.attribute
	copy.isBoss   = monster.isBoss
	copy.part     = monster.part
	copy.Exp      = monster.Exp
    copy.color    = monster.color
    copy.display  = monster.display
	copy.Efr	  = monster.Efr
	copy.Eth	  = monster.Eth
	copy.Eic	  = monster.Eic
	copy.Elt	  = monster.Elt
	copy.Edk	  = monster.Edk

    return copy
end

local function GetMonsterDataDeRolLe(monster)
    local maxDataPtr = pso.read_u32(_BPDeRolLeData)
    local skullMaxHP = 0
    local shellMaxHP = 0
    local newName = monster.name
	local ephineaMonsters = pso.read_u32(_ephineaMonsterArrayPointer)
	local ephineaHPScale = 1.0
	
    if maxDataPtr ~= 0 then
        skullMaxHP = pso.read_u32(maxDataPtr + _MonsterDeRolLeSkullHPMax)
        shellMaxHP = pso.read_u32(maxDataPtr + _MonsterDeRolLeShellHPMax)
		if ephineaMonsters ~= 0 then
			ephineaHPScale = pso.read_f64(_ephineaMonsterHPScale)
			skullMaxHP = math.floor(skullMaxHP * ephineaHPScale)
			shellMaxHP = math.floor(shellMaxHP * ephineaHPScale)
		end
    end

    if monster.index == 0 then
        monster.HP = pso.read_u32(monster.address + _MonsterDeRolLeHP)
        monster.HPMax = pso.read_u32(monster.address + _MonsterDeRolLeHPMax)

        monster.HP2 = pso.read_u32(monster.address + _MonsterDeRolLeSkullHP)
        monster.HP2Max = skullMaxHP
		monster.part = 0
    else
        monster.HP = pso.read_u32(monster.address + _MonsterDeRolLeShellHP)
        monster.HPMax = shellMaxHP
        monster.name = monster.name .. " Shell"
		monster.part = 2
    end

    return monster
end

local function GetMonsterDataBarbaRay(monster)
    local maxDataPtr = pso.read_u32(_BPBarbaRayData)
    local skullMaxHP = 0
    local shellMaxHP = 0
    local newName = monster.name
	local ephineaMonsters = pso.read_u32(_ephineaMonsterArrayPointer)
	local ephineaHPScale = 1.0

    if maxDataPtr ~= 0 then
        skullMaxHP = pso.read_u32(maxDataPtr + _MonsterBarbaRaySkullHPMax)
        shellMaxHP = pso.read_u32(maxDataPtr + _MonsterBarbaRayShellHPMax)
		if ephineaMonsters ~= 0 then
			ephineaHPScale = pso.read_f64(_ephineaMonsterHPScale)
			skullMaxHP = math.floor(skullMaxHP * ephineaHPScale)
			shellMaxHP = math.floor(shellMaxHP * ephineaHPScale)
		end
    end

    if monster.index == 0 then
        monster.HP = pso.read_u32(monster.address + _MonsterBarbaRayHP)
        monster.HPMax = pso.read_u32(monster.address + _MonsterBarbaRayHPMax)

        monster.HP2 = pso.read_u32(monster.address + _MonsterBarbaRaySkullHP)
        monster.HP2Max = skullMaxHP
		monster.part = 0
    else
        monster.HP = pso.read_u32(monster.address + _MonsterBarbaRayShellHP)
        monster.HPMax = shellMaxHP
        monster.name = monster.name .. " Shell"
		monster.part = 2
    end

    return monster
end

local function GetMonsterData(monster)
    local ephineaMonsters = pso.read_u32(_ephineaMonsterArrayPointer)
	
    monster.id = pso.read_u16(monster.address + _ID)
    monster.unitxtID = pso.read_u32(monster.address + _MonsterUnitxtID)

	monster.HP = 0
	monster.HPMax = 0

	monster.isBoss = 0
	
	if monster.name == "Unknown" then
		return monster
	end
	
	if ephineaMonsters ~= 0 then
		monster.HPMax = pso.read_u32(ephineaMonsters + (monster.id * 32))
		monster.HP = pso.read_u32(ephineaMonsters + (monster.id * 32) + 0x04)
	else
		monster.HP = pso.read_u16(monster.address + _MonsterHP)
		monster.HPMax = pso.read_u16(monster.address + _MonsterHPMax)
	end	
	
    local bpPointer = pso.read_u32(monster.address + _MonsterBpPtr)
    
	monster.Atp = pso.read_u16(monster.address + _MonsterAtp) or pso.read_u16(bpPointer + _MonsterBpAtp)
    monster.Dfp = pso.read_u16(monster.address + _MonsterDfp) or pso.read_u16(bpPointer + _MonsterBpDfp)
    monster.Evp = pso.read_u16(monster.address + _MonsterEvp) or pso.read_u16(bpPointer + _MonsterBpEvp)
    monster.Mst = pso.read_u16(monster.address + _MonsterMst) or pso.read_u16(bpPointer + _MonsterBpMst)
    monster.Ata = pso.read_u16(monster.address + _MonsterAta) or pso.read_u16(bpPointer + _MonsterBpAta)
    monster.Lck = pso.read_u16(monster.address + _MonsterLck) or pso.read_u16(bpPointer + _MonsterBpLck)
    
    if bpPointer ~= 0 then
        monster.Esp = pso.read_u16(bpPointer + _MonsterBpEsp)

        if  pso.read_u32(_Episode) == 1 then
			monster.Exp = pso.read_u16(bpPointer + _MonsterBpExp) * 1.3
		else
			monster.Exp = pso.read_u16(bpPointer + _MonsterBpExp)
		end
    else
        monster.Esp = 0
        monster.Exp = 0
    end

    monster.Efr = pso.read_u16(monster.address + _MonsterEfr)
    monster.Eth = pso.read_u16(monster.address + _MonsterEth)
    monster.Eic = pso.read_u16(monster.address + _MonsterEic)
    monster.Edk = pso.read_u16(monster.address + _MonsterEdk)
    monster.Elt = pso.read_u16(monster.address + _MonsterElt)

    monster.room = pso.read_u16(monster.address + _Room)
    monster.posX = pso.read_f32(monster.address + _PosX)
    monster.posY = pso.read_f32(monster.address + _PosY)
    monster.posZ = pso.read_f32(monster.address + _PosZ)
		
    -- Other stuff
    monster.name = lib_unitxt.GetMonsterName(monster.unitxtID, _Ultimate)
	monster.attribute = pso.read_u16(monster.address + 0x2e8)
	if monster.unitxtID == 44 or monster.unitxtID == 45 or monster.unitxtID == 46 or monster.unitxtID == 47 or monster.unitxtID == 73 or monster.unitxtID == 76 or monster.unitxtID == 77 or monster.unitxtID == 78 or monster.unitxtID == 106 then
		monster.isBoss = 1
	end
    monster.color = 0xFFFFFFFF
    monster.display = true

    if monster.unitxtID == 45 then
        monster = GetMonsterDataDeRolLe(monster)
    end
    if monster.unitxtID == 73 then
        monster = GetMonsterDataBarbaRay(monster)
    end

    return monster
end

local function GetTargetMonster()
    local difficulty = pso.read_u32(_Difficulty)
    _Ultimate = difficulty == 3

    local pIndex = pso.read_u32(_PlayerIndex)
    local pAddr = pso.read_u32(_PlayerArray + 4 * pIndex)

    -- If we don't have address (maybe warping or something)
    if pAddr == 0 then
        return nil
    end

    local targetID = -1
    local targetPointerOffset = pso.read_u32(pAddr + _targetPointerOffset)
    if targetPointerOffset ~= 0 then
        targetID = pso.read_i16(targetPointerOffset + _targetOffset)
    end

    if targetID == -1 then
        return nil
    end

    local _targetPointerOffset = 0x18
    local _targetOffset = 0x108C

    local playerCount = pso.read_u32(_PlayerCount)
    local entityCount = pso.read_u32(_EntityCount)

    local i = 0
    while i < entityCount do
        local monster = {}
        monster.index = i
        monster.address = pso.read_u32(_EntityArray + 4 * (i + playerCount))
        -- If we got a pointer, then read from it
        if monster.address ~= 0 then
            monster.id = pso.read_i16(monster.address + _ID)

            if monster.id == targetID then
                monster = GetMonsterData(monster)
				-- If we have De Rol Le
				if monster.unitxtID == 45 and monster.index == 0 then
					if monster.HP2 > 0 then
						monster.index = monster.index + 1
						monster.HP = monster.HP2
						monster.HPMax = monster.HP2Max
						monster.name = monster.name .. " Skull"
						monster.part = 1
					end
				-- If we have Barba Ray
				elseif monster.unitxtID == 73 and monster.index == 0 then
					if monster.HP2 > 0 then
						monster.index = monster.index + 1
						monster.HP = monster.HP2
						monster.HPMax = monster.HP2Max
						monster.name = monster.name .. " Skull"
						monster.part = 1
					end
				end
                return monster
            end
        end
        i = i + 1
    end

    return nil
end

local function GetMonsterList()
    local monsterList = {}

    local difficulty = pso.read_u32(_Difficulty)
    _Ultimate = difficulty == 3

    local pIndex = pso.read_u32(_PlayerIndex)
    local pAddr = pso.read_u32(_PlayerArray + 4 * pIndex)

    -- If we don't have address (maybe warping or something)
    -- return the empty list
    if pAddr == 0 then
        return monsterList
    end

    -- Get player position
    local playerRoom1 = pso.read_u16(pAddr + _Room)
    local playerRoom2 = pso.read_u16(pAddr + _Room2)
    local pPosX = pso.read_f32(pAddr + _PosX)
    local pPosZ = pso.read_f32(pAddr + _PosZ)

    local playerCount = pso.read_u32(_PlayerCount)
    local entityCount = pso.read_u32(_EntityCount)

    local i = 0
    while i < entityCount do
        local monster = {}

        monster.display = true
        monster.index = i
        monster.address = pso.read_u32(_EntityArray + 4 * (i + playerCount))

        -- If we got a pointer, then read from it
        if monster.address ~= 0 then
            monster = GetMonsterData(monster)

            if cfgMonsters.m[monster.unitxtID] ~= nil then
                monster.color = cfgMonsters.m[monster.unitxtID].color
                monster.display = cfgMonsters.m[monster.unitxtID].display
            end

            -- Calculate the distance between it and the player
            -- And hide the monster if its too far
            local xDist = math.abs(pPosX - monster.posX)
            local zDist = math.abs(pPosZ - monster.posZ)
            local tDist = math.sqrt(xDist ^ 2 + zDist ^ 2)

            if cfgMonsters.maxDistance ~= 0 and tDist > cfgMonsters.maxDistance then
                monster.display = false
            end

            -- Determine whether the player is in the same room as the monster
            if options.showCurrentRoomOnly and playerRoom1 ~= monster.room and playerRoom2 ~= monster.room then
                monster.display = false
            end

            -- Do not show monsters that have been killed
            if monster.HP <= 0 then
                monster.display = false
            end

            -- If we have De Rol Le, make a copy for the body HP
            if monster.unitxtID == 45 and monster.index == 0 then
                local head = CopyMonster(monster)
                table.insert(monsterList, head)

                monster.index = monster.index + 1
                monster.HP = monster.HP2
                monster.HPMax = monster.HP2Max
                monster.name = monster.name .. " Skull"
				monster.part = 1
            elseif monster.unitxtID == 73 and monster.index == 0 then
                local head = CopyMonster(monster)
				table.insert(monsterList, head)

                monster.index = monster.index + 1
                monster.HP = monster.HP2
                monster.HPMax = monster.HP2Max
                monster.name = monster.name .. " Skull"
				monster.part = 1
            end


            table.insert(monsterList, monster)
        end
        i = i + 1
    end

    return monsterList
end


local RareMonsterTextColor = {r=0,g=0,b=0,a=255,trans=0,dir=1}

local function clampVal(clamp, min, max)
    return clamp < min and min or clamp > max and max or clamp
end
local function Lerp(Norm,Min,Max)
    return (Max - Min) * Norm + Min
end
local function transitionColors2(Color1, Color2, Speed, Transition, Direction)
	-- Speed is 1-100 as a percentage of how fast to change between the colors
	-- Transition is 0-1 on how much of color1 vs color2 comes through
	local Ctbl = {}
	Ctbl.a = Lerp(Transition,Color1.a,Color2.a)
	Ctbl.r = Lerp(Transition,Color1.r,Color2.r)
	Ctbl.g = Lerp(Transition,Color1.g,Color2.g)
	Ctbl.b = Lerp(Transition,Color1.b,Color2.b)
	if Direction < 0 then
		Transition = Transition - Speed/100
		if Transition <= 0.0 then
			Direction = 1
		end
		Transition = clampVal(Transition,0,1) 
	elseif Direction > 0 then
		Transition = Transition + Speed/100
		if Transition >= 1.0 then
			Direction = -1
		end
		Transition = clampVal(Transition,0,1)
	end
	Ctbl.trans = Transition
	Ctbl.dir = Direction
	return Ctbl
end
local function ARGBtoHex(Clr)
	return 	bit.lshift(Clr.a, 24) +
			bit.lshift(Clr.r, 16) +
			bit.lshift(Clr.g, 8) +
			bit.lshift(Clr.b, 0)
end
local function shiftHexColor(color)
    return
    {
        bit.band(bit.rshift(color, 24), 0xFF),
        bit.band(bit.rshift(color, 16), 0xFF),
        bit.band(bit.rshift(color, 8), 0xFF),
        bit.band(color, 0xFF)
    }
end
local RareDropMonsterExceptions = {
	[32] = "GRAN SORCERER",    -- Bee R / Gee R
	[33] = "GRAN SORCERER",    -- Bee L / Gee L
	[87] = "EPSILON",          -- Epsigard
	[45] = "DAL RA LIE",       -- Dal Ra Lie
	[73] = "BARBA RAY",        -- Barba Ray
	-- uncomment to enable these below. (not including this line)
	-- [85] = "OLGA FLOW",     -- Gael
	-- [86] = "OLGA FLOW",     -- Giel
}
local function PrintRareDrop(monster)
	if cacheSide then
		local rateColor = 0xFFFFFFFF
		local mName = string.upper(monster.name)
		local mException = RareDropMonsterExceptions[monster.unitxtID]
		if mException ~= nil -- there is an exception
			and monster.isBoss ~= 1  -- normal exception, not a boss
			or (monster.isBoss == 1 and monster.part ~= nil and monster.part > 0 ) -- is a boss, but the exception is for other boss parts
		then
			mName = mException
			rateColor = 0xFFA0A0A0
		end
		if drop_charts[party.difficulty]
			and drop_charts[party.difficulty][party.episode]
			and drop_charts[party.difficulty][party.episode][party.id]
			and drop_charts[party.difficulty][party.episode][party.id][mName]
		then
			local mDrops = drop_charts[party.difficulty][party.episode][party.id][mName]
			for i,drop in pairs(mDrops) do
				if drop.item and drop.rare and drop.dar then
					lib_helpers.TextC(true, section_color[party.id], drop.item)
					lib_helpers.TextC(false, 0xFFFFFFFF, " - Drop:")
					lib_helpers.TextC(false, rateColor, " 1/%i", 1/((party.dar*drop.dar)*(party.rare*drop.rare))*100000000)
					lib_helpers.TextC(false, 0xFFFFFFFF, " (")
					lib_helpers.TextC(false, rateColor, "%.4f%%", ((party.dar*drop.dar)*(party.rare*drop.rare))/1000000)
					lib_helpers.TextC(false, 0xFFFFFFFF, ") ")
				end
			end
		end
	else
		lib_helpers.Text(true, "Type /partyinfo to refresh...")
	end
end

local function PresentMonsters()
    local monsterList = GetMonsterList()
    local monsterListCount = table.getn(monsterList)
	
    local columnCount = 2

    -- Get how many columns we'll need
    if options.showMonsterID == true then
        columnCount = columnCount + 1
    end
    if options.showMonsterStatus == true then
        columnCount = columnCount + 1
    end
    imgui.Columns(columnCount)

	local windowWidth = imgui.GetWindowSize()
	local charWidth = 0.7 * imgui.GetFontSize()

	local nameColumnWidth = #"XXXXXXXX" * charWidth + 10
	local idColumnWidth = #"XXXXXXX" * charWidth
	local statusColumnWidth = #"J30 Z30 F P" * charWidth + 10

	if options.showMonsterID == true and options.showMonsterStatus == true then
		imgui.SetColumnOffset(1, nameColumnWidth)
		imgui.SetColumnOffset(2, windowWidth - (nameColumnWidth + idColumnWidth + statusColumnWidth))
		imgui.SetColumnOffset(3, nameColumnWidth + windowWidth - (nameColumnWidth + idColumnWidth + statusColumnWidth))
	elseif options.showMonsterID == true then
		imgui.SetColumnOffset(1, nameColumnWidth)
		imgui.SetColumnOffset(2, windowWidth - (nameColumnWidth + statusColumnWidth))
	elseif options.showMonsterStatus == true then
		imgui.SetColumnOffset(1, nameColumnWidth)
		imgui.SetColumnOffset(2, windowWidth - (nameColumnWidth + idColumnWidth))
	else
		imgui.SetColumnOffset(1, nameColumnWidth)
	end

    local startIndex = 1
    local endIndex = monsterListCount
    local step = 1

    if options.invertMonsterList then
        startIndex = monsterListCount
        endIndex = 1
        step = -1
    end

    for i=startIndex, endIndex, step do
        local monster = monsterList[i]
		local playerAddr = lib_characters.GetSelf()
        if monster.display then
            local mHP = monster.HP
            local mHPMax = monster.HPMax
			
			if options.showMonsterResist and monster.color ~= 0xFFFFFF00 then
				if (monster.Efr <= monster.Eth) and (monster.Efr <= monster.Eic) then
					lib_helpers.TextC(true, 0xFFFF6600, monster.name)
				elseif (monster.Eth <= monster.Efr) and (monster.Eth <= monster.Eic) then
					lib_helpers.TextC(true, 0xFFFFFF00, monster.name)
				elseif (monster.Eic <= monster.Efr) and (monster.Eic <= monster.Eth) then
					lib_helpers.TextC(true, 0xFF00FFFF, monster.name)
				else
					lib_helpers.TextC(true, 0xFFFFFFFF, monster.name)
				end
			elseif monster.color == 0xFFFFFF00 then -- overwrite rare color with gold
				if options.customRareMonsterColorEnabled then
					local startColor = shiftHexColor(options.customRareMonsterColorStart)
					local endColor = shiftHexColor(options.customRareMonsterColorEnd)
					RareMonsterTextColor = transitionColors2(
						{a=startColor[1], r=startColor[2], g=startColor[3], b=startColor[4]},
						{a=endColor[1],   r=endColor[2],   g=endColor[3],   b=endColor[4]},
						options.customRareMonsterSpeed,
						RareMonsterTextColor.trans,
						RareMonsterTextColor.dir
					)
					lib_helpers.TextC(true, ARGBtoHex(RareMonsterTextColor), monster.name)
				else
					lib_helpers.TextC(true, 0xFFFFD700, monster.name)
				end
			else
				lib_helpers.TextC(true, monster.color, monster.name)
			end

            imgui.NextColumn()
			
			lib_helpers.imguiProgressBar(true, mHP/mHPMax, -1.0, imgui.GetFontSize(), lib_helpers.HPToGreenRedGradient(mHP/mHPMax), nil, mHP)
            imgui.NextColumn()
			
            if options.showMonsterStatus then
                local atkTech = lib_characters.GetPlayerTechniqueStatus(monster.address, 0)
                local defTech = lib_characters.GetPlayerTechniqueStatus(monster.address, 1)

                if atkTech.type == 0 then
                    lib_helpers.TextC(true, 0, "    ")
                else
                    lib_helpers.TextC(true, 0xFFFF2031, atkTech.name .. atkTech.level .. string.rep(" ", 2 - #tostring(atkTech.level)) .. " ")
                end

                if defTech.type == 0 then
                    lib_helpers.TextC(false, 0, "    ")
                else
                    lib_helpers.TextC(false, 0xFF0088F4, defTech.name .. defTech.level .. string.rep(" ", 2 - #tostring(defTech.level)) .. " ")
                end

                local frozen = lib_characters.GetPlayerFrozenStatus(monster.address)
                local confused = lib_characters.GetPlayerConfusedStatus(monster.address)
                local paralyzed = lib_characters.GetPlayerParalyzedStatus(monster.address)
				local shocked = lib_characters.GetPlayerShockedStatus(monster.address)

                if frozen then
                    lib_helpers.TextC(false, 0xFF00FFFF, "F ")
                elseif confused then
                    lib_helpers.TextC(false, 0xFFFF00FF, "C ")
				elseif shocked then
					lib_helpers.TextC(false, 0xFFFFFF00, "S ")
                else
                    lib_helpers.TextC(false, 0, "  ")
                end
                if paralyzed then
                    lib_helpers.TextC(false, 0xFFFF4000, "P ")
                end

                imgui.NextColumn()
            end
			
			if options.showMonsterID == true then
				local megid = lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Megid)
				if megid >= 1 and megid < 16 then
					megid = ((megid * 3 + 24) - monster.Edk)
				elseif megid >= 16 then
					megid = ((megid * 2 + 40) - monster.Edk)
				end
				if megid >= 0 then
					lib_helpers.TextC(true, 0xFFEE19DC, "Megid: ")
					lib_helpers.Text(false, "%i", megid)
					lib_helpers.Text(false, "%% ")
				end
                imgui.NextColumn()
            end
			
        end
    end
end

local function PresentTargetMonster(monster)
    if monster ~= nil then
        local playerAddr = lib_characters.GetSelf()
        if playerAddr == 0 then
            return
        end
		
        local mHP = monster.HP
        local mHPMax = monster.HPMax
		
		local difficulty = pso.read_u32(_Difficulty)

		local PposX = pso.read_f32(playerAddr + _PosX)
		local PposZ = pso.read_f32(playerAddr + _PosZ)

        local atkTech = lib_characters.GetPlayerTechniqueStatus(monster.address, 0)
        local defTech = lib_characters.GetPlayerTechniqueStatus(monster.address, 1)
		
		local zalure = lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Zalure)

        local frozen = lib_characters.GetPlayerFrozenStatus(monster.address)
        local confused = lib_characters.GetPlayerConfusedStatus(monster.address)
        local paralyzed = lib_characters.GetPlayerParalyzedStatus(monster.address)
		local shocked = lib_characters.GetPlayerShockedStatus(monster.address)
		
		local myMaxTP = lib_characters.GetPlayerMaxTP(playerAddr)
		local myMaxAtp = lib_characters.GetPlayerMaxATP(playerAddr,0)
		local myMinAtp = lib_characters.GetPlayerMinATP(playerAddr,0)
		local myAta = lib_characters.GetPlayerATA(playerAddr)
		local myLck = lib_characters.GetPlayerLCK(playerAddr)
		
		local inventory = lib_items.GetInventory(lib_items.Me)
        local itemCount = table.getn(inventory.items)
		
		local NAstat = 0
		local ABstat = 0
		local MAstat = 0
		local DAstat = 0
		local weapon_group = 0
		local pmt_data = 0
		local pmt_weapon_animations = 0
		local weapon_animation_type = 0
		local ataPenalty = 0
		local EqSmartlink = 0
		local MDistance = 0
		local weapSpecial = ""
		local weapName = ""
		local weapEquipped = 0
		local numTargets = 0
		local numHits = 0
        local androidBoost = 0
		local specRedux = 1
		local specDMG = -1
		local specAilment = 0
		local specDraw = 0
		local weapHex = 0
		local v50xHellBoost = 1
        local v50xStatusBoost = 1
		local ailRedux = 1
		local specPower = pso.read_u16(playerAddr + 0x118)
		
		
		for i=1,itemCount,1 do
            local item = inventory.items[i]
            if item.equipped and item.data[1] == 0x00 then
				if not item.weapon.isSRank then
					NAstat = item.weapon.stats[2]/100
					ABstat = item.weapon.stats[3]/100
					MAstat = item.weapon.stats[4]/100
					DAstat = item.weapon.stats[5]/100
				end
				weapEquipped = item.weapon.special
				weapSpecial = lib_unitxt.GetSpecialName(weapEquipped)
				weapHex = item.data[2]
				weapName = item.name
				weapon_group = pso.read_u8(item.address + 0xf3)
				pmt_data = pso.read_u32(0xA8DC94)
				pmt_weapon_animations = pso.read_u32(pmt_data + 0x14)
				weapon_animation_type = pso.read_u8(pmt_weapon_animations + weapon_group)
				if weapon_animation_type == 5 or weapon_animation_type == 6 or weapon_animation_type == 7 or weapon_animation_type == 8 or weapon_animation_type == 9 or weapon_animation_type == 18 then
					ataPenalty = 1
				end
			end
			if item.equipped and item.name == "Smartlink" then
				EqSmartlink = 1
			end
			if item.equipped and item.data[1] == 0x01 and item.data[2] == 0x03 then
                -- V501
                if item.data[3] == 0x4A then
                    v50xHellBoost = 1.5
                    v50xStatusBoost = 1.5
                -- V502
                elseif item.data[3] == 0x4B then
                    v50xHellBoost = 2.0
                    v50xStatusBoost = 1.5
                end
            end
		end
		
		if monster.attribute == 1 then
			myMaxAtp = lib_characters.GetPlayerMaxATP(playerAddr,NAstat)
			myMinAtp = lib_characters.GetPlayerMinATP(playerAddr,NAstat)
		elseif monster.attribute == 2 then
			myMaxAtp = lib_characters.GetPlayerMaxATP(playerAddr,ABstat)
			myMinAtp = lib_characters.GetPlayerMinATP(playerAddr,ABstat)
		elseif monster.attribute == 4 then
			myMaxAtp = lib_characters.GetPlayerMaxATP(playerAddr,MAstat)
			myMinAtp = lib_characters.GetPlayerMinATP(playerAddr,MAstat)
		elseif monster.attribute == 8 then
			myMaxAtp = lib_characters.GetPlayerMaxATP(playerAddr,DAstat)
			myMinAtp = lib_characters.GetPlayerMinATP(playerAddr,DAstat)
		end
		
		local myMaxDamage = ((myMaxAtp - monster.Dfp)/5)*.9
		local myMinDamage = ((myMinAtp - monster.Dfp)/5)*.9
		
		if defTech.type == 0 then
		
		else
			myMaxDamage = ((myMaxAtp - (monster.Dfp*(1-((((zalure-1)*1.3)+10)/100))))/5)*.9
			myMinDamage = ((myMinAtp - (monster.Dfp*(1-((((zalure-1)*1.3)+10)/100))))/5)*.9
		end
		
		if myMinDamage < 1 then
			myMinDamage = 0
		end
		
		if myMaxDamage < 1 then
			myMaxDamage = 0
		end
		
		if (string.sub(lib_unitxt.GetClassName(lib_characters.GetPlayerClass(playerAddr)),1,2) == "FO" or string.sub(lib_unitxt.GetClassName(lib_characters.GetPlayerClass(playerAddr)),1,2) == "HU") and EqSmartlink == 0 and ataPenalty == 1 then
			MDistance = (math.sqrt(((monster.posX-PposX)^2)+((monster.posZ-PposZ)^2)))*0.33
		end
		
		if lib_characters.GetPlayerIsCast(playerAddr) == true and difficulty == 3 then
            androidBoost = 30
        end
		
		if (0x1 < weapHex) then
			if (weapHex < 0x5) then
				specRedux = 0.50
			elseif (weapHex == 0x5) or (7 < weapHex and (weapHex < 0xA)) then
				specRedux = 0.33
			end
		end
		
		if difficulty == 3 then
			ailRedux = 2.5
		else
			ailRedux = 6.67
		end
		
		if options.ShowMonsterName then
			lib_helpers.Text(true, monster.name)
		end
		
		-- Show J/Z status and Frozen, Confuse, or Paralyzed status

		if atkTech.type == 0 then
			lib_helpers.TextC(true, 0, "    ")
		else
			lib_helpers.TextC(true, 0xFFFF2031, atkTech.name .. atkTech.level .. string.rep(" ", 2 - #tostring(atkTech.level)) .. " ")
		end

		if defTech.type == 0 then
			lib_helpers.TextC(false, 0, "    ")
		else
			lib_helpers.TextC(false, 0xFF0088F4, defTech.name .. defTech.level .. string.rep(" ", 2 - #tostring(defTech.level)) .. " ")
		end

		if frozen then
			lib_helpers.TextC(false, 0xFF00FFFF, "F ")
		elseif confused then
			lib_helpers.TextC(false, 0xFFFF00FF, "C ")
		elseif shocked then
			lib_helpers.TextC(false, 0xFFFFFF00, "S ")
		else
			lib_helpers.TextC(false, 0, "  ")
		end
		if paralyzed then
			lib_helpers.TextC(false, 0xFFFF4000, "P ")
		end

		imgui.NextColumn()
		
		if options.ShowHealthBar then
			-- Draw enemy HP bar
			lib_helpers.imguiProgressBar(true, mHP/mHPMax, -1.0, imgui.GetFontSize(), lib_helpers.HPToGreenRedGradient(mHP/mHPMax), nil, mHP)
		end
		
		-- Calculate all 9 types of attack combinations
		local normAtk1_Acc = math.max(math.min((myAta * 1.0 * 1.0 ) - (monster.Evp * 0.2) - MDistance,100),0)
		local hardAtk1_Acc = math.max(math.min((myAta * 0.7 * 1.0 ) - (monster.Evp * 0.2) - MDistance,100),0)
		local specAtk1_Acc = math.max(math.min((myAta * 0.5 * 1.0 ) - (monster.Evp * 0.2) - MDistance,100),0)
		local normAtk2_Acc = math.max(math.min((myAta * 1.0 * 1.3 ) - (monster.Evp * 0.2) - MDistance,100),0)
		local hardAtk2_Acc = math.max(math.min((myAta * 0.7 * 1.3 ) - (monster.Evp * 0.2) - MDistance,100),0)
		local specAtk2_Acc = math.max(math.min((myAta * 0.5 * 1.3 ) - (monster.Evp * 0.2) - MDistance,100),0)
		local normAtk3_Acc = math.max(math.min((myAta * 1.0 * 1.69) - (monster.Evp * 0.2) - MDistance,100),0)
		local hardAtk3_Acc = math.max(math.min((myAta * 0.7 * 1.69) - (monster.Evp * 0.2) - MDistance,100),0)
		local specAtk3_Acc = math.max(math.min((myAta * 0.5 * 1.69) - (monster.Evp * 0.2) - MDistance,100),0)
		
		if options.ShowDamage then
			lib_helpers.Text(true, "%i", myMinDamage)
			lib_helpers.Text(false, "-")
			lib_helpers.Text(false, "%i", myMaxDamage)
			lib_helpers.Text(false, " Weak Hit")		
			lib_helpers.Text(true, "%i", (myMinDamage*1.89))
			lib_helpers.Text(false, "-")
			lib_helpers.Text(false, "%i", (myMaxDamage*1.89))
			lib_helpers.Text(false, " Heavy Hit")
		end
	
		if weapSpecial == "Heat" or weapSpecial == "Fire" or weapSpecial == "Flame" or weapSpecial == "Burning" then
			specDMG = (((lib_characters.GetPlayerLevel(playerAddr)-1)+((specPower+1)*20))*(100-(monster.Efr))*0.01)
			specAilment = 100
		elseif weapSpecial == "Ice" or weapSpecial == "Frost" or weapSpecial == "Freeze" or weapSpecial == "Blizzard" then
			specAilment = math.min((((specPower+androidBoost)-monster.Esp)*specRedux),40)*v50xStatusBoost
		elseif weapSpecial == "Shock" or weapSpecial == "Thunder" or weapSpecial == "Storm" or weapSpecial == "Tempest" then
			specDMG = (((lib_characters.GetPlayerLevel(playerAddr)-1)+((specPower+1)*20))*(100-(monster.Eth))*0.01)
			specAilment = 100
		elseif weapSpecial == "Bind" or weapSpecial == "Hold" or weapSpecial == "Seize" or weapSpecial == "Arrest" then
			specAilment = ((specPower+androidBoost)-monster.Esp)*specRedux*v50xStatusBoost
		elseif weapSpecial == "Panic" or weapSpecial == "Riot" or weapSpecial == "Havoc" or weapSpecial == "Chaos" then
			specAilment = ((specPower+androidBoost)-monster.Esp)*specRedux*v50xStatusBoost
		elseif (weapSpecial == "Dim" or weapSpecial == "Shadow" or weapSpecial == "Dark" or weapSpecial == "Hell") and monster.isBoss == 0 then
			specAilment = (specPower-monster.Edk)*specRedux*v50xHellBoost
			specDMG = mHP
		elseif weapSpecial == "Draw" or weapSpecial == "Drain" or weapSpecial == "Fill" or weapSpecial == "Gush" then
			specDraw = math.min(((specPower+androidBoost)/100)*mHP,(difficulty+1)*30)*specRedux
			specAilment = 100
		elseif weapSpecial == "Heart" or weapSpecial == "Mind" or weapSpecial == "Soul" or weapSpecial == "Geist" then
			if lib_characters.GetPlayerIsCast(playerAddr) == false then
				specDraw = math.min((specPower/100)*myMaxTP,(difficulty+1)*25)*specRedux
				specAilment = 100
			else
				weapSpecial = "None"
			end
		elseif weapSpecial == "Master's" or weapSpecial == "Lord's" or weapSpecial == "King's" then
			specDraw = math.min(((specPower+androidBoost)/100)*monster.Exp,(difficulty+1)*20)*specRedux
			specAilment = 100
		elseif (weapSpecial == "Devil's" or weapSpecial == "Demon's") and monster.isBoss == 0 then
			specDMG = (mHP*(1-(((specPower+androidBoost)/100))))*specRedux
			specAilment = 50
		elseif weapSpecial == "Charge" or weapSpecial == "Spirit" or weapSpecial == "Berserk" or weapName == "Vjaya" then
			specAilment = 100
		end	
		
		if weapSpecial ~= "None" then
			if options.ShowDamage then
				if weapSpecial == "Charge" or weapSpecial == "Spirit" or weapSpecial == "Berserk" then
					if weapName == "Vjaya" then
						lib_helpers.Text(true, "%i", (myMinDamage*5.67))
						lib_helpers.Text(false, "-")
						lib_helpers.Text(false, "%i", (myMaxDamage*5.67))
					else
						lib_helpers.Text(true, "%i", (myMinDamage*3.33))
						lib_helpers.Text(false, "-")
						lib_helpers.Text(false, "%i", (myMaxDamage*3.33))
					end
				elseif specDMG >= 0 then
					lib_helpers.TextC(true, lib_items_cfg.weaponSpecial[weapEquipped + 1], "%i", specDMG)
				elseif specDMG < 0 then
					lib_helpers.Text(true, "%i", (myMinDamage*0.56))
					lib_helpers.Text(false, "-")
					lib_helpers.Text(false, "%i", (myMaxDamage*0.56))
				end
				lib_helpers.Text(false, " Special Hit [")
				lib_helpers.TextC(false, lib_items_cfg.weaponSpecial[weapEquipped + 1], lib_unitxt.GetSpecialName(weapEquipped))
				lib_helpers.Text(false, "] ")
				if specAilment > 0 then
						if weapSpecial == "Master's" or weapSpecial == "Lord's" or weapSpecial == "King's" then
							lib_helpers.Text(false, "steal ")
							lib_helpers.TextC(false, lib_items_cfg.weaponSpecial[weapEquipped + 1], "%i", math.max(specDraw,0))
							lib_helpers.Text(false, " EXP")
						elseif (weapSpecial == "Heart" or weapSpecial == "Mind" or weapSpecial == "Soul" or weapSpecial == "Geist") and lib_characters.GetPlayerIsCast(playerAddr) == false then
							lib_helpers.Text(false, "steal ")
							lib_helpers.TextC(false, lib_items_cfg.weaponSpecial[weapEquipped + 1], "%i", math.max(specDraw,0))
							lib_helpers.Text(false, " TP")
						elseif weapSpecial == "Draw" or weapSpecial == "Drain" or weapSpecial == "Fill" or weapSpecial == "Gush" then	
							lib_helpers.Text(false, "steal ")
							lib_helpers.TextC(false, lib_items_cfg.weaponSpecial[weapEquipped + 1], "%i", math.max(specDraw,0))
							lib_helpers.Text(false, " HP")
						elseif (weapSpecial == "Dim" or weapSpecial == "Shadow" or weapSpecial == "Dark" or weapSpecial == "Hell") and monster.isBoss == 0 then	
							lib_helpers.Text(false, "chance to Instant Kill")
						elseif weapSpecial == "Panic" or weapSpecial == "Riot" or weapSpecial == "Havoc" or weapSpecial == "Chaos"  and monster.isBoss == 0 then
							lib_helpers.Text(false, "chance to Confuse")
						elseif weapSpecial == "Bind" or weapSpecial == "Hold" or weapSpecial == "Seize" or weapSpecial == "Arrest" and (monster.attribute == 1 or monster.attribute == 2 or monster.attribute == 8) and monster.isBoss == 0 then	
							lib_helpers.Text(false, "chance to Paralyze")
						elseif weapSpecial == "Shock" or weapSpecial == "Thunder" or weapSpecial == "Storm" or weapSpecial == "Tempest" and monster.attribute == 4 and monster.isBoss == 0 and monster.name ~= "Epsilon" then	
							specAilment = ailRedux*v50xStatusBoost
							lib_helpers.Text(false, "chance to Shock")
						elseif weapSpecial == "Ice" or weapSpecial == "Frost" or weapSpecial == "Freeze" or weapSpecial == "Blizzard" and not (monster.isBoss == 1 or monster.name == "Epsilon" or monster.name == "Zu" or monster.name == "Pazuzu" or monster.name == "Dorphon" or monster.name == "Dorphon Eclair" or monster.name == "Girtablulu" ) then
							lib_helpers.Text(false, "chance to Freeze")
						end
				end
			end
			if options.ShowHit then
				lib_helpers.Text(true, "Spec1: ")
				lib_helpers.TextC(false, lib_items_cfg.weaponSpecial[weapEquipped + 1], "%i%% ", math.min(specAtk1_Acc*(math.max(specAilment,0)/100),100))
				lib_helpers.Text(false, " > Spec2: ")
				lib_helpers.TextC(false, lib_items_cfg.weaponSpecial[weapEquipped + 1], "%i%% ", math.min(specAtk2_Acc*(math.max(specAilment,0)/100),100))
				lib_helpers.Text(false, " > Spec3: ")
				lib_helpers.TextC(false, lib_items_cfg.weaponSpecial[weapEquipped + 1], "%i%% ", math.min(specAtk3_Acc*(math.max(specAilment,0)/100),100))
			end
		end
		
		if options.ShowHit then
			-- Display best first attack
			lib_helpers.Text(true, "[")
			if specAtk1_Acc >= options.targetSpecialThreshold and weapSpecial ~= "None" then
				lib_helpers.TextC(false, 0xFFFF2031, "Spec1: %i%% ", specAtk1_Acc)
			elseif hardAtk1_Acc >= options.targetHardThreshold then
				lib_helpers.TextC(false, 0xFFFFAA00, "Hard1: %i%% ", hardAtk1_Acc)
			elseif normAtk1_Acc > 0 then
				lib_helpers.TextC(false, 0xFF00FF00, "Norm1: %i%% ", normAtk1_Acc)
			else
				lib_helpers.TextC(false, 0xFFBB0000, "Norm1: 0%%")
			end

			-- Display best second attack
			lib_helpers.Text(false, " > ")
			if specAtk2_Acc >= options.targetSpecialThreshold and weapSpecial ~= "None" then
				lib_helpers.TextC(false, 0xFFFF2031, "Spec2: %i%% ", specAtk2_Acc)
			elseif hardAtk2_Acc >= options.targetHardThreshold then
				lib_helpers.TextC(false, 0xFFFFAA00, "Hard2: %i%% ", hardAtk2_Acc)
			elseif normAtk2_Acc > 0 then
				lib_helpers.TextC(false, 0xFF00FF00, "Norm2: %i%% ", normAtk2_Acc)
			else
				lib_helpers.TextC(false, 0xFFBB0000, "Norm2: 0%%")
			end

			-- Display best third attack
			lib_helpers.Text(false, "> ")
			if specAtk3_Acc >= options.targetSpecialThreshold and weapSpecial ~= "None" then
				lib_helpers.TextC(false, 0xFFFF2031, "Spec3: %i%%", specAtk3_Acc)
			elseif hardAtk3_Acc >= options.targetHardThreshold then
				lib_helpers.TextC(false, 0xFFFFAA00, "Hard3: %i%%", hardAtk3_Acc)
			elseif normAtk3_Acc > 0 then
				lib_helpers.TextC(false, 0xFF00FF00, "Norm3: %i%%", normAtk3_Acc)
			else
				lib_helpers.TextC(false, 0xFFBB0000, "Norm3: 0%%")
			end
			lib_helpers.Text(false, "]")
		end
		
		if options.ShowRares then
			PrintRareDrop(monster)
		end
    end
end

local function PresentTarget2Monster(monster)
	if monster ~= nil then
		local playerAddr = lib_characters.GetSelf()
        if playerAddr == 0 then
            return
        end
		
		local columnCount = 2

		imgui.Columns(columnCount)

        local windowWidth = imgui.GetWindowSize()
        local charWidth = 0.7 * imgui.GetFontSize()

        local statsColumnWidth = #"XXXXXXX" * charWidth
        local resistColumnWidth = #"XXXXXXX" * charWidth

        imgui.SetColumnOffset(1, statsColumnWidth)
        imgui.SetColumnOffset(2, statsColumnWidth + resistColumnWidth)

		lib_helpers.Text(true, "ATP: %i", monster.Atp)
		imgui.NextColumn()
		lib_helpers.Text(true, "EFR: ")
		if monster.Efr > 100 then
			lib_helpers.TextC(false, 0xFFFF6600, "100")
		else
			lib_helpers.TextC(false, 0xFFFF6600, "%i", monster.Efr)
		end
		imgui.NextColumn()
		lib_helpers.Text(true, "DFP: %i", monster.Dfp)
		imgui.NextColumn()
		lib_helpers.Text(true, "EIC: ")
		if monster.Eic > 100 then
			lib_helpers.TextC(false, 0xFF00FFFF, "100")
		else
			lib_helpers.TextC(false, 0xFF00FFFF, "%i", monster.Eic)
		end
		imgui.NextColumn()
		lib_helpers.Text(true, "MST: %i", monster.Mst)
		imgui.NextColumn()
		lib_helpers.Text(true, "ETH: ")
		if monster.Eth > 100 then
			lib_helpers.TextC(false, 0xFFFFFF00, "100")
		else
			lib_helpers.TextC(false, 0xFFFFFF00, "%i", monster.Eth)
		end
		imgui.NextColumn()
		lib_helpers.Text(true, "ATA: %i", monster.Ata)
		imgui.NextColumn()
		lib_helpers.Text(true, "EDK: ")
		if monster.Edk > 100 then
			lib_helpers.TextC(false, 0xFFEE19DC, "100")
		else
			lib_helpers.TextC(false, 0xFFEE19DC, "%i", monster.Edk)
		end
		imgui.NextColumn()
		lib_helpers.Text(true, "EVP: %i", monster.Evp)
		imgui.NextColumn()
		lib_helpers.Text(true, "ELT: ")
		if monster.Elt > 100 then
			lib_helpers.TextC(false, 0xFFFFFFB3, "100")
		else
			lib_helpers.TextC(false, 0xFFFFFFB3, "%i", monster.Elt)
		end
		imgui.NextColumn()
		lib_helpers.Text(true, "LCK: %i", monster.Lck)
		imgui.NextColumn()
		lib_helpers.Text(true, "ESP: ")
		if monster.Esp > 100 then
			lib_helpers.TextC(false, 0xFFFF2031, "100")
		else
			lib_helpers.TextC(false, 0xFFFF2031, "%i", monster.Esp)
		end
		imgui.NextColumn()

	end
end

local function PresentRateMonster(monster)
	if monster ~= nil then
		local playerAddr = lib_characters.GetSelf()
        if playerAddr == 0 then
            return
        end
		
		-- Determine if we have v501/v502 equip for it's bonuses
        local inventory = lib_items.GetInventory(lib_items.Me)
        local itemCount = table.getn(inventory.items)
        local v50xHellBoost = 1.0
        local v50xStatusBoost = 1.0
        for i=1,itemCount,1 do
            local item = inventory.items[i]
            if item.equipped and item.data[1] == 0x01 and item.data[2] == 0x03 then
                -- V501
                if item.data[3] == 0x4A then
                    v50xHellBoost = 1.5
                    v50xStatusBoost = 1.5
                -- V502
                elseif item.data[3] == 0x4B then
                    v50xHellBoost = 2.0
                    v50xStatusBoost = 1.5
                    break
                end
            end
        end
		
		-- Show special activation rate if feature is enabled
        if options.RateEnableActivationRates == true then
            -- Determine if the Android Boost Applies
            local androidBoost = 0
            if lib_characters.GetPlayerIsCast(playerAddr) == true then
                androidBoost = 30
            end

            -- Calculate Rates of success of differing attack types
            local rate_list = {}

            -- Add Hell rate if enabled
            if options.RateEnableActivationRateItems.hell == true then
                local str = string.format("Hell: %i", math.min(math.max((93 - monster.Edk)*(v50xHellBoost),0),100))
                table.insert(rate_list, str)
            end
            -- Add Dark rate if enabled
            if options.RateEnableActivationRateItems.dark == true then
                local str = string.format("Dark: %i", math.min(math.max((78 - monster.Edk)*(v50xHellBoost),0),100))
                table.insert(rate_list, str)
            end
            -- Add Arrest rate if enabled
            if options.RateEnableActivationRateItems.arrest == true then
                local str = string.format("Arrest: %i", math.min(math.max((80 + androidBoost - monster.Esp)*(v50xStatusBoost),0),100))
                table.insert(rate_list, str)
            end
            -- Add Blizzard rate if enabled
            if options.RateEnableActivationRateItems.blizzard == true then
				local str = string.format("Blizzard: %i", math.min(math.max((80 + androidBoost - monster.Esp),0),40)*(v50xStatusBoost))
                table.insert(rate_list, str)
            end
            -- Add Seize rate if enabled
            if options.RateEnableActivationRateItems.seize == true then
                local str = string.format("Seize: %i", math.min(math.max((64 + androidBoost - monster.Esp)*(v50xStatusBoost),0),100))
                table.insert(rate_list, str)
            end
            -- Add Chaos rate if enabled
            if options.RateEnableActivationRateItems.chaos == true then
                local str = string.format("Chaos: %i", math.min(math.max((76 + androidBoost - monster.Esp)*(v50xStatusBoost),0),100))
                table.insert(rate_list, str)
            end
            -- Add Havoc rate if enabled
            if options.RateEnableActivationRateItems.havoc == true then
                local str = string.format("Havoc: %i", math.min(math.max((60 + androidBoost - monster.Esp)*(v50xStatusBoost),0),100))
                table.insert(rate_list, str)
            end

            -- Display all of the specials selected
            if table.getn(rate_list) > 0 then
                lib_helpers.Text(true, "Activation Rates:")
                for i, str in ipairs(rate_list) do
					lib_helpers.Text(true, str)
                end
            end
        end

	end
end

local function foRec(monster)
	if monster ~= nil then
		local playerAddr = lib_characters.GetSelf()
		if playerAddr == 0 then
            return
        end
		
		local mHP = monster.HP
        local mHPMax = monster.HPMax

        local atkTech = lib_characters.GetPlayerTechniqueStatus(monster.address, 0)
        local defTech = lib_characters.GetPlayerTechniqueStatus(monster.address, 1)

        local frozen = lib_characters.GetPlayerFrozenStatus(monster.address)
        local confused = lib_characters.GetPlayerConfusedStatus(monster.address)
        local paralyzed = lib_characters.GetPlayerParalyzedStatus(monster.address)
		local shocked = lib_characters.GetPlayerShockedStatus(monster.address)

		local pClassId = lib_characters.GetPlayerClass(playerAddr)
		local pClass = lib_unitxt.GetClassName(pClassId)

		local myAtp = lib_characters.GetPlayerMaxATP(playerAddr,0)
		local myDfp = lib_characters.GetPlayerDFP(playerAddr)
		local myMst = lib_characters.GetPlayerMST(playerAddr)
		local myAta = lib_characters.GetPlayerATA(playerAddr)
		local myEvp = lib_characters.GetPlayerEVP(playerAddr)
		local myLck = lib_characters.GetPlayerLCK(playerAddr)

		local foie = lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Foie)
		local gifoie = lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Gifoie)
		local rafoie = lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Rafoie)
		local zonde = lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Zonde)
		local gizonde = lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Gizonde)
		local razonde = lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Razonde)
		local barta = lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Barta)
		local gibarta = lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Gibarta)
		local rabarta = lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Rabarta)
		local grants = lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Grants)
		local megid = lib_characters.GetPlayerTechniqueLevel(playerAddr, lib_characters.Techniques.Megid)
		
		local foieC = 1
		local gifoieC = 1
		local rafoieC = 1
		local zondeC = 1
		local gizondeC = 1
		local razondeC = 1
		local bartaC = 1
		local gibartaC = 1
		local rabartaC = 1
		local grantsC = 1
		
		local name1 = 1
		local color1 = 1
		local tech1 = 1
		
		--Frames per second at max tech level
		local foieFps = 27/30
		local gifoieFps = 57/30
		local rafoieFps = 27/30
		local zondeFps = 27/30
		local gizondeFps = 22/30
		local razondeFps = 27/30
		local bartaFps = 27/30
		local gibartaFps = 42/30
		local rabartaFps = 27/30
		local grantsFps = 37/30
		
		--TP Cost based on Tech Level
		foieC = (1.2759 * (foie - 1) + 5)
		gifoieC = (0.6897 * (gifoie - 1) + 20)
		rafoieC = (0.2413 * (rafoie - 1) + 30)
		zondeC = (1.0690 * (zonde - 1) + 6)
		gizondeC = (0.5862 * (gizonde - 1) + 25)
		razondeC = (0.2759 * (razonde - 1) + 35)
		bartaC = (1.1724 * (barta - 1) + 4)
		gibartaC = (0.4828 * (gibarta - 1) + 25)
		rabartaC = (0.1724 * (rabarta - 1) + 35)
		grantsC = (1.0690 * (grants - 1) + 45)

		-- Determine if we have Cane's or Barrier's equipped for it's bonuses along with Class Bonus's
        local inventory = lib_items.GetInventory(lib_items.Me)
        local itemCount = table.getn(inventory.items)
		
        local foieB = 0
		local gifoieB = 0
		local rafoieB = 0
		local zondeB = 0
		local gizondeB = 0
		local razondeB = 0
		local bartaB = 0
		local gibartaB = 0
		local rabartaB = 0
		local grantsB = 0
		--Class Bonus
		if pClass == "FOnewearl" then
			foieB = foieB + 30
			zondeB = zondeB + 30
			bartaB = bartaB + 30
		elseif pClass == "FOnewman" then
			gifoieB = gifoieB + 30
			gizondeB = gizondeB + 30
			gibartaB = gibartaB + 30
			rafoieB = rafoieB + 30
			razondeB = razondeB + 30
			rabartaB = rabartaB + 30
		elseif pClass == "FOmarl" then
			grantsB = grantsB + 50
		elseif pClass == "FOmar" then
			gifoieB = gifoieB + 30
			gizondeB = gizondeB + 30
			gibartaB = gibartaB + 30
			grantsB = grantsB + 30
		end
		--Weapons
        for i=1,itemCount,1 do
            item = inventory.items[i]
            if item.equipped and item.data[1] == 0 then
                if item.name == "Club of Laconium" then
					foieB = foieB + 40
					break
				elseif item.name == "Hildebear's Cane" then
					foieB = foieB + 30
                    break
				elseif item.name == "Mace of Adaman" then
					bartaB = bartaB + 40
                    break
				elseif item.name == "Hildeblue's Cane" then
					bartaB = bartaB + 30
                    break
				elseif item.name == "Club of Zumiuran" then
					zondeB = zondeB + 40
                    break
				elseif item.name == "The Sigh of a God" then
					zondeB = zondeB + 30
                    break
				elseif item.name == "Siren Glass Hammer" then
					gibartaB = gibartaB + 50
                    break
				elseif item.name == "Caduceus" or item.name == "Dark Bridge" then
					grantsB = grantsB + 20
                    break
				elseif item.name == "Mercurius Rod" then
					grantsB = grantsB + 30
                    break
				elseif item.name == "Clio" then
					grantsB = grantsB + 10
                    break
				elseif item.name == "Fire Scepter: Agni" then
					foieB = foieB + 20
					gifoieB = gifoieB + 20
					rafoieB = rafoieB + 20
                    break
				elseif item.name == "Ice Staff: Dagon" then
					bartaB = bartaB + 20
					gibartaB = gibartaB + 20
					rabartaB = rabartaB + 20
                    break
				elseif item.name == "Storm Wand: Indra" then
					zondeB = zondeB + 20
					gizondeB = gizondeB + 20
					razondeB = razondeB + 20
                    break
				elseif item.name == "Summit Moon" then
					foieB = foieB + 30
					zondeB = zondeB + 30
					bartaB = bartaB + 30
                    break
				elseif item.name == "Twinkle Star" or item.name == "Nei's Claw" then
					foieB = foieB + 20
					zondeB = zondeB + 20
					bartaB = bartaB + 20
                    break
				elseif item.name == "Magical Piece" then
					gifoieB = gifoieB + 30
					gizondeB = gizondeB + 30
					gibartaB = gibartaB + 30
                    break
				elseif item.name == "Sorcerer's Cane" or item.name == "Rika's Claw" then
					gifoieB = gifoieB + 20
					gizondeB = gizondeB + 20
					gibartaB = gibartaB + 20
                    break
				elseif item.name == "Psycho Wand" then
					rafoieB = rafoieB + 30
					razondeB = razondeB + 30
					rabartaB = rabartaB + 30
                    break
				elseif item.name == "Prophets of Motav" then
					rafoieB = rafoieB + 20
					razondeB = razondeB + 20
					rabartaB = rabartaB + 20
                    break
                end
            end
        end
		--Frames
		for i=1,itemCount,1 do
            item = inventory.items[i]
            if item.equipped and item.data[1] == 1 and item.data[2] == 1 then
                if item.name == "Ignition Cloak" then
                    foieB = foieB + 10
					gifoieB = gifoieB + 10
					rafoieB = rafoieB + 10
					break
				elseif item.name == "Tempest Cloak" then
					zondeB = zondeB + 10
					gizondeB = gizondeB + 10
					razondeB = razondeB + 10
					break
				elseif item.name == "Congeal Cloak" then
					bartaB = bartaB + 10
					gibartaB = gibartaB + 10
					rabartaB = rabartaB + 10
					break
				elseif item.name == "Select Cloak" then
					grantsB = grantsB + 10
                    break
                end
            end
        end		
		--Barriers
		for i=1,itemCount,1 do
            item = inventory.items[i]
            if item.equipped and item.data[1] == 1 and item.data[2] == 2 then
                if item.name == "Foie Merge" then
					foieB = foieB + 30
					break
				elseif item.name == "Gifoie Merge" then
					gifoieB = gifoieB + 30
                    break
				elseif item.name == "Rafoie Merge" then
					rafoieB = rafoieB + 30
                    break
				elseif item.name == "Zonde Merge" then
					zondeB = zondeB + 30
                    break
				elseif item.name == "Gizonde Merge" then
					gizondeB = gizondeB + 30
                    break
				elseif item.name == "Razonde Merge" or item.name == "Three Seals" then
					razondeB = razondeB + 30
                    break
				elseif item.name == "Barta Merge" then
					bartaB = bartaB + 30
                    break
				elseif item.name == "Gibarta Merge" then
					gibartaB = gibartaB + 30
                    break
				elseif item.name == "Rabarta Merge" then
					rabartaB = rabartaB + 30
                    break
				elseif item.name == "Red Merge" then
					foieB = foieB + 20
					gifoieB = gifoieB + 20
					rafoieB = rafoieB + 20
                    break
				elseif item.name == "Yellow Merge" then
					zondeB = zondeB + 20
					gizondeB = gizondeB + 20
					razondeB = razondeB + 20
                    break
				elseif item.name == "Blue Merge" then
					bartaB = bartaB + 20
					gibartaB = gibartaB + 20
					rabartaB = rabartaB + 20
                    break
                end
            end
        end		

		--Tech Damage
		if foie >= 1 and foie < 16 then
			foie = (((foie * 50 + 50) + myMst) / 5) * (1 + (foieB / 100)) * (1 - (monster.Efr / 100))
		elseif foie >= 16 then
			foie = (((foie * 65 - 150) + myMst) / 5) * (1 + (foieB / 100)) * (1 - (monster.Efr / 100))
		end
		if gifoie >= 1 and gifoie < 16 then
			gifoie = ((gifoie * 26 + 234 + myMst) / 5 * (1 + (gifoieB) / 100) * (1 - monster.Efr / 100))
		elseif gifoie >= 16 then
			gifoie = ((gifoie * 42 - 12 + myMst) / 5 * (1 + (gifoieB) / 100) * (1 - monster.Efr / 100))
		end
		if rafoie >= 1 and rafoie < 16 then
			rafoie = ((rafoie * 22 + 328 + myMst) / 5 * (1 + (rafoieB) / 100) * (1 - monster.Efr / 100))
		elseif rafoie >= 16 then
			rafoie = ((rafoie * 21 + 349 + myMst) / 5 * (1 + (rafoieB) / 100) * (1 - monster.Efr / 100))
		end
		
		if zonde >= 1 and zonde < 16 then
			zonde = ((zonde * 50 + 30 + myMst) / 5 * (1 + (zondeB) / 100) * (1 - monster.Eth / 100))
		elseif zonde >= 16 then
			zonde = ((zonde * 55 - 50 + myMst) / 5 * (1 + (zondeB) / 100) * (1 - monster.Eth / 100))
		end
		if gizonde >=1 and gizonde < 16 then
			gizonde = ((gizonde * 22 + 178 + myMst) / 5 * (1 + (gizondeB) / 100) * (1 - monster.Eth / 100))
		elseif gizonde >= 16 then
			gizonde = ((gizonde * 38 - 68 + myMst) / 5 * (1 + (gizondeB) / 100) * (1 - monster.Eth / 100))
		end
		if razonde >= 1 and razonde < 16 then
			razonde = ((razonde * 16 + 434 + myMst) / 5 * (1 + (razondeB) / 100) * (1 - monster.Eth / 100))
		elseif razonde >= 16 then
			razonde = ((razonde * 9 + 541 + myMst) / 5 * (1 + (razondeB) / 100) * (1 - monster.Eth / 100))
		end
		
		if barta >= 1 and barta < 16 then
			barta = ((barta * 50 + myMst) / 5 * (1 + (bartaB) / 100) * (1 - monster.Eic / 100))
		elseif barta >= 16 then
			barta = ((barta * 63 - 188 + myMst) / 5 * (1 + (bartaB) / 100) * (1 - monster.Eic / 100))
		end
		if gibarta >= 1 and gibarta < 16 then
			gibarta = ((gibarta * 24 + 206 + myMst) / 5 * (1 + (gibartaB) / 100) * (1 - monster.Eic / 100))
		elseif gibarta >= 16 then
			gibarta = ((gibarta * 40 - 40 + myMst) / 5 * (1 + (gibartaB) / 100) * (1 - monster.Eic / 100))
		end
		if rabarta >= 1 and rabarta < 16 then
			rabarta = ((rabarta * 19 + 381 + myMst) / 5 * (1 + (rabartaB) / 100) * (1 - monster.Eic / 100))
		elseif rabarta >= 16 then
			rabarta = ((rabarta * 15 + 455 + myMst) / 5 * (1 + (rabartaB) / 100) * (1 - monster.Eic / 100))
		end
		
		if grants >= 1 and grants < 16 then
			grants = ((grants * 75 + 1105 + myMst) / 5 * (1 + (grantsB) / 100) * (1 - monster.Elt / 100))
		elseif grants >= 16 then
			grants = ((grants * 60 + 1340 + myMst) / 5 * (1 + (grantsB) / 100) * (1 - monster.Elt / 100))
		end
		
		--Get % chance for Megid to kill
		if megid >= 1 and megid < 16 then
			megid = ((megid * 3 + 24) - monster.Edk)
		elseif megid >= 16 then
			megid = ((megid * 2 + 40) - monster.Edk)
		end

		if options.ShowMonsterName then
			lib_helpers.TextC(true, monster.color, monster.name)
		end

		techtable = {foie,gifoie,rafoie,zonde,gizonde,razonde,barta,gibarta,rabarta,grants}
		dpstable = {foie/foieFps,gifoie/gifoieFps,rafoie/rafoieFps,zonde/zondeFps,gizonde/gizondeFps,razonde/razondeFps,barta/bartaFps,gibarta/gibartaFps,rabarta/rabartaFps,grants/grantsFps}
		efftable = {foie/foieC,gifoie/gifoieC,rafoie/rafoieC,zonde/zondeC,gizonde/gizondeC,razonde/razondeC,barta/bartaC,gibarta/gibartaC,rabarta/rabartaC,grants/grantsC}
		nametable = {"Foie","Gifoie","Rafoie","Zonde","Gizonde","Razonde","Barta","Gibarta","Rabarta","Grants"}
		colortable = {0xFFFF6600,0xFFFF6600,0xFFFF6600,0xFFFFFF00,0xFFFFFF00,0xFFFFFF00,0xFF00FFFF,0xFF00FFFF,0xFF00FFFF,0xFFFFFFB3}
		aoetable = {0,gifoie/gifoieFps,rafoie/rafoieFps,0,gizonde/gizondeFps,razonde/razondeFps,0,gibarta/gibartaFps,rabarta/rabartaFps,0}
		aoeefftable = {0,gifoie/gifoieC,rafoie/rafoieC,0,gizonde/gizondeC,razonde/razondeC,0,gibarta/gibartaC,rabarta/rabartaC,0}
		function compare(x, y)
			return x[1] > y[1]
		end
		--Efficiency-Based recommended cast
		if options.foRecShowEfficiencyBased == true then
			-- Step 1: Merge in pairs
			for i,v in ipairs(efftable) do
				efftable[i] = {efftable[i], nametable[i], techtable[i], dpstable[i], colortable[i], aoetable[i], aoeefftable[i]}
			end

			-- Step 2: Sort
			table.sort(efftable, compare)

			-- Step 3: Unmerge pairs
			for i, v in ipairs(efftable) do
				efftable[i] = v[1]
				nametable[i] = v[2]
				techtable[i] = v[3]
				dpstable[i] = v[4]
				colortable[i] = v[5]
				aoetable[i] = v[6]
				aoeefftable[i] = v[7]
			end

			color1 = colortable[1]
			name1 = nametable[1]
			tech1 = techtable[1]
			
			-- Step 1: Merge in pairs
			for i,v in ipairs(aoeefftable) do
				aoeefftable[i] = {aoeefftable[i], nametable[i], techtable[i], efftable[i], colortable[i], dpstable[i], aoetable[i]}
			end

			-- Step 2: Sort
			table.sort(aoeefftable, compare)

			-- Step 3: Unmerge pairs
			for i, v in ipairs(aoeefftable) do
				aoeefftable[i] = v[1]
				nametable[i] = v[2]
				techtable[i] = v[3]
				efftable[i] = v[4]
				colortable[i] = v[5]
				dpstable[i] = v[6]
				aoetable[i] = v[7]
			end
			
			lib_helpers.Text(true, "1")
			if tech1/techtable[1] >= 2 then
				lib_helpers.Text(false, "-")
				lib_helpers.Text(false, "%i", tech1/techtable[1])
				lib_helpers.Text(false, " Targets: ")
			else
				lib_helpers.Text(false, " Target: ")
			end
			if options.foRecShowDamage then
				lib_helpers.Text(false, "(")
				lib_helpers.TextC(false, color1, "%i", tech1)
				lib_helpers.Text(false, ") ")
			end
			lib_helpers.TextC(false, color1, name1)
			lib_helpers.Text(false, " x ")
			lib_helpers.TextC(false, color1, "%i", mHP/tech1 +.5)
			lib_helpers.Text(true, "%i", tech1/techtable[1] +.5)
			lib_helpers.Text(false, "+ Targets: ")
			if options.foRecShowDamage then
				lib_helpers.Text(false, "(")
				lib_helpers.TextC(false, colortable[1], "%i", techtable[1])
				lib_helpers.Text(false, ") ")
			end
			lib_helpers.TextC(false, colortable[1], nametable[1])
			lib_helpers.Text(false, " x ")
			lib_helpers.TextC(false, colortable[1], "%i", mHP/techtable[1] +.5)
		--DPS-Based recommended cast
		else
			-- Step 1: Merge in pairs
			for i,v in ipairs(dpstable) do
				dpstable[i] = {dpstable[i], nametable[i], techtable[i], efftable[i], colortable[i], aoetable[i], aoeefftable[i]}
			end

			-- Step 2: Sort
			table.sort(dpstable, compare)

			-- Step 3: Unmerge pairs
			for i, v in ipairs(dpstable) do
				dpstable[i] = v[1]
				nametable[i] = v[2]
				techtable[i] = v[3]
				efftable[i] = v[4]
				colortable[i] = v[5]
				aoetable[i] = v[6]
				aoeefftable[i] = v[7]
			end

			color1 = colortable[1]
			name1 = nametable[1]
			tech1 = techtable[1]
			
			-- Step 1: Merge in pairs
			for i,v in ipairs(aoetable) do
				aoetable[i] = {aoetable[i], nametable[i], techtable[i], efftable[i], colortable[i], dpstable[i], aoeefftable[i]}
			end

			-- Step 2: Sort
			table.sort(aoetable, compare)

			-- Step 3: Unmerge pairs
			for i, v in ipairs(aoetable) do
				aoetable[i] = v[1]
				nametable[i] = v[2]
				techtable[i] = v[3]
				efftable[i] = v[4]
				colortable[i] = v[5]
				dpstable[i] = v[6]
				aoeefftable[i] = v[7]
			end
			
			lib_helpers.Text(true, "1")
			if tech1/techtable[1] >= 2 then
				lib_helpers.Text(false, "-")
				lib_helpers.Text(false, "%i", tech1/techtable[1])
				lib_helpers.Text(false, " Targets: ")
			else
				lib_helpers.Text(false, " Target: ")
			end
			if options.foRecShowDamage then
				lib_helpers.Text(false, "(")
				lib_helpers.TextC(false, color1, "%i", tech1)
				lib_helpers.Text(false, ") ")
			end
			lib_helpers.TextC(false, color1, name1)
			lib_helpers.Text(false, " x ")
			lib_helpers.TextC(false, color1, "%i", mHP/tech1 +.5)
			lib_helpers.Text(true, "%i", tech1/techtable[1] +.5)
			lib_helpers.Text(false, "+ Targets: ")
			if options.foRecShowDamage then
				lib_helpers.Text(false, "(")
				lib_helpers.TextC(false, colortable[1], "%i", techtable[1])
				lib_helpers.Text(false, ") ")
			end
			lib_helpers.TextC(false, colortable[1], nametable[1])
			lib_helpers.Text(false, " x ")
			lib_helpers.TextC(false, colortable[1], "%i", mHP/techtable[1] +.5)
		end
		if megid >= 0 then
			lib_helpers.TextC(true, 0xFFEE19DC, "Megid: ")
			lib_helpers.Text(false, "%i", megid)
			lib_helpers.Text(false, "%% ")
		end
		
		if options.ShowHealthBar then
			 -- Draw enemy HP bar
			lib_helpers.imguiProgressBar(true, mHP/mHPMax, -1.0, imgui.GetFontSize(), lib_helpers.HPToGreenRedGradient(mHP/mHPMax), nil, mHP)
		end

        -- Show J/Z status and Frozen, Confuse, or Paralyzed status
        if options.showMonsterStatus then
            if atkTech.type == 0 then
                lib_helpers.TextC(true, 0, "    ")
            else
                lib_helpers.TextC(true, 0xFFFF2031, atkTech.name .. atkTech.level .. string.rep(" ", 2 - #tostring(atkTech.level)) .. " ")
            end

            if defTech.type == 0 then
                lib_helpers.TextC(false, 0, "    ")
            else
                lib_helpers.TextC(false, 0xFF0088F4, defTech.name .. defTech.level .. string.rep(" ", 2 - #tostring(defTech.level)) .. " ")
            end

            if frozen then
                lib_helpers.TextC(false, 0xFF00FFFF, "F ")
            elseif confused then
                lib_helpers.TextC(false, 0xFFFF00FF, "C ")
			elseif shocked then
				lib_helpers.TextC(false, 0xFFFFFF00, "S ")
            else
                lib_helpers.TextC(false, 0, "  ")
            end
			if paralyzed then
				lib_helpers.TextC(false, 0xFFFF4000, "P ")
			end
            imgui.NextColumn()
        end
		
		if options.ShowRares then
			PrintRareDrop(monster)
		end
		
	end
end

-- Need to use this so I can hide the window when nothing is targetted
local target2Cache = nil
local target2WindowTimeOut = 0
local function PresentTarget2MonsterWindow()
    local monster = GetTargetMonster()

    if monster == nil then
        if target2WindowTimeOut > 0 then
            target2WindowTimeOut = target2WindowTimeOut - 1
        end

        monster = target2Cache
        if target2WindowTimeOut <= 0 then
            return
        end
    else
        target2WindowTimeOut = 90
        target2Cache = monster
    end

    if options.target2EnableWindow and monster ~= nil and monster.unitxtID ~= 0 then
        if firstPresent.target2 or options.target2Changed then
          options.target2Changed = false
		  firstPresent.target2 = false
          local ps = lib_helpers.GetPosBySizeAndAnchor(options.target2X, options.target2Y, options.target2W, options.target2H, options.target2Anchor)
          imgui.SetNextWindowPos(ps[1], ps[2], "Always");
          imgui.SetNextWindowSize(options.target2W, options.target2H, "Always");
        end

        if options.target2TransparentWindow == true then
            imgui.PushStyleColor("WindowBg", 0.0, 0.0, 0.0, 0.0)
        end

        if imgui.Begin("Monster Stats", nil, { options.target2NoTitleBar, options.target2NoResize, options.target2NoMove, options.target2NoScrollbar }) then
            PresentTarget2Monster(monster)
        end
        imgui.End()

        if options.target2TransparentWindow == true then
          imgui.PopStyleColor()
        end
    end
end

-- Need to use this so I can hide the window when nothing is targetted
local RateCache = nil
local RateWindowTimeOut = 0
local function PresentRateMonsterWindow()
    local monster = GetTargetMonster()

    if monster == nil then
        if RateWindowTimeOut > 0 then
            RateWindowTimeOut = RateWindowTimeOut - 1
        end

        monster = RateCache
        if RateWindowTimeOut <= 0 then
            return
        end
    else
        RateWindowTimeOut = 90
        RateCache = monster
    end

    if options.RateEnableWindow and monster ~= nil and monster.unitxtID ~= 0 then
        if firstPresent.rate or options.RateChanged then
          options.RateChanged = false
		  firstPresent.rate = false
          local ps = lib_helpers.GetPosBySizeAndAnchor(options.RateX, options.RateY, options.RateW, options.RateH, options.RateAnchor)
          imgui.SetNextWindowPos(ps[1], ps[2], "Always");
          imgui.SetNextWindowSize(options.RateW, options.RateH, "Always");
        end

        if options.RateTransparentWindow == true then
            imgui.PushStyleColor("WindowBg", 0.0, 0.0, 0.0, 0.0)
        end

        if imgui.Begin("Activation Rates", nil, { options.RateNoTitleBar, options.RateNoResize, options.RateNoMove, options.RateNoScrollbar }) then
            PresentRateMonster(monster)
        end
        imgui.End()

        if options.RateTransparentWindow == true then
          imgui.PopStyleColor()
        end
    end
end

-- Need to use this so I can hide the window when nothing is targetted
local foRecCache = nil
local foRecWindowTimeOut = 0
local function foRecWindow()
    local monster = GetTargetMonster()

    if monster == nil then
        if foRecWindowTimeOut > 0 then
            foRecWindowTimeOut = foRecWindowTimeOut - 1
        end

        monster = foRecCache
        if foRecWindowTimeOut <= 0 then
            return
        end
    else
        foRecWindowTimeOut = 90
        foRecCache = monster
    end

    if options.foRecEnableWindow and monster ~= nil and monster.unitxtID ~= 0 then
        if firstPresent.foRec or options.foRecChanged then
          options.foRecChanged = false
		  firstPresent.foRec = false
          local ps = lib_helpers.GetPosBySizeAndAnchor(options.foRecX, options.foRecY, options.foRecW, options.foRecH, options.foRecAnchor)
          imgui.SetNextWindowPos(ps[1], ps[2], "Always");
          imgui.SetNextWindowSize(options.foRecW, options.foRecH, "Always");
        end

        if options.foRecTransparentWindow == true then
            imgui.PushStyleColor("WindowBg", 0.0, 0.0, 0.0, 0.0)
        end

        if imgui.Begin("Recommended Tech", nil, { options.foRecNoTitleBar, options.foRecNoResize, options.foRecNoMove, options.foRecNoScrollbar }) then
            foRec(monster)
        end
        imgui.End()

        if options.foRecTransparentWindow == true then
          imgui.PopStyleColor()
        end
    end
end

-- Need to use this so I can hide the window when nothing is targetted
local targetCache = nil
local targetWindowTimeOut = 0
local function PresentTargetMonsterWindow()
    local monster = GetTargetMonster()

    if monster == nil then
        if targetWindowTimeOut > 0 then
            targetWindowTimeOut = targetWindowTimeOut - 1
        end

        monster = targetCache
        if targetWindowTimeOut <= 0 then
            return
        end
    else
        targetWindowTimeOut = 90
        targetCache = monster
    end

    if options.targetEnableWindow and monster ~= nil and monster.unitxtID ~= 0 then
        if firstPresent.target or options.targetChanged then
          options.targetChanged = false
		  firstPresent.target = false
          local ps = lib_helpers.GetPosBySizeAndAnchor(options.targetX, options.targetY, options.targetW, options.targetH, options.targetAnchor)
          imgui.SetNextWindowPos(ps[1], ps[2], "Always");
          imgui.SetNextWindowSize(options.targetW, options.targetH, "Always");
        end

        if options.targetTransparentWindow == true then
            imgui.PushStyleColor("WindowBg", 0.0, 0.0, 0.0, 0.0)
        end

        if imgui.Begin("Damage Analysis - Target", nil, { options.targetNoTitleBar, options.targetNoResize, options.targetNoMove, options.targetNoScrollbar }) then
            PresentTargetMonster(monster)
        end
        imgui.End()

        if options.targetTransparentWindow == true then
          imgui.PopStyleColor()
        end
    end
end

local function present()

    if _EntityArray == 0 then
        -- Get the address of the entity array from one of the instructions that references it.
        -- Works on base client and on a client patched with a different array.
        _EntityArray = pso.read_u32(0x7B4BA0 + 2)
    end

    -- If the addon has never been used, open the config window
    -- and disable the config window setting
    if options.configurationEnableWindow then
        ConfigurationWindow.open = true
        options.configurationEnableWindow = false
    end

    ConfigurationWindow.Update()
    if ConfigurationWindow.changed then
        ConfigurationWindow.changed = false
        SaveOptions(options)
    end

    -- Global enable here to let the configuration window work
    if options.enable == false then
        return
    end

	if (options.mhpEnableWindow == true)
        and (options.mhpHideWhenMenu == false or lib_menu.IsMenuOpen() == false)
        and (options.mhpHideWhenSymbolChat == false or lib_menu.IsSymbolChatOpen() == false)
        and (options.mhpHideWhenMenuUnavailable == false or lib_menu.IsMenuUnavailable() == false)
    then
        if firstPresent.room or options.mhpChanged then
            options.mhpChanged = false
			firstPresent.room = false
            local ps = lib_helpers.GetPosBySizeAndAnchor(options.mhpX, options.mhpY, options.mhpW, options.mhpH, options.mhpAnchor)
            imgui.SetNextWindowPos(ps[1], ps[2], "Always");
            imgui.SetNextWindowSize(options.mhpW, options.mhpH, "Always");
        end
        if options.mhpTransparentWindow == true then
            imgui.PushStyleColor("WindowBg", 0.0, 0.0, 0.0, 0.0)
        end
        if imgui.Begin("Monster Reader - Room", nil, { options.mhpNoTitleBar, options.mhpNoResize, options.mhpNoMove }) then
            PresentMonsters()
        end
        imgui.End()
        if options.mhpTransparentWindow == true then
            imgui.PopStyleColor()
        end
    end

	refresh_side_text()

    PresentTargetMonsterWindow()
	foRecWindow()
	PresentTarget2MonsterWindow()
	PresentRateMonsterWindow()
	
end

local function init()
    ConfigurationWindow = cfg.ConfigurationWindow(options)

    local function mainMenuButtonHandler()
        ConfigurationWindow.open = not ConfigurationWindow.open
    end

    core_mainmenu.add_button("Damage Analysis", mainMenuButtonHandler)

    return
    {
        name = "Damage Analysis",
        version = "1.0.0",
        author = "Quilliamson",
        description = "Information about player damage",
        present = present,
    }
end

return
{
    __addon =
    {
        init = init
    }
}
