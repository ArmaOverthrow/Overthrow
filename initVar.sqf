//Here is where you can change stuff to suit your liking or support mods/another map
private ["_allPrimaryWeapons","_allHandGuns","__allLaunchers"];

AIT_spawnBlacklist = ["Georgetown","Sosovu","Tuvanaka","Belfort","Nani","Saint-Julien","Ipota"]; //dont spawn in these towns

AIT_hasAce = false;
if (!isNil "ace_common_settingFeedbackIcons") then {
	AIT_hasAce = true;
};
AIT_fastTime = true; //When true, 1 day will last 6 hrs real time
AIT_spawnDistance = 1200;
AIT_spawnCivPercentage = 0.08;
AIT_spawnVehiclePercentage = 0.04;
AIT_standardMarkup = 0.2; //Markup in shops is calculated from this
AIT_randomSpawnTown = false; //if true, every player will start in a different town, if false, all players start in the same town (Multiplayer only)
AIT_distroThreshold = 500; //Size a towns order must be before a truck is sent (in dollars)
AIT_saving = false;

AIT_flag_NATO = "Flag_NATO_F";
AIT_flag_CRIM = "Flag_Syndikat_F";

AIT_item_wrecks = ["Land_Wreck_HMMWV_F","Land_Wreck_Skodovka_F","Land_Wreck_Truck_F","Land_Wreck_Car2_F","Land_Wreck_Car_F","Land_Wreck_Hunter_F","Land_Wreck_Offroad_F","Land_Wreck_Offroad2_F","Land_Wreck_UAZ_F","Land_Wreck_Truck_dropside_F"]; //rekt

AIT_spawnTowns = ["Balavu","Rautake","Namuvaka","Laikoro","Tavu","Muaceba","Leqa"]; //Towns where new players will spawn
AIT_spawnHouses = ["Land_Slum_01_F","Land_Slum_02_F","Land_House_Native_02_F"]; //Houses where new players will spawn 

AIT_NATOwait = 200; //Half the Average time between NATO orders
AIT_CRIMwait = 200; //Half the Average time between crim changes

//Interactable items that spawn in your house
AIT_item_Storage = "B_CargoNet_01_ammo_F"; //Your spawn ammobox
AIT_item_Desk = "OfficeTable_01_new_F"; //Your spawn desk
AIT_item_Radio = "Land_PortableLongRangeRadio_F";
AIT_item_Map = "Land_MapBoard_F";
AIT_item_Repair = "Land_ToolTrolley_02_F";
AIT_item_Tent = "Land_TentDome_F";
AIT_item_Flag = "Flag_HorizonIslands_F";

AIT_Placeables = [
	["Sandbags",20,["Land_BagFence_01_long_green_F","Land_BagFence_01_short_green_F","Land_BagFence_01_round_green_F","Land_BagFence_01_corner_green_F","Land_BagFence_01_end_green_F"],[0,3,0.8]],
	["Camo Nets",40,["CamoNet_ghex_F","CamoNet_ghex_open_F","CamoNet_ghex_big_F"],[0,7,2]],
	["Barriers",60,["Land_HBarrier_01_line_5_green_F","Land_HBarrier_01_line_3_green_F","Land_HBarrier_01_line_1_green_F"],[0,4,1.2]],
	["Misc",30,[AIT_item_Map,AIT_item_Repair,"Land_PortableLight_single_F","Land_PortableLight_double_F","Land_Camping_Light_F","Land_PortableHelipadLight_01_F","PortableHelipadLight_01_blue_F","PortableHelipadLight_01_green_F","PortableHelipadLight_01_red_F","PortableHelipadLight_01_white_F","PortableHelipadLight_01_yellow_F","Land_Campfire_F"],[0,2,1.2]],
	["Deploy",500,["B_Boat_Transport_01_F","I_HMG_01_high_F","I_HMG_01_F"],[0,2.3,2]]
];

AIT_Buildables_Base = [
	["Training Camp",1500,[] call compileFinal preProcessFileLineNumbers "templates\military\trainingCamp.sqf","structures\trainingCamp.sqf",true,"Allows training of recruits and hiring of mercenaries"],
	["Bunkers",500,["Land_BagBunker_01_small_green_F","Land_HBarrier_01_big_tower_green_F","Land_HBarrier_01_tower_green_F"],"",false,"Small Defensive Structures. Press space to change type."],
	["Walls",200,["Land_ConcreteWall_01_l_8m_F","Land_ConcreteWall_01_l_gate_F","Land_HBarrier_01_wall_6_green_F","Land_HBarrier_01_wall_4_green_F","Land_HBarrier_01_wall_corner_green_F"],"",false,"Stop people (or tanks) from getting in. Press space to change type."],
	["Helipad",50,["Land_HelipadCircle_F","Land_HelipadCivil_F","Land_HelipadRescue_F","Land_HelipadSquare_F"],"",false,"Apparently helicopter pilots need to be told where they are allowed to land"],
	["Observation Post",800,["Land_Cargo_Patrol_V4_F"],"structures\observationPost.sqf",false,"Includes unarmed personnel to keep an eye over the area and provide intel on enemy positions"]
];

AIT_voices_local = ["Male01FRE","Male02FRE","Male03FRE"];
AIT_faces_local = ["TanoanHead_A3_01","TanoanHead_A3_02","TanoanHead_A3_03","TanoanHead_A3_04","TanoanHead_A3_05","TanoanHead_A3_06","TanoanHead_A3_07","TanoanHead_A3_08","TanoanHead_A3_09"];

AIT_civType_gunDealer = "C_man_p_fugitive_F";
AIT_civType_local = "C_man_1";
AIT_civType_carDealer = "C_man_w_worker_F";
AIT_civType_shopkeeper = "C_man_w_worker_F";
AIT_civType_worker = "C_man_w_worker_F";
AIT_vehTypes_civ = ["CUP_C_Skoda_Blue_CIV","CUP_C_Skoda_Green_CIV","CUP_C_Skoda_Red_CIV","CUP_C_Skoda_White_CIV","CUP_C_Datsun","CUP_C_Datsun_4seat","CUP_C_Datsun_Covered","CUP_C_Datsun_Plain","CUP_C_Datsun_Tubeframe","CUP_C_LR_Transport_CTK"];
AIT_vehType_distro = "C_Van_01_box_F";

AIT_activeDistribution = [];
AIT_activeShops = [];
AIT_selling = false;

//Shop items
AIT_item_ShopRegister = "Land_CashDesk_F";//Cash registers
AIT_item_BasicGun = "hgun_P07_F";//Player starts with this weapon in their ammobox
AIT_item_BasicAmmo = "16Rnd_9x21_Mag";

if(AIT_hasAce) then {
	AIT_consumableItems = ["ACE_fieldDressing","ACE_Sandbag_empty","ACE_elasticBandage"]; //Shops will try to stock more of these
}else{
	AIT_consumableItems = ["FirstAidKit","Medikit"];
};
AIT_illegalHeadgear = ["H_MilCap_gen_F","H_Beret_gen_F","H_HelmetB_TI_tna_F"];
AIT_illegalVests = ["V_TacVest_gen_F"];

if(AIT_hasAce) then {
	AIT_illegalItems = ["ACE_morphine","ACE_epinephrine","ACE_adenosine"];
}else{
	AIT_illegalItems = [];
};

AIT_item_UAV = "I_UAV_01_F";
AIT_item_UAVterminal = "I_UavTerminal";

AIT_items_distroStorage = ["CargoNet_01_box_F"]; //Where distribution centers store inventory
AIT_items_Simulate = ["Box_NATO_Equip_F","Box_T_East_Wps_F","B_CargoNet_01_ammo_F","OfficeTable_01_old_F","Land_PortableLongRangeRadio_F"]; //These will be saved, position + inventory and have gravity

AIT_staticMachineGuns = ["I_HMG_01_F","I_HMG_01_high_F","I_HMG_01_A_F","O_HMG_01_F","O_HMG_01_high_F","O_HMG_01_A_F","B_HMG_01_F","B_HMG_01_high_F","B_HMG_01_A_F"];
AIT_staticWeapons = ["I_Mortar_01_F","I_static_AA_F","I_static_AT_F","I_GMG_01_F","I_GMG_01_high_F","I_GMG_01_A_F","I_HMG_01_F","I_HMG_01_high_F","I_HMG_01_A_F","O_static_AA_F","O_static_AT_F","O_Mortar_01_F","O_GMG_01_F","O_GMG_01_high_F","O_GMG_01_A_F","O_HMG_01_F","O_HMG_01_high_F","O_HMG_01_A_F","B_static_AA_F","B_static_AT_F","B_Mortar_01_F","B_GMG_01_F","B_GMG_01_high_F","B_GMG_01_A_F","B_HMG_01_F","B_HMG_01_high_F","B_HMG_01_A_F"];

AIT_clothes_locals = ["CUP_U_I_GUE_Anorak_01","CUP_U_I_GUE_Anorak_02","CUP_U_I_GUE_Anorak_03","U_I_C_Soldier_Bandit_2_F","U_I_C_Soldier_Bandit_3_F","U_C_Poor_1"];
AIT_clothes_expats = ["U_I_C_Soldier_Bandit_5_F","U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_redwhite","U_C_Poloshirt_salmon","U_C_Poloshirt_stripped","U_C_Man_casual_6_F","U_C_Man_casual_4_F","U_C_Man_casual_5_F"];
AIT_clothes_tourists = [];
AIT_clothes_port = "U_Marshal";
AIT_clothes_shops = ["U_C_Man_casual_2_F","U_C_Man_casual_3_F","U_C_Man_casual_1_F"];
AIT_clothes_carDealers = ["CUP_U_C_Mechanic_01","CUP_U_C_Mechanic_02","CUP_U_C_Mechanic_03"];
AIT_clothes_harbor = ["U_C_man_sport_1_F","U_C_man_sport_2_F","U_C_man_sport_3_F"];
AIT_clothes_guerilla = ["U_I_C_Soldier_Para_1_F","U_I_C_Soldier_Para_2_F","U_I_C_Soldier_Para_3_F","U_I_C_Soldier_Para_5_F","U_I_C_Soldier_Para_4_F"];
AIT_clothes_mob = "U_I_C_Soldier_Camo_F";

AIT_ammo_50cal = "100Rnd_127x99_mag";

//NATO stuff
AIT_NATOregion = "island_5"; //where NATO lives
AIT_NATOwhitelist = ["Comms Alpha","Comms Bravo","Comms Whiskey","port","fuel depot","railway depot"]; //NameLocal/Airport place names to definitely occupy with military personnel
AIT_NATO_priority = ["Tuvanaka Airbase","Comms Alpha","Blue Pearl industrial port","Nani","Belfort","Tuvanaka"];
AIT_NATO_control = ["control_1","control_2","control_3","control_4","control_5","control_6","control_7","control_8","control_9","control_10","control_11","control_12","control_13","control_14","control_15","control_16","control_17","control_18"]; //NATO checkpoints, create markers in editor
AIT_NATO_HQ = "Tuvanaka Airbase";
AIT_NATO_AirSpawn = "NATO_airspawn";
AIT_NATO_HQPos = [0,0,0];//Dont worry this gets populated later

AIT_NATO_Vehicles_Garrison = [
	["B_T_MBT_01_TUSK_F", 7],
	["B_T_MBT_01_cannon_F",7],
	["B_T_LSV_01_armed_F",14],
	["B_T_MRAP_01_hmg_F",20],
	["B_T_MRAP_01_gmg_F",20],
	["B_T_APC_Tracked_01_AA_F",10],
	["B_T_Static_AA_F",15],
	["B_T_Mortar_01_F",10],
	["B_T_Static_AT_F",20],
	["B_HMG_01_high_F",40],
	["B_T_MBT_01_mlrs_F",2],
	["B_T_MBT_01_arty_F",2]
];

AIT_NATO_Vehicles_AirGarrison = [
	["B_T_VTOL_01_vehicle_F",1],
	["B_T_VTOL_01_infantry_F",1],
	["B_Heli_Light_01_armed_F",1],
	["B_Heli_Transport_03_unarmed_F",4],
	["B_Heli_Light_01_F",6],
	["B_Heli_Attack_01_F",1],
	["B_Heli_Transport_01_F",4],
	["B_Plane_CAS_01_F",1],
	["CUP_B_AV8B_CAP_USMC",1],
	["CUP_B_C130J_USMC",3],
	["CUP_B_F35B_AA_USMC",1],
	["CUP_B_CH53E_GER",2]
];

AIT_NATO_Unit_PoliceCommander = "B_Gen_Commander_F";
AIT_NATO_Unit_Police = "B_Gen_Soldier_F";
AIT_NATO_Vehicle_PoliceHeli = "B_Heli_Light_01_F";
AIT_NATO_Vehicle_Quad = "B_Quadbike_01_F";
AIT_NATO_Vehicle_Police = "B_GEN_Offroad_01_gen_F";
AIT_NATO_Vehicle_Transport = "B_T_Truck_01_transport_F";
AIT_NATO_Vehicles_PoliceSupport = ["B_T_MRAP_01_hmg_F","B_T_MRAP_01_gmg_F","B_T_LSV_01_armed_F","B_Heli_Light_01_armed_F"];
AIT_NATO_Vehicles_AirDrones = ["B_UAV_02_F"];
AIT_NATO_Vehicles_AirSupport = ["B_Heli_Attack_01_F","B_Heli_Light_01_armed_F"];
AIT_NATO_Vehicles_AirWingedSupport = ["B_Plane_CAS_01_F"];
AIT_NATO_Vehicle_AirTransport = "B_Heli_Transport_03_F";

AIT_NATO_Unit_LevelOneLeader = "B_T_Soldier_TL_F";
AIT_NATO_Units_LevelOne = ["B_T_Medic_F","B_T_Soldier_F","B_T_Soldier_LAT_F","B_T_Soldier_AAT_F","B_T_Soldier_AT_F","B_T_soldier_M_F","B_T_Soldier_GL_F","B_T_Soldier_AR_F"];
AIT_NATO_Units_LevelTwo = AIT_NATO_Units_LevelOne + ["B_T_Soldier_AA_F","B_T_Soldier_AAR_F","B_T_Soldier_AAA_F","B_T_Sniper_F","B_T_Spotter_F"];

AIT_NATO_Units_CTRGSupport = ["B_CTRG_Soldier_TL_tna_F","B_CTRG_Soldier_tna_F","B_CTRG_Soldier_M_tna_F","B_CTRG_Soldier_Medic_tna_F"];
AIT_NATO_Vehicle_CTRGTransport = "B_CTRG_Heli_Transport_01_tropic_F";

AIT_NATO_weapons_Police = ["hgun_PDW2000_F","SMG_05_F","SMG_01_F","SMG_02_F","arifle_SPAR_01_blk_F","CUP_arifle_M4A1_black","arifle_MXC_Black_F"];
AIT_NATO_weapons_Pistols = ["hgun_Pistol_heavy_01_F","hgun_ACPC2_F","hgun_P07_F","hgun_Rook40_F"];

//Criminal stuff
AIT_CRIM_Unit = "C_man_p_fugitive_F";
AIT_CRIM_Clothes = ["U_I_C_Soldier_Bandit_3_F","U_BG_Guerilla3_1","U_C_HunterBody_grn","U_I_G_Story_Protagonist_F"];
AIT_CRIM_Goggles = ["G_Balaclava_blk","G_Balaclava_combat","G_Balaclava_lowprofile","G_Balaclava_oli","G_Bandanna_blk","G_Bandanna_khk","G_Bandanna_oli","G_Bandanna_shades","G_Bandanna_sport","G_Bandanna_tan"];

//ECONOMY

//This is the prices table, shops will only stock these items, any others must be imported or produced and will have their costs generated automatically
//Format ["Cfg class",Base price,Steel,Wood,Plastics]

//The price of an item in a shop will be the base price + local markup (taking into account stability and player rep)
//The cost to produce an item will be the Base price - player/factory bonuses + raw materials
//The wholesale sell price of an item will be the base price - local markup
//NB: the local markup can be negative, making buy prices lower and sell prices higher, in certain situations (high stability and/or player rep)

AIT_items = [];
if(AIT_hasAce) then {
	[AIT_items,[
		["ACE_fieldDressing",2,0,0,0.1],
		["ACE_elasticBandage",3,0,0,0.2],
		["ACE_SpraypaintBlue",20,0,0,0.2],
		["ACE_SpraypaintRed",20,0,0,0.2],
		["ACE_SpraypaintBlack",20,0,0,0.2],
		["ACE_EarPlugs",5,0,0,0.2],		
		["ACE_Sandbag_empty",2,0,0,0],
		["ACE_Altimeter",110,0,0,1],
		["ACE_Banana",1,0,0,0],
		["ACE_microDAGR",200,0,0,1]
	]] call BIS_fnc_arrayPushStack;
}else{
	[AIT_items,[
		["FirstAidKit",10,0,0,0.1],
		["Medikit",40,0,0,0.5]
	]] call BIS_fnc_arrayPushStack;
};

[AIT_items,[
	["ToolKit",25,1,0,0],
	["ItemGPS",60,0,0,1],
	["ItemCompass",5,0.1,0,0],
	["ItemMap",1,0,0,0],
	["ItemWatch",30,0,0,1],
	["Binocular",70,0,0,1],
	["Rangefinder",130,0,0,1],
	["ItemRadio",20,0,0,1]
]] call BIS_fnc_arrayPushStack;

AIT_staticBackpacks = [
	["I_HMG_01_high_weapon_F",500,1,0,1],	
	["I_GMG_01_high_weapon_F",1000,1,0,1],
	["I_HMG_01_support_high_F",50,1,0,0],
	["I_HMG_01_weapon_F",500,1,0,1],
	["I_HMG_01_support_F",50,1,0,0],
	["I_Mortar_01_weapon_F",1500,1,0,1],
	["I_Mortar_01_support_F",100,1,0,0],	
	["I_HMG_01_A_weapon_F",2500,1,0,1],
	["I_GMG_01_A_weapon_F",4000,1,01]
];

AIT_backpacks = [
	["B_AssaultPack_cbr",30,0,0,1],
	["B_AssaultPack_blk",30,0,0,1],
	["B_AssaultPack_khk",30,0,0,1],
	["B_AssaultPack_sgg",30,0,0,1],
	["B_FieldPack_cbr",50,0,0,1],
	["B_FieldPack_blk",50,0,0,1],
	["B_FieldPack_khk",50,0,0,1],
	["B_FieldPack_oli",50,0,0,1],
	["B_Kitbag_cbr",65,0,0,1],
	["B_Kitbag_sgg",65,0,0,1],
	["B_Carryall_cbr",80,0,0,1],
	["B_Carryall_khk",80,0,0,1],
	["B_Carryall_oli",80,0,0,1],
	["B_Bergen_dgtl_F",100,0,0,1],
	["B_Bergen_hex_F",100,0,0,1]
];
AIT_boats = [
	["C_Scooter_Transport_01_F",150,1,0,1],	
	["C_Boat_Civil_01_rescue_F",300,1,1,1],
	["C_Boat_Transport_02_F",600,1,0,1]
];
AIT_vehicles = [	
	["CUP_C_Skoda_Blue_CIV",30,1,1,1],
	["CUP_C_Skoda_Green_CIV",30,1,1,1],
	["CUP_C_Skoda_Red_CIV",30,1,1,1],
	["CUP_C_Skoda_White_CIV",30,1,1,1],
	["CUP_C_Datsun",60,1,1,1],
	["CUP_C_Datsun_Covered",60,1,1,1],
	["C_Quadbike_01_F",80,1,1,1],
	["CUP_C_Golf4_black_Civ",200,1,1,1],
	["CUP_C_Golf4_blue_Civ",200,1,1,1],
	["CUP_C_Golf4_green_Civ",200,1,1,1],
	["CUP_C_Golf4_white_Civ",200,1,1,1],
	["CUP_C_Golf4_yellow_Civ",200,1,1,1],
	["CUP_C_Octavia_CIV",300,1,1,1],
	["C_SUV_01_F",400,1,1,1],
	["C_Offroad_01_F",500,1,1,1],
	["C_Offroad_02_unarmed_F",600,1,1,1],
	["C_Van_01_transport_F",700,1,1,1],
	["C_Van_01_fuel_F",900,1,1,1],
	["C_Van_01_box_F",800,1,1,1],
	["C_Truck_02_transport_F",1000,1,1,1],
	["C_Truck_02_covered_F",1000,1,1,1],
	["C_Truck_02_fuel_F",2000,1,1,1],
	["C_Truck_02_box_F",1500,1,1,1]
];

AIT_allVehicles = [];
AIT_allBoats = ["B_Boat_Transport_01_F"];
AIT_allItems = [];
AIT_allWeapons = [];
AIT_allMagazines = [AIT_ammo_50cal];
AIT_allBackpacks = [];
AIT_allStaticBackpacks = [];

_allWeapons = "
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2
    &&
    { getText ( _x >> ""simulation"" ) isEqualTo ""Weapon""})
" configClasses ( configFile >> "cfgWeapons" );



AIT_allSubMachineGuns = [];
AIT_allAssaultRifles = [];
AIT_allMachineGuns = [];
AIT_allSniperRifles = [];
AIT_allHandGuns = [];
AIT_allMissileLaunchers = [];
AIT_allRocketLaunchers = [];
AIT_allExpensiveRifles = [];
AIT_allVests = [];
AIT_allProtectiveVests = [];
AIT_allExpensiveVests = [];

{
	_name = configName _x;
	_name = [_name] call BIS_fnc_baseWeapon;
	
	_short = getText (configFile >> "CfgWeapons" >> _name >> "descriptionShort");
	
	_s = _short splitString ":";
	_caliber = " 5.56";
	_haslauncher = false;
	if(count _s > 1) then{
		_s = (_s select 1) splitString "x";
		_caliber = _s select 0;
	};
	
	_magazines = getArray (configFile >> "CfgWeapons" >> _name >> "magazines");
	{
		if !(_x in AIT_allMagazines) then {
			AIT_allMagazines pushback _x;
		};
	}foreach(_magazines);
	
	_weapon = [_name] call BIS_fnc_itemType;
	_weaponType = _weapon select 1;
	
	_muzzles = getArray (configFile >> "CfgWeapons" >> _name >> "muzzles");
	{
		if((_x find "EGLM") > -1) then {
			_haslauncher = true;
		};
	}foreach(_muzzles);
	
	_cost = 500;
	switch (_weaponType) do	{
		case "SubmachineGun": {_cost = 250;AIT_allSubMachineGuns pushBack _name};
		
		case "AssaultRifle": {
			call {
				if(_caliber == " 5.56" or _caliber == "5.56" or _caliber == " 5.45" or _caliber == " 5.8") exitWith {_cost = 500};
				if(_caliber == " 12 gauge") exitWith {_cost = 1200};
				if(_caliber == " .338 Lapua Magnum" or _caliber == " .408" or _caliber == " .303") exitWith {_cost = 800};
				if(_caliber == " 9") exitWith {_cost = 400}; //9x21mm
				if(_caliber == " 6.5") exitWith {_cost = 1000};
				if(_caliber == " 7.62") exitWith {_cost = 1500};
				if(_caliber == " 9.3" or _caliber == "9.3") exitWith {_cost = 1700};
				if(_caliber == " 12.7") exitWith {_cost = 2500};
				//I dunno what caliber this is
				_cost = 1500;
			};
			if(_haslauncher) then {_cost = round(_cost * 1.2)};
			AIT_allAssaultRifles pushBack _name;
			if(_cost > 1400) then {
				AIT_allExpensiveRifles pushback _name;
			};
		};
		case "MachineGun": {_cost = 1500;AIT_allMachineGuns pushBack _name};
		case "SniperRifle": {_cost = 2000;AIT_allSniperRifles pushBack _name};
		case "Handgun": {_cost = 100;AIT_allHandGuns pushBack _name};
		case "MissileLauncher": {_cost=2500;AIT_allMissileLaunchers pushBack _name};
		case "RocketLauncher": {_cost = 1500;AIT_allRocketLaunchers pushBack _name};
		case "Vest": {
			if !(_name in (AIT_illegalVests + ["V_RebreatherB","V_RebreatherIA","V_RebreatherIR","V_Rangemaster_belt"])) then {
				_cost = 80 + (getNumber(configFile >> "CfgWeapons" >> _name >> "ItemInfo" >> "HitpointsProtectionInfo" >> "Chest" >> "armor") * 50);				
				AIT_allVests pushBack _name;
				if(_cost > 80) then {
					AIT_allProtectiveVests pushback _name;
				};
				if(_cost > 900) then {
					AIT_allExpensiveVests pushback _name;
				};
			};
		};
	};		
	cost setVariable [_name,[_cost,1,0,1],true];
} foreach (_allWeapons);

AIT_allWeapons = AIT_allSubMachineGuns + AIT_allAssaultRifles + AIT_allMachineGuns + AIT_allSniperRifles + AIT_allHandGuns + AIT_allMissileLaunchers + AIT_allRocketLaunchers;

if(isServer) then {
	cost setVariable ["CIV",[35,0,0,0],true];
	cost setVariable [AIT_item_UAV,[200,0,0,1],true];
};
//populate the cost gamelogic with the above data so it can be accessed quickly
{
	if(isServer) then {
		cost setVariable [_x select 0,[_x select 1,_x select 2,_x select 3,_x select 4],true];
	};
	AIT_allItems pushBack (_x select 0);
}foreach(AIT_items);
{
	if(isServer) then {
		cost setVariable [_x select 0,[_x select 1,_x select 2,_x select 3,_x select 4],true];
	};
	AIT_allBackpacks pushBack (_x select 0);
}foreach(AIT_backpacks);
{
	if(isServer) then {
		cost setVariable [_x select 0,[_x select 1,_x select 2,_x select 3,_x select 4],true];
	};
	AIT_allStaticBackpacks pushBack (_x select 0);
}foreach(AIT_staticBackpacks);
{
	if(isServer) then {
		cost setVariable [_x select 0,[_x select 1,_x select 2,_x select 3,_x select 4],true];
	};
	AIT_allVehicles pushBack (_x select 0);
}foreach(AIT_vehicles);
{
	if(isServer) then {
		cost setVariable [_x select 0,[_x select 1,_x select 2,_x select 3,_x select 4],true];
	};
	AIT_allBoats pushBack (_x select 0);
}foreach(AIT_boats);

AIT_regions = ["island_1","island_2","island_3","island_4","island_5","island_6","island_7"]; //for both economic and travel purposes. define rectangles in eden
AIT_capitals = ["Georgetown","Lijnhaven","Katkoula","Balavu","Tuvanaka","Sosovu","Ipota"]; //region capitals
AIT_sprawling = ["Blue Pearl industrial port"];

AIT_mansions = ["Land_House_Big_02_F","Land_House_Big_03_F"]; //buildings that rich guys like to live in

AIT_gunDealerHouses = ["Land_Slum_01_F","Land_Slum_02_F","Land_House_Big_02_F","Land_House_Small_03_F","Land_House_Small_06_F","Land_GarageShelter_01_F","Land_House_Small_05_F","Land_House_Native_02_F"];//houses where gun dealers will spawn

AIT_crimHouses = AIT_spawnHouses + AIT_gunDealerHouses + AIT_mansions;

AIT_lowPopHouses = AIT_spawnHouses + ["Land_House_Small_06_F","Land_House_Small_02_F","Land_House_Small_03_F","Land_GarageShelter_01_F","Land_Slum_04_F"]; //buildings with just 1-4 people living in them (also player start houses)
AIT_medPopHouses = ["Land_House_Small_04_F","Land_House_Native_01_F","Land_House_Big_01_F","Land_Slum_05_F","Land_House_Small_01_F","Land_Slum_03_F","Land_Slum_04_F","Land_House_Small_05_F","Land_Addon_04_F"]; //buildings with 5-10 people living in them
AIT_highPopHouses = ["Land_House_Big_04_F","Land_Warehouse_01_F"]; //buildings with up to 20 (the warehouses are because ports end up with low pop)
AIT_hugePopHouses = ["Land_MultistoryBuilding_03_F"]; //buildings with potentially lots of people living in them
AIT_touristHouses = ["Land_House_Big_05_F"]; //hostels and the like
AIT_allShops = ["Land_Shop_Town_01_F","Land_Shop_Town_02_F","Land_Shop_Town_03_F","Land_Shop_Town_04_F","Land_Shop_Town_05_F","Land_Shop_City_01_F","Land_Shop_City_02_F","Land_Shop_City_03_F","Land_Shop_City_04_F","Land_Shop_City_05_F","Land_Shop_City_06_F","Land_Shop_City_07_F"]; //used to calculate civ spawn positions and initial stability
AIT_markets = []; //buildings/objects that will spawn local markets (no templates required)
AIT_shops = ["Land_FuelStation_01_shop_F","Land_Shop_Town_01_F","Land_Shop_Town_03_F","Land_Shop_City_02_F","Land_Supermarket_01_F"]; //buildings that will spawn the main shops (must have a template with a cash register)
AIT_warehouses = ["Land_Warehouse_03_F"]; //buildings that will spawn local distribution centers
AIT_carShops = ["Land_FuelStation_01_workshop_F","Land_FuelStation_02_workshop_F"]; //buildings that will spawn car salesmen (must have a template with a cash register)
AIT_piers = ["Land_PierConcrete_01_steps_F","Land_PierWooden_01_platform_F","Land_PierConcrete_01_end_F","Land_PierWooden_01_hut_F"]; //spawns dudes that sell boats n stuff
AIT_offices = ["Land_MultistoryBuilding_01_F","Land_MultistoryBuilding_04_F"]; 
AIT_portBuildings = ["Land_Warehouse_01_F","Land_Warehouse_02_F","Land_ContainerLine_01_F","Land_ContainerLine_02_F","Land_ContainerLine_03_F"];
AIT_airportTerminal = "Land_Airport_01_terminal_F";
AIT_portBuilding = "Land_Warehouse_02_F";

AIT_allBuyableBuildings = AIT_lowPopHouses + AIT_medPopHouses + AIT_highPopHouses + AIT_hugePopHouses + AIT_mansions + [AIT_item_Tent,AIT_item_Flag];

{
	_istpl = _x select 4;
	if(_istpl) then {
		_tpl = _x select 2;
		AIT_allBuyableBuildings pushback ((_tpl select 0) select 0);
	};
}foreach(AIT_Buildables_Base);

AIT_allHouses = AIT_lowPopHouses + AIT_medPopHouses + AIT_highPopHouses + AIT_hugePopHouses + AIT_touristHouses;
AIT_allEnterableHouses = ["Land_House_Small_02_F","Land_House_Big_02_F","Land_House_Small_03_F","Land_House_Small_06_F","Land_House_Big_01_F","Land_Slum_05_F","Land_Slum_01_F","Land_GarageShelter_01_F","Land_House_Small_01_F","Land_Slum_03_F","Land_House_Big_04_F","Land_House_Small_04_F","Land_House_Small_05_F"];

AIT_allTowns = [];

//get all the templates we need

{
	_filename = format["templates\houses\%1.sqf",_x];
	if(_filename call KK_fnc_fileExists) then {
		_template = call(compileFinal preProcessFileLineNumbers _filename);
		{
			if((_x select 0) in AIT_items_Simulate) then {
				_x set [8,true];
			}else{
				_x set [8,false];
			};
		}forEach(_template);
		
		templates setVariable [_x,_template,true];		
	};	
} foreach(AIT_mansions + AIT_lowPopHouses + AIT_medPopHouses + AIT_highPopHouses + AIT_shops + AIT_carShops);

{
	AIT_allTowns pushBack (text _x);
	if(isServer) then {
		server setVariable [text _x,getpos _x,true];
	};
}foreach (nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["NameCityCapital","NameCity","NameVillage","CityCenter"], 50000]);

AIT_allAirports = [];
{
		AIT_allAirports pushBack text _x;
}foreach (nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["Airport"], 50000]);
