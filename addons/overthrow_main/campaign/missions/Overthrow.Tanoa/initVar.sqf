//Here is where you can change stuff to suit your liking or support mods/another map

OT_centerPos = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");

OT_nation = "Tanoa";

call compileFinal preprocessFileLineNumbers "data\names.sqf";
call compileFinal preprocessFileLineNumbers "data\towns.sqf";
call compileFinal preprocessFileLineNumbers "data\airports.sqf";
call compileFinal preprocessFileLineNumbers "data\objectives.sqf";
call compileFinal preprocessFileLineNumbers "data\economy.sqf";
call compileFinal preprocessFileLineNumbers "data\comms.sqf";

OT_useDynamicSimulation = false; //Experimental new dynamic sim mode

OT_missions = [];
OT_missions pushback (compileFinal preprocessFileLineNumbers "missions\transportvip.sqf");
OT_missions pushback (compileFinal preprocessFileLineNumbers "missions\fugitive.sqf");

OT_localMissions = [];
//OT_localMissions pushback (compileFinal preprocessFileLineNumbers "missions\recon.sqf");
OT_localMissions pushback (compileFinal preprocessFileLineNumbers "missions\medicalsupplies.sqf");
OT_localMissions pushback (compileFinal preprocessFileLineNumbers "missions\informant.sqf");
OT_localMissions pushback (compileFinal preprocessFileLineNumbers "missions\kill.sqf");

OT_currentMissionFaction = "";

OT_rankXP = [100,250,500,1000,4000,10000,100000];

//Used to control updates and persistent save compatability. When these numbers go up, that section will be reinitialized on load if required. (ie leave them alone)
OT_economyVersion = 12;
OT_NATOversion = 8;
OT_CRIMversion = 1;
OT_adminMode = false;
OT_economyLoadDone = false;

OT_deepDebug = false;

OT_hasAce = false;
if (isClass (configFile >> "CfgPatches" >> "ace_ui")) then {
	OT_hasAce = true;
};

OT_allIntel = [];

OT_fastTime = true; //When true, 1 day will last 6 hrs real time
OT_spawnDistance = 1200;
OT_spawnCivPercentage = 0.1;
OT_spawnVehiclePercentage = 0.04;
OT_standardMarkup = 0.2; //Markup in shops is calculated from this
OT_randomSpawnTown = false; //if true, every player will start in a different town, if false, all players start in the same town (Multiplayer only)
OT_distroThreshold = 500; //Size a towns order must be before a truck is sent (in dollars)
OT_saving = false;

OT_flag_NATO = "Flag_NATO_F";
OT_flag_CRIM = "Flag_Syndikat_F";

OT_item_wrecks = ["Land_Wreck_HMMWV_F","Land_Wreck_Skodovka_F","Land_Wreck_Truck_F","Land_Wreck_Car2_F","Land_Wreck_Car_F","Land_Wreck_Hunter_F","Land_Wreck_Offroad_F","Land_Wreck_Offroad2_F","Land_Wreck_UAZ_F","Land_Wreck_Truck_dropside_F"]; //rekt

OT_spawnTowns = ["Balavu","Katkoula","Savaka","Namuvaka","Katkoula","Lailai","Taga","Bua Bua","Blerick","Moddergat","Tobakoro"]; //Towns where new players will spawn
OT_spawnHouses = ["Land_Slum_01_F","Land_Slum_02_F","Land_House_Native_02_F"]; //Houses where new players will spawn

OT_NATOwait = 30; //Half the Average time between NATO orders (x 10 seconds)
OT_CRIMwait = 500; //Half the Average time between crim changes

//Interactable items that spawn in your house
OT_item_Storage = "B_CargoNet_01_ammo_F"; //Your spawn ammobox
OT_item_Desk = "OfficeTable_01_new_F"; //Your spawn desk
OT_item_Radio = "Land_PortableLongRangeRadio_F";
OT_item_Map = "Land_MapBoard_F";
OT_item_Repair = "Land_ToolTrolley_02_F";
OT_item_Tent = "Land_TentDome_F";
OT_item_Flag = "Flag_HorizonIslands_F";
OT_item_Safe = "Land_MetalCase_01_small_F";

OT_item_DefaultBlueprints = [];

OT_allLowAnimals = ["Rabbit_F","Turtle_F"];
OT_allHighAnimals = ["Goat_random_F"];
OT_allFarmAnimals = ["Hen_random_F","Cock_random_F","Sheep_random_F"];
OT_allVillageAnimals = ["Hen_random_F","Cock_random_F"];
OT_allTownAnimals = ["Alsatian_Random_F","Fin_random_F"];

OT_fuelPumps = ["Land_FuelStation_02_pump_F","Land_FuelStation_01_pump_F","Land_fs_feed_F","Land_FuelStation_Feed_F"];

OT_ferryDestinations = ["destination_1","destination_2","destination_3","destination_4","destination_5","destination_6"];

OT_miscables = ["ACE_Wheel","ACE_Track","Land_PortableLight_double_F","Land_PortableLight_single_F","Land_Camping_Light_F","Land_PortableHelipadLight_01_F","PortableHelipadLight_01_blue_F",
"PortableHelipadLight_01_green_F","PortableHelipadLight_01_red_F","PortableHelipadLight_01_white_F","PortableHelipadLight_01_yellow_F","Land_Campfire_F","ArrowDesk_L_F",
"ArrowDesk_R_F","ArrowMarker_L_F","ArrowMarker_R_F","Pole_F","Land_RedWhitePole_F","RoadBarrier_F","RoadBarrier_small_F","RoadCone_F","RoadCone_L_F","Land_VergePost_01_F",
"TapeSign_F","Land_WheelChock_01_F","Land_Sleeping_bag_F","Land_Sleeping_bag_blue_F","Land_WoodenLog_F","FlagChecked_F","FlagSmall_F","Land_LandMark_F","Land_Bollard_01_F"];

//Items you can place
OT_Placeables = [
	["Sandbags",20,["Land_BagFence_01_long_green_F","Land_BagFence_01_short_green_F","Land_BagFence_01_round_green_F","Land_BagFence_01_corner_green_F","Land_BagFence_01_end_green_F"],[0,3,0.8],"Bags filled with lots of sand. Apparently this can stop bullets or something?"],
	["Camo Nets",40,["CamoNet_ghex_F","CamoNet_ghex_open_F","CamoNet_ghex_big_F"],[0,7,2],"Large and terribly flimsy structures that may or may not obscure your forces from airborne units."],
	["Barriers",60,["Land_HBarrier_01_line_5_green_F","Land_HBarrier_01_line_3_green_F","Land_HBarrier_01_line_1_green_F"],[0,4,1.2],"Really big sandbags, basically."],
	["Map",30,[OT_item_Map],[0,2,1.2],"Use these to save your game, change options or check town info."],
	["Safe",50,[OT_item_Safe],[0,2,0.5],"Store and retrieve money"],
	["Misc",30,OT_miscables,[0,3,1.2],"Various other items, including spare wheels and lights"]
];

//People you can recruit, and squads are composed of
OT_Recruitables = [
	["I_soldier_F","AssaultRifle","",200,"",""], //0
	["I_soldier_AR_F","MachineGun","",200,"",""], //1
	["I_Soldier_LAT_F","AssaultRifle","launch_RPG7_F",200,"",""], //2
	["I_Soldier_M_F","AssaultRifle","",500,"",""], //3
	["I_Sniper_F","SniperRifle","",1800,"U_B_T_FullGhillie_tna_F","Binocular"], //4
	["I_Spotter_F","AssaultRifle","",500,"U_B_T_FullGhillie_tna_F","Binocular"], //5
	["I_Soldier_SL_F","AssaultRifle","",200,"","Binocular"], //6
	["I_Soldier_TL_F","AssaultRifle","",200,"U_I_C_Soldier_Para_2_F","Binocular"], //7
	["I_Medic_F","AssaultRifle","",200,"",""], //8
	["I_Soldier_AT_F","AssaultRifle","launch_I_Titan_short_F",200,"",""], //9
	["I_Soldier_AA_F","AssaultRifle","launch_I_Titan_F",200,"",""], //10
	["I_Soldier_AAT_F","AssaultRifle","",200,"",""], //11
	["I_Soldier_AAA_F","AssaultRifle","",200,"",""], //12
	["I_soldier_GL_F","GrenadeLauncher","",200,"",""] //13
];

OT_Squadables = [
	["Sentry",[6,0],"SEN"],
	["Sniper Squad",[4,5],"SNI"],
	["AT Squad",[6,9,11,8],"AT"],
	["AA Squad",[6,10,12,8],"AA"],
	["Fire Team",[7,0,1,2,3,8],"FIR"],
	["Infantry Team",[7,0,1,2,3,8,9,10],"INF"]
];
OT_allSquads = [];
{
	_name = _x select 0;
	OT_allSquads pushback _name;
}foreach(OT_Squadables);

OT_churches = ["Land_Church_03_F","Land_Church_01_F","Land_Church_02_F","Land_Temple_Native_01_F"];

OT_voices_local = ["Male01ENGFRE","Male02ENGFRE"];
OT_voices_western = ["Male01ENG","Male02ENG","Male03ENG","Male04ENG","Male05ENG","Male06ENG","Male07ENG","Male08ENG","Male09ENG","Male10ENG","Male11ENG","Male12ENG","Male01ENGB","Male02ENGB","Male03ENGB","Male04ENGB","Male05ENGB"];
OT_voices_eastern = ["Male01CHI","Male02CHI","Male03CHI"];
OT_faces_local = ["TanoanHead_A3_01","TanoanHead_A3_02","TanoanHead_A3_03","TanoanHead_A3_04","TanoanHead_A3_05","TanoanHead_A3_06","TanoanHead_A3_07","TanoanHead_A3_08"];
OT_faces_western = ["WhiteHead_1","WhiteHead_2","WhiteHead_3","WhiteHead_4","WhiteHead_5","WhiteHead_6","WhiteHead_7","WhiteHead_8","WhiteHead_9","WhiteHead_10","WhiteHead_11","WhiteHead_12","WhiteHead_13","WhiteHead_14","WhiteHead_15","WhiteHead_16","WhiteHead_17","WhiteHead_18","WhiteHead_19","WhiteHead_20","WhiteHead_21","AfricanHead_01","AfricanHead_02","AfricanHead_03"];
OT_faces_eastern = ["AsianHead_A3_01","AsianHead_A3_02","AsianHead_A3_03","AsianHead_A3_04","AsianHead_A3_05","AsianHead_A3_06","AsianHead_A3_07"];
OT_face_localBoss = "TanoanBossHead";

OT_Resources = ["OT_Wood","OT_Steel","OT_Plastic","OT_Sugarcane","OT_Sugar","OT_Fertilizer"];

OT_civType_gunDealer = "C_man_p_fugitive_F";
OT_civType_local = "C_man_1";
OT_civType_carDealer = "C_man_w_worker_F";
OT_civType_shopkeeper = "C_man_w_worker_F";
OT_civType_worker = "C_man_w_worker_F";
OT_civType_priest = "C_man_w_worker_F";
OT_vehTypes_civ = []; //populated automatically, but you can add more here and they will appear in streets
OT_vehType_distro = "C_Van_01_box_F";
OT_vehType_ferry = "C_Boat_Transport_02_F";
OT_vehType_service = "C_Offroad_01_repair_F";
OT_vehTypes_civignore = ["C_Hatchback_01_F","C_Hatchback_01_sport_F",OT_vehType_service]; //Civs cannot drive these vehicles for whatever reason

OT_item_CargoContainer = "B_Slingload_01_Cargo_F";

OT_activeShops = [];
OT_selling = false;
OT_taking = false;

//Shop items
OT_item_ShopRegister = "Land_CashDesk_F";//Cash registers
OT_item_BasicGun = "hgun_P07_F";//Player starts with this weapon in their ammobox
OT_item_BasicAmmo = "16Rnd_9x21_Mag";

if(OT_hasAce) then {
	OT_consumableItems = ["ACE_fieldDressing","ACE_Sandbag_empty","ACE_elasticBandage","ItemMap","ToolKit","ACE_epinephrine","OT_Fertilizer"]; //Shops will try to stock more of these
}else{
	OT_consumableItems = ["FirstAidKit","Medikit","ItemMap","ToolKit"];
};
OT_illegalHeadgear = ["H_MilCap_gen_F","H_Beret_gen_F","H_HelmetB_TI_tna_F"];
OT_illegalVests = ["V_TacVest_gen_F"];

OT_allDrugs = ["OT_Ganja","OT_Blow"];
OT_illegalItems = OT_allDrugs;

OT_item_UAV = "I_UAV_01_F";
OT_item_UAVterminal = "I_UavTerminal";

OT_items_Simulate = ["Box_NATO_Equip_F","Box_T_East_Wps_F","B_CargoNet_01_ammo_F","OfficeTable_01_old_F","Land_PortableLongRangeRadio_F"]; //These will be saved, position + inventory and have gravity

OT_staticMachineGuns = ["I_HMG_01_F","I_HMG_01_high_F","I_HMG_01_A_F","O_HMG_01_F","O_HMG_01_high_F","O_HMG_01_A_F","B_HMG_01_F","B_HMG_01_high_F","B_HMG_01_A_F"];
OT_staticWeapons = ["I_Mortar_01_F","I_static_AA_F","I_static_AT_F","I_GMG_01_F","I_GMG_01_high_F","I_GMG_01_A_F","I_HMG_01_F","I_HMG_01_high_F","I_HMG_01_A_F","O_static_AA_F","O_static_AT_F","O_Mortar_01_F","O_GMG_01_F","O_GMG_01_high_F","O_GMG_01_A_F","O_HMG_01_F","O_HMG_01_high_F","O_HMG_01_A_F","B_static_AA_F","B_static_AT_F","B_Mortar_01_F","B_GMG_01_F","B_GMG_01_high_F","B_GMG_01_A_F","B_HMG_01_F","B_HMG_01_high_F","B_HMG_01_A_F"];

OT_clothes_locals = ["U_I_C_Soldier_Bandit_2_F","U_I_C_Soldier_Bandit_3_F","U_C_Poor_1"];
OT_clothes_expats = ["U_I_C_Soldier_Bandit_5_F","U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_redwhite","U_C_Poloshirt_salmon","U_C_Poloshirt_stripped","U_C_Man_casual_6_F","U_C_Man_casual_4_F","U_C_Man_casual_5_F"];
OT_clothes_tourists = [];
OT_clothes_priest = "U_C_Man_casual_2_F";
OT_clothes_port = "U_Marshal";
OT_clothes_shops = ["U_C_Man_casual_2_F","U_C_Man_casual_3_F","U_C_Man_casual_1_F"];
OT_clothes_carDealers = ["U_Marshal"];
OT_clothes_harbor = ["U_C_man_sport_1_F","U_C_man_sport_2_F","U_C_man_sport_3_F"];
OT_clothes_guerilla = ["U_I_C_Soldier_Para_1_F","U_I_C_Soldier_Para_2_F","U_I_C_Soldier_Para_3_F","U_I_C_Soldier_Para_4_F"];
OT_clothes_police = ["U_I_G_resistanceLeader_F","U_BG_Guerilla2_1","U_BG_Guerilla2_3","U_I_C_Soldier_Para_4_F"];
OT_vest_police = "V_TacVest_blk_POLICE";
OT_hat_police = "H_Cap_police";
OT_clothes_mob = "U_I_C_Soldier_Camo_F";

OT_ammo_50cal = "100Rnd_127x99_mag";

//NATO stuff
OT_NATO_control = ["control_1","control_2","control_3","control_4","control_5","control_6","control_7","control_8","control_9","control_10","control_11","control_12","control_13","control_14","control_15","control_16","control_17","control_18"]; //NATO checkpoints, create markers in editor
OT_NATO_AirSpawn = "NATO_airspawn";
OT_NATO_HQPos = [0,0,0];//Dont worry this gets populated later

OT_NATO_Vehicles_Garrison = [

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

OT_NATO_StaticGarrison_LevelOne = ["B_HMG_01_high_F"];
OT_NATO_StaticGarrison_LevelTwo = ["B_HMG_01_high_F","B_HMG_01_high_F","B_GMG_01_high_F","B_T_MRAP_01_hmg_F"];
OT_NATO_StaticGarrison_LevelThree = ["B_T_Static_AT_F","B_T_Static_AA_F","B_HMG_01_high_F","B_HMG_01_high_F","B_GMG_01_high_F","B_T_MRAP_01_hmg_F","B_T_MRAP_01_gmg_F"];

OT_NATO_CommTowers = ["Land_TTowerBig_1_F","Land_TTowerBig_2_F"];

OT_NATO_Unit_PoliceCommander = "B_Gen_Commander_F";
OT_NATO_Unit_Police = "B_Gen_Soldier_F";
OT_NATO_Vehicle_PoliceHeli = "B_Heli_Light_01_F";
OT_NATO_Vehicle_Quad = "B_Quadbike_01_F";
OT_NATO_Vehicle_Police = "B_GEN_Offroad_01_gen_F";
OT_NATO_Vehicle_Transport = ["B_T_Truck_01_transport_F","B_T_Truck_01_covered_F"];
OT_NATO_Vehicle_Transport_Light = "B_CTRG_LSV_01_light_F";
OT_NATO_Vehicles_PoliceSupport = ["B_T_MRAP_01_hmg_F","B_T_MRAP_01_gmg_F","B_T_LSV_01_armed_F","B_Heli_Light_01_armed_F"];
OT_NATO_Vehicles_ReconDrone = "B_UAV_01_F";
OT_NATO_Vehicles_CASDrone = "B_UAV_02_CAS_F";
OT_NATO_Vehicles_AirSupport = ["B_Heli_Attack_01_F"];
OT_NATO_Vehicles_AirSupport_Small = ["B_Heli_Light_01_armed_F"];
OT_NATO_Vehicles_GroundSupport = ["B_T_MRAP_01_gmg_F","B_T_MRAP_01_hmg_F","B_T_LSV_01_armed_F"];
OT_NATO_Vehicles_Convoy = ["B_UGV_01_rcws_F","B_T_MRAP_01_hmg_F","B_T_LSV_01_armed_F","B_T_LSV_01_armed_F","B_T_LSV_01_armed_F"];
OT_NATO_Vehicles_AirWingedSupport = ["B_Plane_CAS_01_F"];
OT_NATO_Vehicle_AirTransport_Small = "B_Heli_Transport_01_camo_F";
OT_NATO_Vehicle_AirTransport = ["B_Heli_Transport_03_F","B_Heli_Transport_01_F","B_Heli_Transport_01_F"];
OT_NATO_Vehicle_AirTransport_Large = "B_Heli_Transport_03_F";
OT_NATO_Vehicle_Boat_Small = "B_Boat_Armed_01_minigun_F";

OT_NATO_Sandbag_Curved = "Land_BagFence_01_round_green_F";
OT_NATO_Barrier_Small = "Land_HBarrier_01_line_5_green_F";
OT_NATO_Barrier_Large = "Land_HBarrier_01_wall_6_green_F";

OT_NATO_GroundForces = ["B_T_InfSquad_Weapons","B_T_InfSquad","B_T_InfSquad","B_T_InfSquad","B_T_InfSquad"];
OT_NATO_Group_Recon = (configFile >> "CfgGroups" >> "West" >> "BLU_T_F" >> "Infantry" >> "B_T_ReconTeam");
OT_NATO_Group_Engineers = (configfile >> "CfgGroups" >> "West" >> "BLU_T_F" >> "Support" >> "B_T_Support_ENG");
OT_NATO_Group_CTRG = (configfile >> "CfgGroups" >> "West" >> "BLU_T_F" >> "Support" >> "B_T_Support_ENG");

OT_NATO_Unit_LevelOneLeader = "B_T_Soldier_TL_F";
OT_NATO_Units_LevelOne = ["B_T_Medic_F","B_T_Soldier_F","B_T_Soldier_LAT_F","B_T_Soldier_AAT_F","B_T_Soldier_AT_F","B_T_soldier_M_F","B_T_Soldier_GL_F","B_T_Soldier_AR_F"];
OT_NATO_Units_LevelTwo = OT_NATO_Units_LevelOne + ["B_T_Soldier_AA_F","B_T_Soldier_AAR_F","B_T_Soldier_AAA_F"];

OT_NATO_Mortar = "B_T_Mortar_01_F";

OT_NATO_Unit_Pilot = "B_T_Pilot_F";
OT_NATO_Unit_Sniper = "B_T_Sniper_F";
OT_NATO_Unit_Spotter = "B_T_Spotter_F";
OT_NATO_Unit_AA_spec = "B_T_Soldier_AA_F";
OT_NATO_Unit_AA_ass = "B_T_Soldier_AAA_F";

OT_NATO_Unit_HVT = "B_T_Officer_F";
OT_NATO_Vehicle_HVT = "B_MRAP_01_F";

OT_NATO_Units_CTRGSupport = ["B_CTRG_Soldier_TL_tna_F","B_CTRG_Soldier_tna_F","B_CTRG_Soldier_M_tna_F","B_CTRG_Soldier_Medic_tna_F"];
OT_NATO_Vehicle_CTRGTransport = "B_CTRG_Heli_Transport_01_tropic_F";

OT_NATO_weapons_Police = ["hgun_PDW2000_F","SMG_05_F","SMG_01_F","SMG_02_F","arifle_SPAR_01_blk_F","arifle_MXC_Black_F"];
OT_NATO_weapons_Pistols = ["hgun_Pistol_heavy_01_F","hgun_ACPC2_F","hgun_P07_F","hgun_Rook40_F"];

//Criminal stuff
OT_CRIM_Unit = "C_man_p_fugitive_F";
OT_CRIM_Clothes = ["U_I_C_Soldier_Bandit_3_F","U_BG_Guerilla3_1","U_C_HunterBody_grn","U_I_G_Story_Protagonist_F"];
OT_CRIM_Goggles = ["G_Balaclava_blk","G_Balaclava_combat","G_Balaclava_lowprofile","G_Balaclava_oli","G_Bandanna_blk","G_Bandanna_khk","G_Bandanna_oli","G_Bandanna_shades","G_Bandanna_sport","G_Bandanna_tan"];
OT_CRIM_Weapons = ["arifle_AK12_F","arifle_AKM_F","arifle_AKM_F","arifle_AKM_F"];
OT_CRIM_Pistols = ["hgun_Pistol_heavy_01_F","hgun_ACPC2_F","hgun_P07_F","hgun_Rook40_F"];
OT_CRIM_Launchers = ["launch_RPG32_F","launch_RPG7_F","launch_RPG7_F","launch_RPG7_F"];

OT_interactingWith = objNull;

//ECONOMY

//This is the prices table, shops will only stock these items, any others must be imported or produced and will have their costs generated automatically
//Format ["Cfg class",Base price,Steel,Wood,Plastics]

//The price of an item in a shop will be the base price + local markup (taking into account stability and player rep)
//The cost to produce an item will be the Base price - player/factory bonuses + raw materials
//The wholesale sell price of an item will be the base price - local markup
//NB: the local markup can be negative, making buy prices lower and sell prices higher, in certain situations (high stability and/or player rep)

OT_items = [];
if(OT_hasAce) then {
	OT_item_DefaultBlueprints pushback "ACE_fieldDressing";
	OT_item_DefaultBlueprints pushback "ACE_elasticBandage";
	[OT_items,[
		["ACE_fieldDressing",2,0,0,0.1],
		["ACE_elasticBandage",3,0,0,0.2],
		["ACE_morphine",20,0,0,0.2],
		["ACE_epinephrine",50,0,0,0.2],
		["ACE_adenosine",40,0,0,0.2],
		["ACE_SpraypaintBlue",20,0,0,0.2],
		["ACE_SpraypaintRed",20,0,0,0.2],
		["ACE_SpraypaintBlack",20,0,0,0.2],
		["ACE_EarPlugs",5,0,0,0.2],
		["ACE_Sandbag_empty",2,0,0,0],
		["ACE_Altimeter",110,0,0,1],
		["ACE_Banana",1,0,0,0],
		["ACE_RangeTable_82mm",1,0,0,1],
		["ACE_ATragMX",140,0,0,1],
		["ACE_microDAGR",200,0,0,1],
		["ACE_DAGR",100,0,0,1],
		["ACE_DefusalKit",5,0,0,1],
		["ACE_EntrenchingTool",6,0,0,1],
		["ACE_HuntIR_monitor",300,0,0,1],
		["ACE_IR_Strobe_Item",10,0,0,1],
		["ACE_packingBandage",3,0,0,1],
		["ACE_personalAidKit",4,0,0,1],
		["ACE_RangeCard",1,0,0,0.1],
		["ACE_salineIV",5,0,0,1],
		["ACE_salineIV_250",7,0,0,1],
		["ACE_salineIV_500",10,0,0,1],
		["ACE_SpottingScope",75,0,0,1],
		["ACE_Tripod",35,0,0,1],
		["ACE_surgicalKit",32,0,0,1],
		["ACE_tourniquet",27,0,0,1],
		["ACE_UAVBattery",14,0,0,1],
		["ACE_wirecutter",4,0,0,1],
		["ACE_MapTools",2,0,0,1],
		["ACE_bloodIV",80,0,0,1],
		["ACE_Cellphone",100,0,0,1]
	]] call BIS_fnc_arrayPushStack;
}else{
	OT_item_DefaultBlueprints pushback "FirstAidKit";
	OT_item_DefaultBlueprints pushback "Medikit";
	[OT_items,[
		["FirstAidKit",10,0,0,0.1],
		["Medikit",40,0,0,0.5]
	]] call BIS_fnc_arrayPushStack;
};

if(OT_hasTFAR) then {
	[OT_items,[
		["tf_anprc148jem",20,0,0,0.1],
		["tf_anprc152",20,0,0,0.1],
		["tf_fadak",20,0,0,0.5],
		["tf_pnr1000a",10,0,0,0.5],
		["tf_rf7800str",10,0,0,0.5]
	]] call BIS_fnc_arrayPushStack;
}else{
	OT_items pushback ["ItemRadio",20,0,0,1];
};

OT_item_DefaultBlueprints pushback "ToolKit";

[OT_items,[
	["Laserdesignator",220,1,0,0],
	["Laserdesignator_01_khk_F",220,1,0,0],
	["Laserdesignator_02_ghex_F",200,1,0,0],
	["MineDetector",10,1,0,0],
	["ToolKit",25,0,0.5,0],
	["ItemGPS",60,0,0,1],
	["ItemCompass",5,0.1,0,0],
	["ItemMap",1,0,0,0],
	["ItemWatch",30,0,0,1],
	["Binocular",70,0,0,1],
	["Rangefinder",130,0,0,1],
	["I_UAVTerminal",100,0,0,1]
]] call BIS_fnc_arrayPushStack;

OT_staticBackpacks = [
	["I_HMG_01_high_weapon_F",600,1,0,1],
	["I_GMG_01_high_weapon_F",2500,1,0,1],
	["I_HMG_01_support_high_F",50,1,0,0],
	["I_Mortar_01_weapon_F",5000,1,0,1],
	["I_Mortar_01_support_F",100,1,0,0],
	["I_AT_01_weapon_F",2500,1,0,1],
	["I_AA_01_weapon_F",2500,1,0,1],
	["I_HMG_01_support_F",50,1,0,0]
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
	["B_Bergen_hex_F",100,0,0,1],
	["B_Parachute",120,0,0,1]
];

if(OT_hasAce) then {
	OT_items pushback ["ACE_TacticalLadder_Pack",40,0,0,1];
};

cost setVariable ["OT_Wood",[10,0,0,0],true];
cost setVariable ["OT_Steel",[30,0,0,0],true];
cost setVariable ["OT_Plastic",[20,0,0,0],true];
cost setVariable ["OT_Sugarcane",[15,0,0,0],true];
cost setVariable ["OT_Sugar",[25,0,0,0],true];
cost setVariable ["OT_Fertilizer",[30,0,0,0],true];

if(OT_hasTFAR) then {
	[OT_backpacks,[
		["tf_anprc155",100,0,0,0.1],
		["tf_anarc210",150,0,0,0.1],
		["tf_anarc164",20,0,0,0.5],
		["tf_anprc155_coyote",10,0,0,0.5]
	]] call BIS_fnc_arrayPushStack;
};



OT_boats = [
	["C_Scooter_Transport_01_F",150,1,0,1],
	["C_Boat_Civil_01_rescue_F",300,1,1,1],
	["C_Boat_Transport_02_F",600,1,0,1]
];
OT_vehicles = [];
OT_helis = [];
OT_allVehicles = [];
OT_allBoats = ["B_Boat_Transport_01_F"];
OT_allItems = [];
OT_allWeapons = [];
OT_allOptics = [];
OT_allMagazines = [OT_ammo_50cal];
OT_allBackpacks = [];
OT_allStaticBackpacks = [];
OT_vehWeights_civ = [];
_mostExpensive = 0;
OT_mostExpensiveVehicle = "";

private _allVehs = "
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2
    &&
	{ (getArray ( _x >> ""threat"" ) select 0) < 0.5}
	&&
    { (getText ( _x >> ""vehicleClass"" ) isEqualTo ""Car"") or (getText ( _x >> ""vehicleClass"" ) isEqualTo ""Support"")}
	&&
    { (getText ( _x >> ""faction"" ) isEqualTo ""CIV_F"") or
     (getText ( _x >> ""faction"" ) isEqualTo ""IND_F"")})

" configClasses ( configFile >> "cfgVehicles" );

{
	_cls = configName _x;
	_cost = round(getNumber (configFile >> "cfgVehicles" >> _cls >> "armor") + (getNumber (configFile >> "cfgVehicles" >> _cls >> "enginePower") * 2));
	_cost = _cost + round(getNumber (configFile >> "cfgVehicles" >> _cls >> "maximumLoad") * 0.1);

	if(_cls isKindOf "Truck_F") then {_cost = _cost * 2};
	if(getText (configFile >> "cfgVehicles" >> _cls >> "faction") != "CIV_F") then {_cost = _cost * 1.5};


	OT_vehicles pushback [_cls,_cost,0,getNumber (configFile >> "cfgVehicles" >> _cls >> "armor"),2];
	OT_allVehicles pushback _cls;
	if(getText (configFile >> "cfgVehicles" >> _cls >> "faction") == "CIV_F") then {
		if(getText(configFile >> "cfgVehicles" >> _cls >> "textSingular") != "truck" and getText(configFile >> "cfgVehicles" >> _cls >> "driverAction") != "Kart_driver") then {
			OT_vehTypes_civ pushback _cls;

			if(_cost > _mostExpensive)then {
				_mostExpensive = _cost;
				OT_mostExpensiveVehicle = _cls;
			};
		};
	};
} foreach (_allVehs);

private _allHelis = "
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2
    &&
	{ (getArray ( _x >> ""threat"" ) select 0) < 0.5}
	&&
    { getText ( _x >> ""vehicleClass"" ) isEqualTo ""Air""}
	&&
    { (getText ( _x >> ""faction"" ) isEqualTo ""CIV_F"") or
     (getText ( _x >> ""faction"" ) isEqualTo ""IND_F"")})
" configClasses ( configFile >> "cfgVehicles" );

{
	_cls = configName _x;
	_multiply = 3;
	if(_cls isKindOf "Plane") then {_multiply = 6};
	_cost = (getNumber (configFile >> "cfgVehicles" >> _cls >> "armor") + getNumber (configFile >> "cfgVehicles" >> _cls >> "enginePower")) * _multiply;
	_cost = _cost + round(getNumber (configFile >> "cfgVehicles" >> _cls >> "maximumLoad") * _multiply);
	_steel = round(getNumber (configFile >> "cfgVehicles" >> _cls >> "armor"));
	_numturrets = count("" configClasses(configFile >> "cfgVehicles" >> _cls >> "Turrets"));
	_plastic = 2;
	if(_numturrets > 0) then {
		_cost = _cost + (_numturrets * _cost * _multiply);
		_steel = _steel * 3;
		_plastic = 6;
	};

	if(isServer) then {
		cost setVariable [_cls,[_cost,0,_steel,_plastic],true];
	};

	OT_helis pushback [_cls,[_cost,0,_steel,_plastic],true];
	OT_allVehicles pushback _cls;
} foreach (_allHelis);

if(isServer) then {
	//Chinook (unarmed) special case for production logistics
	cost setVariable ["B_Heli_Transport_03_unarmed_F",[150000,0,110,5],true];
	OT_helis pushback ["B_Heli_Transport_03_unarmed_F",[150000,0,110,5],true];
	OT_allVehicles pushback "B_Heli_Transport_03_unarmed_F";
};

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


private _allWeapons = "
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2
    &&
    { getText ( _x >> ""simulation"" ) isEqualTo ""Weapon""})
" configClasses ( configFile >> "cfgWeapons" );

private _allAttachments = "
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2
    &&
    { _t = getNumber ( _x >> ""ItemInfo"" >> ""type"" ); _t isEqualTo 301 or _t isEqualTo 302 or _t isEqualTo 101})
" configClasses ( configFile >> "cfgWeapons" );

private _allOptics = "
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2
    &&
    { getNumber ( _x >> ""ItemInfo"" >> ""optics"" ) isEqualTo 1})
" configClasses ( configFile >> "cfgWeapons" );

private _allDetonators = "
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2
    &&
    { getNumber ( _x >> ""ace_explosives_Detonator"" ) isEqualTo 1})
" configClasses ( configFile >> "cfgWeapons" );

private _allUniforms = "
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2
    &&
    { getNumber ( _x >> ""ItemInfo"" >> ""type"" ) isEqualTo 801})
" configClasses ( configFile >> "cfgWeapons" );

private _allHelmets = "
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2
    &&
    { getNumber ( _x >> ""ItemInfo"" >> ""type"" ) isEqualTo 605})
" configClasses ( configFile >> "cfgWeapons" );

private _allAmmo = "
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2 )
" configClasses ( configFile >> "cfgMagazines" );

private _allVehicles = "
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2 )
" configClasses ( configFile >> "cfgVehicles" );

private _allFactions = "
    ( getNumber ( _x >> ""side"" ) < 3 )
" configClasses ( configFile >> "cfgFactionClasses" );

OT_allFactions = [];
OT_allSubMachineGuns = [];
OT_allAssaultRifles = [];
OT_allMachineGuns = [];
OT_allSniperRifles = [];
OT_allHandGuns = [];
OT_allMissileLaunchers = [];
OT_allRocketLaunchers = [];
OT_allExpensiveRifles = [];
OT_allCheapRifles = [];
OT_allVests = [];
OT_allProtectiveVests = [];
OT_allExpensiveVests = [];
OT_allCheapVests = [];
OT_allClothing = [];
OT_allOptics = [];
OT_allHelmets = [];
OT_allHats = [];
OT_allAttachments = [];
OT_allExplosives = [];
OT_explosives = [];
OT_detonators = [];
OT_allDetonators = [];

{
	_name = configName _x;
	_title = getText (configFile >> "cfgFactionClasses" >> _name >> "displayName");
	_side = getNumber (configFile >> "cfgFactionClasses" >> _name >> "side");
	_flag = getText (configFile >> "cfgFactionClasses" >> _name >> "flag");
	if(_side > -1) then {
		OT_allFactions pushback [_name,_title,_side,_flag];
	};

	if(isServer) then {
		//Get vehicles and weapons
		private _vehicles = [];
		private _weapons = [];
		private _blacklist = ["Throw","Put","NLAW_F"];

		private _all = "
		    ( getNumber ( _x >> ""scope"" ) isEqualTo 2 )
			and ( getText ( _x >> ""faction"" ) isEqualTo """ + _name + """ )
		" configClasses ( configFile >> "cfgVehicles" );
		{
			_cls = configName _x;
			if(_cls isKindOf "CAManBase") then {
				//Get weapons;
				{
					_x = [_x] call BIS_fnc_baseWeapon;
					if !(_x in _blacklist) then {
						if !(_x in _weapons) then {_weapons pushback _x};
					};
				}foreach(getArray(configFile >> "CfgVehicles" >> _cls >> "weapons"));
				//Get ammo
				{
					if !(_x in _blacklist or _x in OT_allExplosives) then {
						if !(_x in _weapons) then {_weapons pushback _x};
					};
				}foreach(getArray(configFile >> "CfgVehicles" >> _cls >> "magazines"));
			}else{
				//It's a vehicle
				if !(_cls isKindOf "Bag_Base" or _cls isKindOf "StaticWeapon") then {
					if(_cls isKindOf "LandVehicle" or _cls isKindOf "Air") then {
						_vehicles pushback _cls;
					};
				};
			};
		}foreach(_all);

		spawner setVariable [format["facweapons%1",_name],_weapons,true];
		spawner setVariable [format["facvehicles%1",_name],_vehicles,true];
	};
}foreach(_allFactions);

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

	_weapon = [_name] call BIS_fnc_itemType;
	_weaponType = _weapon select 1;

	_muzzles = getArray (configFile >> "CfgWeapons" >> _name >> "muzzles");
	{
		if((_x find "EGLM") > -1) then {
			_haslauncher = true;
		};
	}foreach(_muzzles);

	_cost = 500;
	_steel = 1;
	switch (_weaponType) do	{
		case "SubmachineGun": {_steel = 0.5;_cost = 250;OT_allSubMachineGuns pushBack _name};

		case "AssaultRifle": {
			call {
				if(_caliber == " 5.56" or _caliber == "5.56" or _caliber == " 5.45" or _caliber == " 5.8") exitWith {_cost = 500};
				if(_caliber == " 12 gauge") exitWith {_cost = 1200};
				if(_caliber == " .408") exitWith {_cost = 2000};
				if(_caliber == " .338 Lapua Magnum" or _caliber == " .303") exitWith {_cost = 700};
				if(_caliber == " 9") exitWith {_cost = 400}; //9x21mm
				if(_caliber == " 6.5") exitWith {_cost = 1000};
				if(_caliber == " 7.62") exitWith {_cost = 1500};
				if(_caliber == " 9.3" or _caliber == "9.3") exitWith {_cost = 1700};
				if(_caliber == " 12.7") exitWith {_cost = 3000};
				//I dunno what caliber this is
				_cost = 1500;
			};
			if(_haslauncher) then {_cost = round(_cost * 1.2)};
			OT_allAssaultRifles pushBack _name;
			if(_cost > 1400) then {
				OT_allExpensiveRifles pushback _name;
			};
			if(_cost < 1400) then {
				OT_allCheapRifles pushback _name;
			};
		};
		case "MachineGun": {_cost = 1500;OT_allMachineGuns pushBack _name};
		case "SniperRifle": {_cost = 2000;OT_allSniperRifles pushBack _name};
		case "Handgun": {_steel = 0.2;_cost = 100; if(_short != "Metal Detector") then {OT_allHandGuns pushBack _name}};
		case "MissileLauncher": {_cost=2500;OT_allMissileLaunchers pushBack _name};
		case "RocketLauncher": {_cost = 1000;if(_name == "launch_NLAW_F") then {_cost=400};OT_allRocketLaunchers pushBack _name};
		case "Vest": {
			if !(_name in (OT_illegalVests + ["V_RebreatherB","V_RebreatherIA","V_RebreatherIR","V_Rangemaster_belt"])) then {
				_cost = 40 + (getNumber(configFile >> "CfgWeapons" >> _name >> "ItemInfo" >> "HitpointsProtectionInfo" >> "Chest" >> "armor") * 20);
				OT_allVests pushBack _name;
				if(_cost > 40) then {
					OT_allProtectiveVests pushback _name;
				};
				if(_cost > 300) then {
					OT_allExpensiveVests pushback _name;
				};
				if(_cost < 300 and _cost > 40) then {
					OT_allCheapVests pushback _name;
				};
			};
		};
	};
	if(isServer) then {
		cost setVariable [_name,[_cost,0,_steel,0],true];
	};
} foreach (_allWeapons);

{
	_name = configName _x;
	_short = getText (configFile >> "CfgWeapons" >> _name >> "descriptionShort");
	_supply = getText(configfile >> "CfgWeapons" >> _name >> "ItemInfo" >> "containerClass");
	_carry = getNumber(configfile >> "CfgVehicles" >> _supply >> "maximumLoad");
	_cost = round(_carry * 0.5);

	OT_allClothing pushback _name;
	cost setVariable [_name,[_cost,0,0,1],true];
} foreach (_allUniforms);

{
	_name = configName _x;
	_cost = 20 + (getNumber(configFile >> "CfgWeapons" >> _name >> "ItemInfo" >> "HitpointsProtectionInfo" >> "Head" >> "armor") * 30);
	if(_cost > 20) then {
		OT_allHelmets pushback _name;
	}else{
		OT_allHats pushback _name;
	};
	if(isServer) then {
		cost setVariable [_name,[_cost,0,1,0],true];
	};
} foreach (_allHelmets);

{
	_name = configName _x;
	_m = getNumber(_x >> "mass");
	if(_name isKindOf ["CA_Magazine",configFile >> "CfgMagazines"] and (_name != "NLAW_F") and !(_name isKindOf ["VehicleMagazine",configFile >> "CfgMagazines"])) then {
		_cost = round(_m * 4);
		_desc = getText(_x >> "descriptionShort");
		_exp = false;
		_steel = 0.1;
		_plastic = 0;
		if(getNumber(_x >> "ace_explosives_Placeable") == 1) then {
			_exp = true;
		};
		if((_desc find "Smoke") > -1) then {
			_cost = round(_m * 0.5);
		}else{
			if((_desc find "Grenade") > -1) then {
				_cost = round(_m * 2);
				_exp = true;
			};
		};
		if((_desc find "Flare") > -1 or (_desc find "flare") > -1) then {
			_cost = round(_m * 0.6);
			_exp = false;
		};

		if(_name == OT_ammo_50cal) then {_cost = 50};

		if(_exp) then {
			_steel = 0;
			_plastic = round(_m * 0.5);
			OT_allExplosives pushback _name;
			OT_explosives pushback [_name,_cost,0,_steel,_plastic];
		}else{
			OT_allMagazines pushback _name;
		};
		if(isServer) then {
			cost setVariable [_name,[_cost,0,_steel,_plastic],true];
		};
	};
} foreach (_allAmmo);

{
	_name = configName _x;
	_m = getNumber(_x >> "ItemInfo" >> "mass");
	if(getNumber(_x >> "ace_explosives_Range") > 1000) then {
		_m = _m * 10;
	};
	OT_allDetonators pushback _name;
	OT_detonators pushback [_name,_m,0,0.1,0];
	if(isServer) then {
		cost setVariable [_name,[_m,0,0.1,0],true];
	};
} foreach (_allDetonators);

if(isServer) then {
	//Remainding vehicle costs
	{
		_name = configName _x;
		if(_name isKindOf "AllVehicles" and !(_name in OT_allVehicles)) then {
			_multiply = 15;
			if(_name isKindOf "Plane") then {_multiply = 50}; //Planes are light

			_cost = (getNumber (configFile >> "cfgVehicles" >> _name >> "armor") + getNumber (configFile >> "cfgVehicles" >> _name >> "enginePower")) * _multiply;
			_cost = _cost + round(getNumber (configFile >> "cfgVehicles" >> _name >> "maximumLoad") * _multiply);
			_steel = round(getNumber (configFile >> "cfgVehicles" >> _name >> "armor"));
			_numturrets = count("" configClasses(configFile >> "cfgVehicles" >> _name >> "Turrets"));
			_plastic = 2;
			if(_numturrets > 0) then {
				_cost = _cost + (_numturrets * _cost);
				_steel = _steel * 3;
				_plastic = 6;
			};

			cost setVariable [_name,[_cost,0,_steel,_plastic],true];
		};
	} foreach (_allVehicles);
};

OT_attachments = [];
{
	_name = configName _x;
	_cost = 75;
	_t = getNumber(configFile >> "CfgWeapons" >> _name >> "ItemInfo" >> "type");
	if(_t == 302) then {
		//Bipods
		_cost = 150;
	};
	if(_t == 101) then {
		//Suppressors
		_cost = 350;
	};
	if(isServer) then {
		cost setVariable [_name,[_cost,0,0,0.25],true];
	};
	OT_allAttachments pushback _name;
	OT_attachments pushback [_name,[_cost,0,0,0.25]];
} foreach (_allAttachments);

{
	_name = configName _x;
	_allModes = "true" configClasses ( configFile >> "cfgWeapons" >> _name >> "ItemInfo" >> "OpticsModes" );
	_cost = 50;
	{
		_mode = configName _x;
		_max = getNumber (configFile >> "cfgWeapons" >> _name >> "ItemInfo" >> "OpticsModes" >> _mode >> "distanceZoomMax");
		_mul = 0.1;
		if(_mode == "NVS") then {_mul = 0.2};
		if(_mode == "TWS") then {_mul = 0.5};
		_cost = _cost + floor(_max * _mul);
	}foreach(_allModes);

	OT_allOptics pushback _name;
	if(isServer) then {
		cost setVariable [_name,[_cost,0,0,0.5],true];
	};
} foreach (_allOptics);

OT_allWeapons = OT_allSubMachineGuns + OT_allAssaultRifles + OT_allMachineGuns + OT_allSniperRifles + OT_allHandGuns + OT_allMissileLaunchers + OT_allRocketLaunchers;

if(isServer) then {
	cost setVariable ["CIV",[80,0,0,0],true];
	cost setVariable ["WAGE",[5,0,0,0],true];
	cost setVariable [OT_item_UAV,[200,0,0,1],true];
	cost setVariable ["FUEL",[5,0,0,0],true];

	//Drug prices
	cost setVariable ["OT_Ganja",[100,0,0,0],true];
	cost setVariable ["OT_Blow",[250,0,0,0],true];
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

OT_mansions = ["Land_House_Big_02_F","Land_House_Big_03_F","Land_Hotel_01_F","Land_Hotel_02_F"]; //buildings that rich guys like to live in

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
OT_carShops = ["Land_FuelStation_01_workshop_F","Land_FuelStation_02_workshop_F"]; //buildings that will spawn car salesmen (must have a template with a cash register)
OT_piers = ["Land_PierConcrete_01_4m_ladders_F","Land_PierWooden_01_platform_F","Land_PierWooden_01_hut_F","Land_PierWooden_02_hut_F"]; //spawns dudes that sell boats n stuff
OT_offices = ["Land_MultistoryBuilding_01_F","Land_MultistoryBuilding_04_F"];
OT_portBuildings = ["Land_Warehouse_01_F","Land_Warehouse_02_F","Land_ContainerLine_01_F","Land_ContainerLine_02_F","Land_ContainerLine_03_F"];
OT_airportTerminals = ["Land_Airport_01_terminal_F","Land_Airport_02_terminal_F","Land_Hangar_F"];
OT_portBuilding = "Land_Warehouse_02_F";
OT_policeStation = "Land_Cargo_House_V3_F";
OT_warehouse = "Land_Warehouse_03_F";
OT_barracks = "Land_Barracks_01_grey_F";
OT_workshopBuilding = "Land_Cargo_House_V4_F";
OT_refugeeCamp = "Land_Medevac_house_V1_F";
OT_trainingCamp = "Land_IRMaskingCover_02_F";

OT_loadingMessages = ["Adding Hidden Agendas","Adjusting Bell Curves","Aesthesizing Industrial Areas","Aligning Covariance Matrices","Applying Feng Shui Shaders","Applying Theatre Soda Layer","Asserting Packed Exemplars","Attempting to Lock Back-Buffer","Binding Sapling Root System","Breeding Fauna","Building Data Trees","Bureacritizing Bureaucracies","Calculating Inverse Probability Matrices","Calculating Llama Expectoration Trajectory","Calibrating Blue Skies","Charging Ozone Layer","Coalescing Cloud Formations","Cohorting Exemplars","Collecting Meteor Particles","Compounding Inert Tessellations","Compressing Fish Files","Computing Optimal Bin Packing","Concatenating Sub-Contractors","Containing Existential Buffer","Debarking Ark Ramp","Debunching Unionized Commercial Services","Deciding What Message to Display Next","Decomposing Singular Values","Decrementing Tectonic Plates","Deleting Ferry Routes","Depixelating Inner Mountain Surface Back Faces","Depositing Slush Funds","Destabilizing Economic Indicators","Determining Width of Blast Fronts","Deunionizing Bulldozers","Dicing Models","Diluting Livestock Nutrition Variables","Downloading Satellite Terrain Data","Exposing Flash Variables to Streak System","Extracting Resources","Factoring Pay Scale","Fixing Election Outcome Matrix","Flood-Filling Ground Water","Flushing Pipe Network","Gathering Particle Sources","Generating Jobs","Gesticulating Mimes","Graphing Whale Migration","Hiding Willio Webnet Mask","Implementing Impeachment Routine","Increasing Accuracy of RCI Simulators","Increasing Magmafacation","Initializing Rhinoceros Breeding Timetable","Initializing Robotic Click-Path AI","Inserting Sublimated Messages","Integrating Curves","Integrating Illumination Form Factors","Integrating Population Graphs","Iterating Cellular Automata","Lecturing Errant Subsystems","Mixing Genetic Pool","Modeling Object Components","Mopping Occupant Leaks","Normalizing Power","Obfuscating Quigley Matrix","Overconstraining Dirty Industry Calculations","Partitioning City Grid Singularities","Perturbing Matrices","Pixellating Nude Patch","Polishing Water Highlights","Populating Lot Templates","Preparing Sprites for Random Walks","Prioritizing Landmarks","Projecting Law Enforcement Pastry Intake","Realigning Alternate Time Frames","Reconfiguring User Mental Processes","Relaxing Splines","Removing Road Network Speed Bumps","Removing Texture Gradients","Removing Vehicle Avoidance Behavior","Resolving GUID Conflict","Reticulating Splines","Retracting Phong Shader","Retrieving from Back Store","Reverse Engineering Image Consultant","Routing Neural Network Infanstructure","Scattering Rhino Food Sources","Scrubbing Terrain","Searching for Llamas","Seeding Architecture Simulation Parameters","Sequencing Particles","Setting Advisor ","Setting Inner Deity ","Setting Universal Physical Constants","Sonically Enhancing Occupant-Free Timber","Speculating Stock Market Indices","Splatting Transforms","Stratifying Ground Layers","Sub-Sampling Water Data","Synthesizing Gravity","Synthesizing Wavelets","Time-Compressing Simulator Clock","Unable to Reveal Current Activity","Weathering Buildings","Zeroing Crime Network"];
OT_allBuyableBuildings = OT_lowPopHouses + OT_medPopHouses + OT_highPopHouses + OT_hugePopHouses + OT_mansions + [OT_item_Tent,OT_item_Flag];
OT_allRealEstate = OT_lowPopHouses + OT_medPopHouses + OT_highPopHouses + OT_hugePopHouses + OT_mansions + [OT_warehouse,OT_policeStation,OT_barracks,OT_barracks,OT_workshopBuilding,OT_refugeeCamp,OT_trainingCamp];

OT_Buildables = [
	["Training Camp",1500,[] call compileFinal preProcessFileLineNumbers "templates\military\trainingCamp.sqf","OT_fnc_initTrainingCamp",true,"Allows training of recruits and hiring of mercenaries"],
	["Bunkers",500,["Land_BagBunker_01_small_green_F","Land_HBarrier_01_big_tower_green_F","Land_HBarrier_01_tower_green_F"],"",false,"Small Defensive Structures. Press space to change type."],
	["Walls",200,["Land_ConcreteWall_01_l_8m_F","Land_ConcreteWall_01_l_gate_F","Land_HBarrier_01_wall_6_green_F","Land_HBarrier_01_wall_4_green_F","Land_HBarrier_01_wall_corner_green_F"],"",false,"Stop people (or tanks) from getting in. Press space to change type."],
	["Helipad",50,["Land_HelipadCircle_F","Land_HelipadCivil_F","Land_HelipadRescue_F","Land_HelipadSquare_F"],"",false,"Informs helicopter pilots of where might be a nice place to land"],
	["Observation Post",800,["Land_Cargo_Patrol_V4_F"],"OT_fnc_initObservationPost",false,"Includes unarmed personnel to keep an eye over the area and provide intel on enemy positions"],
	["Barracks",5000,[OT_barracks],"",false,"Allows recruiting of squads"],
	["Guard Tower",5000,["Land_Cargo_Tower_V4_F"],"",false,"It's a huge tower, what else do you need?."],
	["Hangar",1200,["Land_Airport_01_hangar_F"],"",false,"A big empty building, could probably fit a plane inside it."],
	["Workshop",1000,[] call compileFinal preProcessFileLineNumbers "templates\military\workshop.sqf","OT_fnc_initWorkshop",true,"Attach weapons to vehicles"],
	["House",1100,["Land_House_Small_06_F","Land_House_Small_02_F","Land_House_Small_03_F","Land_GarageShelter_01_F","Land_Slum_04_F"],"",false,"4 walls, a roof, and if you're lucky a door that opens."],
	["Police Station",2500,[OT_policeStation],"OT_fnc_initPoliceStation",false,"Allows hiring of policeman to raise stability in a town and keep the peace. Comes with 2 units."],
	["Warehouse",4000,[OT_warehouse],"OT_fnc_initWarehouse",false,"A house that you put wares in."],
	["Refugee Camp",600,[OT_refugeeCamp],"",false,"Attracts scared civilians that are more likely to join your cause"]
];

OT_workshop = [
	["Static MG","C_Offroad_01_F",600,"I_HMG_01_high_weapon_F","I_HMG_01_high_F",[[0.25,-2,1]],0],
	["Static GL","C_Offroad_01_F",1100,"I_GMG_01_high_weapon_F","I_GMG_01_high_F",[[0.25,-2,1]],0],
	["Static AT","C_Offroad_01_F",2600,"I_AT_01_weapon_F","I_static_AT_F",[[0,-1.5,0.25],180]],
	["Static AA","C_Offroad_01_F",2600,"I_AA_01_weapon_F","I_static_AA_F",[[0,-1.5,0.25],180]]
];

{
	_istpl = _x select 4;
	if(_istpl) then {
		_tpl = _x select 2;
		OT_allBuyableBuildings pushback ((_tpl select 0) select 0);
	}else{
		[OT_allBuyableBuildings,(_x select 2)] call BIS_fnc_arrayPushStack;
	}
}foreach(OT_Buildables);

OT_allHouses = OT_lowPopHouses + OT_medPopHouses + OT_highPopHouses + OT_hugePopHouses + OT_touristHouses;

OT_allTowns = [];
OT_allTownPositions = [];

{
	_x params ["_pos","_name"];
	OT_allTowns pushBack _name;
	OT_allTownPositions pushBack _pos;
	if(isServer) then {
		server setVariable [_name,_pos,true];
	};
}foreach (OT_townData);


OT_allAirports = [];
{
		OT_allAirports pushBack (_x select 1);
}foreach (OT_airportData);

if(isServer) then {
	cost setVariable ["V_RebreatherIA",[75,0,0,1],true];
};
