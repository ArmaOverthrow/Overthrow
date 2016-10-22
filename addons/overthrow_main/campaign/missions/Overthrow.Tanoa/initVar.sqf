//Here is where you can change stuff to suit your liking or support mods/another map
private ["_allPrimaryWeapons","_allHandGuns","__allLaunchers"];

OT_centerPos = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");

//Used to control updates and persistent save compatability. When these numbers go up, that section will be reinitialized on load if required. (ie leave them alone)
OT_economyVersion = 3;
OT_NATOversion = 2;
OT_CRIMversion = 1;

OT_hasAce = false;
if (!isNil "ace_common_settingFeedbackIcons") then {
	OT_hasAce = true;
};
OT_fastTime = true; //When true, 1 day will last 6 hrs real time
OT_spawnDistance = 1200;
OT_spawnCivPercentage = 0.08;
OT_spawnVehiclePercentage = 0.03;
OT_standardMarkup = 0.2; //Markup in shops is calculated from this
OT_randomSpawnTown = false; //if true, every player will start in a different town, if false, all players start in the same town (Multiplayer only)
OT_distroThreshold = 500; //Size a towns order must be before a truck is sent (in dollars)
OT_saving = false;

OT_flag_NATO = "Flag_NATO_F";
OT_flag_CRIM = "Flag_Syndikat_F";

OT_item_wrecks = ["Land_Wreck_HMMWV_F","Land_Wreck_Skodovka_F","Land_Wreck_Truck_F","Land_Wreck_Car2_F","Land_Wreck_Car_F","Land_Wreck_Hunter_F","Land_Wreck_Offroad_F","Land_Wreck_Offroad2_F","Land_Wreck_UAZ_F","Land_Wreck_Truck_dropside_F"]; //rekt

OT_spawnTowns = ["Rautake","Tavu","Balavu","Muaceba","Katkoula","Savaka"]; //Towns where new players will spawn
OT_spawnHouses = ["Land_Slum_01_F","Land_Slum_02_F","Land_House_Native_02_F"]; //Houses where new players will spawn 

OT_NATOwait = 200; //Half the Average time between NATO orders
OT_CRIMwait = 200; //Half the Average time between crim changes

//Interactable items that spawn in your house
OT_item_Storage = "B_CargoNet_01_ammo_F"; //Your spawn ammobox
OT_item_Desk = "OfficeTable_01_new_F"; //Your spawn desk
OT_item_Radio = "Land_PortableLongRangeRadio_F";
OT_item_Map = "Land_MapBoard_F";
OT_item_Repair = "Land_ToolTrolley_02_F";
OT_item_Tent = "Land_TentDome_F";
OT_item_Flag = "Flag_HorizonIslands_F";

OT_allLowAnimals = ["Rabbit_F","Turtle_F"];
OT_allHighAnimals = ["Goat_random_F"];
OT_allFarmAnimals = ["Hen_random_F","Cock_random_F","Sheep_random_F"];
OT_allVillageAnimals = ["Hen_random_F","Cock_random_F"];
OT_allTownAnimals = ["Alsatian_Random_F","Fin_random_F"];

OT_Placeables = [
	["Sandbags",20,["Land_BagFence_01_long_green_F","Land_BagFence_01_short_green_F","Land_BagFence_01_round_green_F","Land_BagFence_01_corner_green_F","Land_BagFence_01_end_green_F"],[0,3,0.8]],
	["Camo Nets",40,["CamoNet_ghex_F","CamoNet_ghex_open_F","CamoNet_ghex_big_F"],[0,7,2]],
	["Barriers",60,["Land_HBarrier_01_line_5_green_F","Land_HBarrier_01_line_3_green_F","Land_HBarrier_01_line_1_green_F"],[0,4,1.2]],
	["Misc",30,[OT_item_Map,OT_item_Repair,"Land_PortableLight_single_F","Land_PortableLight_double_F","Land_Camping_Light_F","Land_PortableHelipadLight_01_F","PortableHelipadLight_01_blue_F","PortableHelipadLight_01_green_F","PortableHelipadLight_01_red_F","PortableHelipadLight_01_white_F","PortableHelipadLight_01_yellow_F","Land_Campfire_F"],[0,2,1.2]],
	["Deploy",500,["B_Boat_Transport_01_F","I_HMG_01_high_F","I_HMG_01_F"],[0,2.3,2]]
];

OT_Buildables = [
	["Training Camp",1200,[] call compileFinal preProcessFileLineNumbers "templates\military\trainingCamp.sqf","structures\trainingCamp.sqf",true,"Allows training of recruits and hiring of mercenaries"],
	["Bunkers",500,["Land_BagBunker_01_small_green_F","Land_HBarrier_01_big_tower_green_F","Land_HBarrier_01_tower_green_F"],"",false,"Small Defensive Structures. Press space to change type."],
	["Walls",200,["Land_ConcreteWall_01_l_8m_F","Land_ConcreteWall_01_l_gate_F","Land_HBarrier_01_wall_6_green_F","Land_HBarrier_01_wall_4_green_F","Land_HBarrier_01_wall_corner_green_F"],"",false,"Stop people (or tanks) from getting in. Press space to change type."],
	["Helipad",50,["Land_HelipadCircle_F","Land_HelipadCivil_F","Land_HelipadRescue_F","Land_HelipadSquare_F"],"",false,"Apparently helicopter pilots need to be told where they are allowed to land"],
	["Observation Post",800,["Land_Cargo_Patrol_V4_F"],"structures\observationPost.sqf",false,"Includes unarmed personnel to keep an eye over the area and provide intel on enemy positions"],
	["Barracks",5000,["Land_Barracks_01_camo_F","Land_Barracks_01_grey_F"],"",false,"Allows recruiting of squads"],
	["Guard Tower",15000,["Land_Cargo_Tower_V4_F"],"",false,"It's a huge tower, what else do you need? besides 2 x Static MGs maybe but it comes with those."],
	["Hangar",3000,["Land_Airport_01_hangar_F"],"",false,"A big empty building, could probably fit a plane inside it."],
	["Workshop",2500,[] call compileFinal preProcessFileLineNumbers "templates\military\workshop.sqf","structures\workshop.sqf",true,"A place to repair and rearm your vehicles"]
];

OT_churches = ["Land_Church_03_F","Land_Church_01_F","Land_Church_02_F","Land_Temple_Native_01_F"];


OT_voices_local = ["Male01ENGFRE","Male02ENGFRE"];
OT_voices_western = ["Male01ENG","Male02ENG","Male03ENG","Male04ENG","Male05ENG","Male06ENG","Male07ENG","Male08ENG","Male09ENG","Male10ENG","Male11ENG","Male12ENG","Male01ENGB","Male02ENGB","Male03ENGB","Male04ENGB","Male05ENGB"];
OT_voices_eastern = ["Male01CHI","Male02CHI","Male03CHI"];
OT_faces_local = ["TanoanHead_A3_01","TanoanHead_A3_02","TanoanHead_A3_03","TanoanHead_A3_04","TanoanHead_A3_05","TanoanHead_A3_06","TanoanHead_A3_07","TanoanHead_A3_08","TanoanHead_A3_09"];
OT_faces_western = ["WhiteHead_1","WhiteHead_2","WhiteHead_3","WhiteHead_4","WhiteHead_5","WhiteHead_6","WhiteHead_7","WhiteHead_8","WhiteHead_9","WhiteHead_10","WhiteHead_11","WhiteHead_12","WhiteHead_13","WhiteHead_14","WhiteHead_15","WhiteHead_16","WhiteHead_17","WhiteHead_18","WhiteHead_19","WhiteHead_20","WhiteHead_21","AfricanHead_01","AfricanHead_02","AfricanHead_03"];
OT_faces_eastern = ["AsianHead_A3_01","AsianHead_A3_02","AsianHead_A3_03","AsianHead_A3_04","AsianHead_A3_05","AsianHead_A3_06","AsianHead_A3_07"];

OT_civType_gunDealer = "C_man_p_fugitive_F";
OT_civType_local = "C_man_1";
OT_civType_carDealer = "C_man_w_worker_F";
OT_civType_shopkeeper = "C_man_w_worker_F";
OT_civType_worker = "C_man_w_worker_F";
OT_civType_priest = "C_man_w_worker_F";
OT_vehTypes_civ = []; //populated automatically, but you can add more here and they will appear in streets
OT_vehType_distro = "C_Van_01_box_F";

OT_activeDistribution = [];
OT_activeShops = [];
OT_selling = false;

//Shop items
OT_item_ShopRegister = "Land_CashDesk_F";//Cash registers
OT_item_BasicGun = "hgun_P07_F";//Player starts with this weapon in their ammobox
OT_item_BasicAmmo = "16Rnd_9x21_Mag";

if(OT_hasAce) then {
	OT_consumableItems = ["ACE_fieldDressing","ACE_Sandbag_empty","ACE_elasticBandage"]; //Shops will try to stock more of these
}else{
	OT_consumableItems = ["FirstAidKit","Medikit"];
};
OT_illegalHeadgear = ["H_MilCap_gen_F","H_Beret_gen_F","H_HelmetB_TI_tna_F"];
OT_illegalVests = ["V_TacVest_gen_F"];

OT_allDrugs = ["OT_Ganja"];
OT_illegalItems = OT_allDrugs;

OT_item_UAV = "I_UAV_01_F";
OT_item_UAVterminal = "I_UavTerminal";

OT_items_distroStorage = ["CargoNet_01_box_F"]; //Where distribution centers store inventory
OT_items_Simulate = ["Box_NATO_Equip_F","Box_T_East_Wps_F","B_CargoNet_01_ammo_F","OfficeTable_01_old_F","Land_PortableLongRangeRadio_F"]; //These will be saved, position + inventory and have gravity

OT_staticMachineGuns = ["I_HMG_01_F","I_HMG_01_high_F","I_HMG_01_A_F","O_HMG_01_F","O_HMG_01_high_F","O_HMG_01_A_F","B_HMG_01_F","B_HMG_01_high_F","B_HMG_01_A_F"];
OT_staticWeapons = ["I_Mortar_01_F","I_static_AA_F","I_static_AT_F","I_GMG_01_F","I_GMG_01_high_F","I_GMG_01_A_F","I_HMG_01_F","I_HMG_01_high_F","I_HMG_01_A_F","O_static_AA_F","O_static_AT_F","O_Mortar_01_F","O_GMG_01_F","O_GMG_01_high_F","O_GMG_01_A_F","O_HMG_01_F","O_HMG_01_high_F","O_HMG_01_A_F","B_static_AA_F","B_static_AT_F","B_Mortar_01_F","B_GMG_01_F","B_GMG_01_high_F","B_GMG_01_A_F","B_HMG_01_F","B_HMG_01_high_F","B_HMG_01_A_F"];

OT_clothes_locals = ["U_I_C_Soldier_Bandit_2_F","U_I_C_Soldier_Bandit_3_F","U_C_Poor_1"];
OT_clothes_expats = ["U_I_C_Soldier_Bandit_5_F","U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_redwhite","U_C_Poloshirt_salmon","U_C_Poloshirt_stripped","U_C_Man_casual_6_F","U_C_Man_casual_4_F","U_C_Man_casual_5_F"];
OT_clothes_tourists = [];
OT_clothes_priest = "U_C_Man_casual_2_F";
OT_clothes_port = "U_Marshal";
OT_clothes_shops = ["U_C_Man_casual_2_F","U_C_Man_casual_3_F","U_C_Man_casual_1_F"];
OT_clothes_carDealers = OT_clothes_shops;
OT_clothes_harbor = ["U_C_man_sport_1_F","U_C_man_sport_2_F","U_C_man_sport_3_F"];
OT_clothes_guerilla = ["U_I_C_Soldier_Para_1_F","U_I_C_Soldier_Para_2_F","U_I_C_Soldier_Para_3_F","U_I_C_Soldier_Para_5_F","U_I_C_Soldier_Para_4_F"];
OT_clothes_mob = "U_I_C_Soldier_Camo_F";

OT_ammo_50cal = "100Rnd_127x99_mag";

//NATO stuff
OT_NATOregion = "island_5"; //where NATO lives
OT_NATOwhitelist = ["Comms Alpha","Comms Bravo","port","fuel depot","railway depot"]; //NameLocal/Airport place names to definitely occupy with military personnel
OT_NATOblacklist = ["Forbidden Village","training base","Comms Whiskey","GSM station"];
OT_NATO_priority = ["Tuvanaka Airbase","Comms Alpha","Blue Pearl industrial port","Nani","Belfort","Tuvanaka"];
OT_needsThe = ["fuel depot","maze","firing range","vehicle range","camp remnants","railway depot"];
OT_NATO_control = ["control_1","control_2","control_3","control_4","control_5","control_6","control_7","control_8","control_9","control_10","control_11","control_12","control_13","control_14","control_15","control_16","control_17","control_18"]; //NATO checkpoints, create markers in editor
OT_NATO_HQ = "Tuvanaka Airbase";
OT_NATO_AirSpawn = "NATO_airspawn";
OT_NATO_HQPos = [0,0,0];//Dont worry this gets populated later

OT_NATO_Vehicles_Garrison = [
	["B_T_MBT_01_TUSK_F", 1],
	["B_T_MBT_01_cannon_F",1],
	["B_T_LSV_01_armed_F",2],
	["B_T_MRAP_01_hmg_F",5],
	["B_T_MRAP_01_gmg_F",5],
	["B_T_APC_Tracked_01_AA_F",3],
	["B_T_Static_AT_F",7],
	["B_HMG_01_high_F",10],
	["B_T_MBT_01_mlrs_F",2]
];

OT_NATO_Vehicles_AirGarrison = [
	["B_T_VTOL_01_vehicle_F",1],
	["B_T_VTOL_01_infantry_F",1],
	["B_Heli_Light_01_armed_F",1],
	["B_Heli_Transport_03_unarmed_F",2],
	["B_Heli_Light_01_F",3],
	["B_Heli_Attack_01_F",1],
	["B_Heli_Transport_01_F",2],
	["B_Plane_CAS_01_F",1]
];

OT_NATO_CommTowers = ["Land_TTowerBig_1_F","Land_TTowerBig_2_F"];

OT_NATO_Unit_PoliceCommander = "B_Gen_Commander_F";
OT_NATO_Unit_Police = "B_Gen_Soldier_F";
OT_NATO_Vehicle_PoliceHeli = "B_Heli_Light_01_F";
OT_NATO_Vehicle_Quad = "B_Quadbike_01_F";
OT_NATO_Vehicle_Police = "B_GEN_Offroad_01_gen_F";
OT_NATO_Vehicle_Transport = "B_T_Truck_01_transport_F";
OT_NATO_Vehicles_PoliceSupport = ["B_T_MRAP_01_hmg_F","B_T_MRAP_01_gmg_F","B_T_LSV_01_armed_F","B_Heli_Light_01_armed_F"];
OT_NATO_Vehicles_AirDrones = ["B_UAV_02_F"];
OT_NATO_Vehicles_AirSupport = ["B_Heli_Attack_01_F","B_Heli_Light_01_armed_F"];
OT_NATO_Vehicles_AirWingedSupport = ["B_Plane_CAS_01_F"];
OT_NATO_Vehicle_AirTransport_Small = "B_Heli_Transport_01_camo_F";
OT_NATO_Vehicle_AirTransport = "B_Heli_Transport_03_F";
OT_NATO_Vehicle_AirTransport_Large = "B_Heli_Transport_03_F";

OT_NATO_Unit_LevelOneLeader = "B_T_Soldier_TL_F";
OT_NATO_Units_LevelOne = ["B_T_Medic_F","B_T_Soldier_F","B_T_Soldier_LAT_F","B_T_Soldier_AAT_F","B_T_Soldier_AT_F","B_T_soldier_M_F","B_T_Soldier_GL_F","B_T_Soldier_AR_F"];
OT_NATO_Units_LevelTwo = OT_NATO_Units_LevelOne + ["B_T_Soldier_AA_F","B_T_Soldier_AAR_F","B_T_Soldier_AAA_F"];

OT_NATO_Unit_Pilot = "B_T_Pilot_F";
OT_NATO_Unit_Sniper = "B_T_Sniper_F";
OT_NATO_Unit_Spotter = "B_T_Spotter_F";
OT_NATO_Unit_AA_spec = "B_T_Soldier_AA_F";
OT_NATO_Unit_AA_ass = "B_T_Soldier_AAA_F";

OT_NATO_Units_CTRGSupport = ["B_CTRG_Soldier_TL_tna_F","B_CTRG_Soldier_tna_F","B_CTRG_Soldier_M_tna_F","B_CTRG_Soldier_Medic_tna_F"];
OT_NATO_Vehicle_CTRGTransport = "B_CTRG_Heli_Transport_01_tropic_F";

OT_NATO_weapons_Police = ["hgun_PDW2000_F","SMG_05_F","SMG_01_F","SMG_02_F","arifle_SPAR_01_blk_F","arifle_MXC_Black_F"];
OT_NATO_weapons_Pistols = ["hgun_Pistol_heavy_01_F","hgun_ACPC2_F","hgun_P07_F","hgun_Rook40_F"];

//Criminal stuff
OT_CRIM_Unit = "C_man_p_fugitive_F";
OT_CRIM_Clothes = ["U_I_C_Soldier_Bandit_3_F","U_BG_Guerilla3_1","U_C_HunterBody_grn","U_I_G_Story_Protagonist_F"];
OT_CRIM_Goggles = ["G_Balaclava_blk","G_Balaclava_combat","G_Balaclava_lowprofile","G_Balaclava_oli","G_Bandanna_blk","G_Bandanna_khk","G_Bandanna_oli","G_Bandanna_shades","G_Bandanna_sport","G_Bandanna_tan"];

//ECONOMY

//This is the prices table, shops will only stock these items, any others must be imported or produced and will have their costs generated automatically
//Format ["Cfg class",Base price,Steel,Wood,Plastics]

//The price of an item in a shop will be the base price + local markup (taking into account stability and player rep)
//The cost to produce an item will be the Base price - player/factory bonuses + raw materials
//The wholesale sell price of an item will be the base price - local markup
//NB: the local markup can be negative, making buy prices lower and sell prices higher, in certain situations (high stability and/or player rep)

OT_items = [];
if(OT_hasAce) then {
	[OT_items,[
		["ACE_fieldDressing",2,0,0,0.1],
		["ACE_elasticBandage",3,0,0,0.2],
		["ACE_morphine",40,0,0,0.2],
		["ACE_epinephrine",40,0,0,0.2],
		["ACE_adenosine",40,0,0,0.2],
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
	[OT_items,[
		["FirstAidKit",10,0,0,0.1],
		["Medikit",40,0,0,0.5]
	]] call BIS_fnc_arrayPushStack;
};

[OT_items,[
	["ToolKit",25,1,0,0],
	["ItemGPS",60,0,0,1],
	["ItemCompass",5,0.1,0,0],
	["ItemMap",1,0,0,0],
	["ItemWatch",30,0,0,1],
	["Binocular",70,0,0,1],
	["Rangefinder",130,0,0,1],
	["ItemRadio",20,0,0,1]
]] call BIS_fnc_arrayPushStack;

OT_staticBackpacks = [
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

OT_backpacks = [
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
OT_boats = [
	["C_Scooter_Transport_01_F",150,1,0,1],	
	["C_Boat_Civil_01_rescue_F",300,1,1,1],
	["C_Boat_Transport_02_F",600,1,0,1]
];
OT_vehicles = [];
OT_allVehicles = [];
OT_allBoats = ["B_Boat_Transport_01_F"];
OT_allItems = [];
OT_allWeapons = [];
OT_allMagazines = [OT_ammo_50cal];
OT_allBackpacks = [];
OT_allStaticBackpacks = [];
OT_vehWeights_civ = [];
_mostExpensive = 0;

_allVehs = "
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2
    &&
    { getText ( _x >> ""vehicleClass"" ) isEqualTo ""Car""}
	&&
    { getText ( _x >> ""faction"" ) isEqualTo ""CIV_F""}
	)
" configClasses ( configFile >> "cfgVehicles" );

{
	_cls = configName _x;
	_cost = (getNumber (configFile >> "cfgVehicles" >> _cls >> "armor") + getNumber (configFile >> "cfgVehicles" >> _cls >> "enginePower")) * 3;
	_cost = _cost + round(getNumber (configFile >> "cfgVehicles" >> _cls >> "maximumLoad") * 0.1);
	
	if(_cost > _mostExpensive)then {
		_mostExpensive = _cost;
	};
	
	OT_vehicles pushback [_cls,_cost,1,1,1];
	OT_allVehicles pushback _cls;
	if(getText(configFile >> "cfgVehicles" >> _cls >> "textSingular") != "truck" and getText(configFile >> "cfgVehicles" >> _cls >> "driverAction") != "Kart_driver") then {
		OT_vehTypes_civ pushback _cls;
	};
} foreach (_allVehs);

{
	_cls = _x select 0;
	if(isServer) then {
		cost setVariable [_cls,[_x select 1,_x select 2,_x select 3,_x select 4],true];
	};
	if(_cls in OT_vehTypes_civ) then {
		OT_vehWeights_civ pushback (_mostExpensive - (_x select 1)) + 1; //This will make whatever is the most expensive car very rare
	};
	OT_allVehicles pushBack _cls;
}foreach(OT_vehicles);


_allWeapons = "
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2
    &&
    { getText ( _x >> ""simulation"" ) isEqualTo ""Weapon""})
" configClasses ( configFile >> "cfgWeapons" );



OT_allSubMachineGuns = [];
OT_allAssaultRifles = [];
OT_allMachineGuns = [];
OT_allSniperRifles = [];
OT_allHandGuns = [];
OT_allMissileLaunchers = [];
OT_allRocketLaunchers = [];
OT_allExpensiveRifles = [];
OT_allVests = [];
OT_allProtectiveVests = [];
OT_allExpensiveVests = [];

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
		if !(_x in OT_allMagazines) then {
			OT_allMagazines pushback _x;
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
		case "SubmachineGun": {_cost = 250;OT_allSubMachineGuns pushBack _name};
		
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
			OT_allAssaultRifles pushBack _name;
			if(_cost > 1400) then {
				OT_allExpensiveRifles pushback _name;
			};
		};
		case "MachineGun": {_cost = 1500;OT_allMachineGuns pushBack _name};
		case "SniperRifle": {_cost = 2000;OT_allSniperRifles pushBack _name};
		case "Handgun": {_cost = 100;OT_allHandGuns pushBack _name};
		case "MissileLauncher": {_cost=2500;OT_allMissileLaunchers pushBack _name};
		case "RocketLauncher": {_cost = 1500;OT_allRocketLaunchers pushBack _name};
		case "Vest": {
			if !(_name in (OT_illegalVests + ["V_RebreatherB","V_RebreatherIA","V_RebreatherIR","V_Rangemaster_belt"])) then {
				_cost = 80 + (getNumber(configFile >> "CfgWeapons" >> _name >> "ItemInfo" >> "HitpointsProtectionInfo" >> "Chest" >> "armor") * 50);				
				OT_allVests pushBack _name;
				if(_cost > 80) then {
					OT_allProtectiveVests pushback _name;
				};
				if(_cost > 900) then {
					OT_allExpensiveVests pushback _name;
				};
			};
		};
	};		
	cost setVariable [_name,[_cost,1,0,1],true];
} foreach (_allWeapons);

OT_allWeapons = OT_allSubMachineGuns + OT_allAssaultRifles + OT_allMachineGuns + OT_allSniperRifles + OT_allHandGuns + OT_allMissileLaunchers + OT_allRocketLaunchers;

if(isServer) then {
	cost setVariable ["CIV",[100,0,0,0],true];
	cost setVariable [OT_item_UAV,[200,0,0,1],true];
	
	//Drug prices
	cost setVariable ["OT_Ganja",[100,0,0,0],true];
};
//populate the cost gamelogic with the above data so it can be accessed quickly
{
	if(isServer) then {
		cost setVariable [_x select 0,[_x select 1,_x select 2,_x select 3,_x select 4],true];
	};
	OT_allItems pushBack (_x select 0);
}foreach(OT_items);
{
	if(isServer) then {
		cost setVariable [_x select 0,[_x select 1,_x select 2,_x select 3,_x select 4],true];
	};
	OT_allBackpacks pushBack (_x select 0);
}foreach(OT_backpacks);
{
	if(isServer) then {
		cost setVariable [_x select 0,[_x select 1,_x select 2,_x select 3,_x select 4],true];
	};
	OT_allStaticBackpacks pushBack (_x select 0);
}foreach(OT_staticBackpacks);

{
	if(isServer) then {
		cost setVariable [_x select 0,[_x select 1,_x select 2,_x select 3,_x select 4],true];
	};
	OT_allBoats pushBack (_x select 0);
}foreach(OT_boats);

OT_regions = ["island_1","island_2","island_3","island_4","island_5","island_6","island_7"]; //for both economic and travel purposes. define rectangles in eden
OT_capitals = ["Georgetown","Lijnhaven","Katkoula","Balavu","Tuvanaka","Sosovu","Ipota"]; //region capitals
OT_sprawling = ["Blue Pearl industrial port"];

OT_mansions = ["Land_House_Big_02_F","Land_House_Big_03_F"]; //buildings that rich guys like to live in

OT_gunDealerHouses = ["Land_Slum_01_F","Land_Slum_02_F","Land_House_Big_02_F","Land_House_Small_03_F","Land_House_Small_06_F","Land_GarageShelter_01_F","Land_House_Small_05_F","Land_House_Native_02_F"];//houses where gun dealers will spawn

OT_crimHouses = OT_spawnHouses + OT_gunDealerHouses + OT_mansions;

OT_lowPopHouses = OT_spawnHouses + ["Land_House_Small_06_F","Land_House_Small_02_F","Land_House_Small_03_F","Land_GarageShelter_01_F","Land_Slum_04_F"]; //buildings with just 1-4 people living in them (also player start houses)
OT_medPopHouses = ["Land_House_Small_04_F","Land_House_Native_01_F","Land_House_Big_01_F","Land_Slum_05_F","Land_House_Small_01_F","Land_Slum_03_F","Land_Slum_04_F","Land_House_Small_05_F","Land_Addon_04_F"]; //buildings with 5-10 people living in them
OT_highPopHouses = ["Land_House_Big_04_F","Land_Warehouse_01_F"]; //buildings with up to 20 (the warehouses are because ports end up with low pop)
OT_hugePopHouses = ["Land_MultistoryBuilding_03_F"]; //buildings with potentially lots of people living in them
OT_touristHouses = ["Land_House_Big_05_F"]; //hostels and the like
OT_allShops = ["Land_Shop_Town_01_F","Land_Shop_Town_02_F","Land_Shop_Town_03_F","Land_Shop_Town_04_F","Land_Shop_Town_05_F","Land_Shop_City_01_F","Land_Shop_City_02_F","Land_Shop_City_03_F","Land_Shop_City_04_F","Land_Shop_City_05_F","Land_Shop_City_06_F","Land_Shop_City_07_F"]; //used to calculate civ spawn positions and initial stability
OT_markets = []; //buildings/objects that will spawn local markets (no templates required)
OT_shops = ["Land_FuelStation_01_shop_F","Land_Shop_Town_01_F","Land_Shop_Town_03_F","Land_Shop_City_02_F","Land_Supermarket_01_F"]; //buildings that will spawn the main shops (must have a template with a cash register)
OT_warehouses = ["Land_Warehouse_03_F"]; //buildings that will spawn local distribution centers
OT_carShops = ["Land_FuelStation_01_workshop_F","Land_FuelStation_02_workshop_F"]; //buildings that will spawn car salesmen (must have a template with a cash register)
OT_piers = ["Land_PierConcrete_01_steps_F","Land_PierWooden_01_platform_F","Land_PierConcrete_01_end_F","Land_PierWooden_01_hut_F"]; //spawns dudes that sell boats n stuff
OT_offices = ["Land_MultistoryBuilding_01_F","Land_MultistoryBuilding_04_F"]; 
OT_portBuildings = ["Land_Warehouse_01_F","Land_Warehouse_02_F","Land_ContainerLine_01_F","Land_ContainerLine_02_F","Land_ContainerLine_03_F"];
OT_airportTerminals = ["Land_Airport_01_terminal_F","Land_Airport_02_terminal_F","Land_Hangar_F"];
OT_portBuilding = "Land_Warehouse_02_F";

OT_loadingMessages = ["Adding Hidden Agendas","Adjusting Bell Curves","Aesthesizing Industrial Areas","Aligning Covariance Matrices","Applying Feng Shui Shaders","Applying Theatre Soda Layer","Asserting Packed Exemplars","Attempting to Lock Back-Buffer","Binding Sapling Root System","Breeding Fauna","Building Data Trees","Bureacritizing Bureaucracies","Calculating Inverse Probability Matrices","Calculating Llama Expectoration Trajectory","Calibrating Blue Skies","Charging Ozone Layer","Coalescing Cloud Formations","Cohorting Exemplars","Collecting Meteor Particles","Compounding Inert Tessellations","Compressing Fish Files","Computing Optimal Bin Packing","Concatenating Sub-Contractors","Containing Existential Buffer","Debarking Ark Ramp","Debunching Unionized Commercial Services","Deciding What Message to Display Next","Decomposing Singular Values","Decrementing Tectonic Plates","Deleting Ferry Routes","Depixelating Inner Mountain Surface Back Faces","Depositing Slush Funds","Destabilizing Economic Indicators","Determining Width of Blast Fronts","Deunionizing Bulldozers","Dicing Models","Diluting Livestock Nutrition Variables","Downloading Satellite Terrain Data","Exposing Flash Variables to Streak System","Extracting Resources","Factoring Pay Scale","Fixing Election Outcome Matrix","Flood-Filling Ground Water","Flushing Pipe Network","Gathering Particle Sources","Generating Jobs","Gesticulating Mimes","Graphing Whale Migration","Hiding Willio Webnet Mask","Implementing Impeachment Routine","Increasing Accuracy of RCI Simulators","Increasing Magmafacation","Initializing Rhinoceros Breeding Timetable","Initializing Robotic Click-Path AI","Inserting Sublimated Messages","Integrating Curves","Integrating Illumination Form Factors","Integrating Population Graphs","Iterating Cellular Automata","Lecturing Errant Subsystems","Mixing Genetic Pool","Modeling Object Components","Mopping Occupant Leaks","Normalizing Power","Obfuscating Quigley Matrix","Overconstraining Dirty Industry Calculations","Partitioning City Grid Singularities","Perturbing Matrices","Pixellating Nude Patch","Polishing Water Highlights","Populating Lot Templates","Preparing Sprites for Random Walks","Prioritizing Landmarks","Projecting Law Enforcement Pastry Intake","Realigning Alternate Time Frames","Reconfiguring User Mental Processes","Relaxing Splines","Removing Road Network Speed Bumps","Removing Texture Gradients","Removing Vehicle Avoidance Behavior","Resolving GUID Conflict","Reticulating Splines","Retracting Phong Shader","Retrieving from Back Store","Reverse Engineering Image Consultant","Routing Neural Network Infanstructure","Scattering Rhino Food Sources","Scrubbing Terrain","Searching for Llamas","Seeding Architecture Simulation Parameters","Sequencing Particles","Setting Advisor ","Setting Inner Deity ","Setting Universal Physical Constants","Sonically Enhancing Occupant-Free Timber","Speculating Stock Market Indices","Splatting Transforms","Stratifying Ground Layers","Sub-Sampling Water Data","Synthesizing Gravity","Synthesizing Wavelets","Time-Compressing Simulator Clock","Unable to Reveal Current Activity","Weathering Buildings","Zeroing Crime Network"];
OT_allBuyableBuildings = OT_lowPopHouses + OT_medPopHouses + OT_highPopHouses + OT_hugePopHouses + OT_mansions + [OT_item_Tent,OT_item_Flag];

{
	_istpl = _x select 4;
	if(_istpl) then {
		_tpl = _x select 2;
		OT_allBuyableBuildings pushback ((_tpl select 0) select 0);
	};
}foreach(OT_Buildables);

OT_allHouses = OT_lowPopHouses + OT_medPopHouses + OT_highPopHouses + OT_hugePopHouses + OT_touristHouses;
OT_allEnterableHouses = ["Land_House_Small_02_F","Land_House_Big_02_F","Land_House_Small_03_F","Land_House_Small_06_F","Land_House_Big_01_F","Land_Slum_05_F","Land_Slum_01_F","Land_GarageShelter_01_F","Land_House_Small_01_F","Land_Slum_03_F","Land_House_Big_04_F","Land_House_Small_04_F","Land_House_Small_05_F"];

OT_allTowns = [];

//get all the templates we need

{
	_filename = format["templates\houses\%1.sqf",_x];
	if(_filename call KK_fnc_fileExists) then {
		_template = call(compileFinal preProcessFileLineNumbers _filename);
		{
			if((_x select 0) in OT_items_Simulate) then {
				_x set [8,true];
			}else{
				_x set [8,false];
			};
		}forEach(_template);
		
		templates setVariable [_x,_template,true];		
	};	
} foreach(OT_mansions + OT_lowPopHouses + OT_medPopHouses + OT_highPopHouses + OT_shops + OT_carShops);

{
	OT_allTowns pushBack (text _x);
	if(isServer) then {
		server setVariable [text _x,getpos _x,true];
	};
}foreach (nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["NameCityCapital","NameCity","NameVillage","CityCenter"], 50000]);

OT_allAirports = [];
{
		OT_allAirports pushBack text _x;
}foreach (nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["Airport"], 50000]);
