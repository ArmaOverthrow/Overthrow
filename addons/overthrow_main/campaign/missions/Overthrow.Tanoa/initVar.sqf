//Here is where you can change stuff to suit your liking or support mods/another map
private ["_allPrimaryWeapons","_allHandGuns","__allLaunchers"];

OT_centerPos = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");

//Used to control updates and persistent save compatability. When these numbers go up, that section will be reinitialized on load if required. (ie leave them alone)
OT_economyVersion = 9;
OT_NATOversion = 4;
OT_CRIMversion = 1;
OT_adminMode = false;
OT_economyLoadDone = false;

OT_hasAce = false;
if (isClass (configFile >> "CfgPatches" >> "ace_ui")) then {
	OT_hasAce = true;
};

OT_hasTFAR = false;
if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
	OT_hasTFAR = true;
};

OT_allIntel = [];

OT_fastTime = true; //When true, 1 day will last 6 hrs real time
OT_spawnDistance = 1200;
OT_spawnCivPercentage = 0.1;
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

OT_NATOwait = 400; //Half the Average time between NATO orders
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

OT_allLowAnimals = ["Rabbit_F","Turtle_F"];
OT_allHighAnimals = ["Goat_random_F"];
OT_allFarmAnimals = ["Hen_random_F","Cock_random_F","Sheep_random_F"];
OT_allVillageAnimals = ["Hen_random_F","Cock_random_F"];
OT_allTownAnimals = ["Alsatian_Random_F","Fin_random_F"];

OT_ferryDestinations = ["destination_1","destination_2","destination_3","destination_4","destination_5","destination_6"];

_miscables = ["Land_PortableLight_single_F","Land_PortableLight_double_F","Land_Camping_Light_F","Land_PortableHelipadLight_01_F","PortableHelipadLight_01_blue_F","PortableHelipadLight_01_green_F","PortableHelipadLight_01_red_F","PortableHelipadLight_01_white_F","PortableHelipadLight_01_yellow_F","Land_Campfire_F"];

if(OT_hasACE) then {
	_miscables pushback "ACE_Wheel";
	_miscables pushback "ACE_Track";
};

//Items you can place
OT_Placeables = [
	["Sandbags",20,["Land_BagFence_01_long_green_F","Land_BagFence_01_short_green_F","Land_BagFence_01_round_green_F","Land_BagFence_01_corner_green_F","Land_BagFence_01_end_green_F"],[0,3,0.8],"Bags filled with lots of sand. Apparently this can stop bullets or something?"],
	["Camo Nets",40,["CamoNet_ghex_F","CamoNet_ghex_open_F","CamoNet_ghex_big_F"],[0,7,2],"Large and terribly flimsy structures that may or may not obscure your forces from airborne units."],
	["Barriers",60,["Land_HBarrier_01_line_5_green_F","Land_HBarrier_01_line_3_green_F","Land_HBarrier_01_line_1_green_F"],[0,4,1.2],"Really big sandbags, basically."],
	["Map",30,[OT_item_Map],[0,2,1.2],"Use these to save your game, change options or check town info."],
	["Safe",50,[OT_item_Safe],[0,2,0.5],"Store and retrieve money"],
	["Misc",30,_miscables,[0,3,1.2],"Various other items, including lights"]
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
	["I_Soldier_AAA_F","AssaultRifle","",200,"",""] //12
];

OT_Squadables = [
	["Sentry",[6,0]],
	["Sniper Squad",[4,5]],
	["AT Squad",[6,9,11,8]],
	["AA Squad",[6,10,12,8]],
	["Fire Team",[7,0,1,2,3,8]],
	["Infantry Team",[7,0,1,2,3,8,9,10]]
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

OT_civType_gunDealer = "C_man_p_fugitive_F";
OT_civType_local = "C_man_1";
OT_civType_carDealer = "C_man_w_worker_F";
OT_civType_shopkeeper = "C_man_w_worker_F";
OT_civType_worker = "C_man_w_worker_F";
OT_civType_priest = "C_man_w_worker_F";
OT_vehTypes_civ = []; //populated automatically, but you can add more here and they will appear in streets
OT_vehType_distro = "C_Van_01_box_F";
OT_vehType_ferry = "C_Boat_Transport_02_F";

OT_activeDistribution = [];
OT_activeShops = [];
OT_selling = false;
OT_taking = false;

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

OT_allDrugs = ["OT_Ganja","OT_Blow"];
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
OT_clothes_carDealers = ["U_Marshal"];
OT_clothes_harbor = ["U_C_man_sport_1_F","U_C_man_sport_2_F","U_C_man_sport_3_F"];
OT_clothes_guerilla = ["U_I_C_Soldier_Para_1_F","U_I_C_Soldier_Para_2_F","U_I_C_Soldier_Para_3_F","U_I_C_Soldier_Para_4_F"];
OT_clothes_police = ["U_I_G_resistanceLeader_F","U_BG_Guerilla2_1","U_BG_Guerilla2_3","U_I_C_Soldier_Para_4_F"];
OT_vest_police = "V_TacVest_blk_POLICE";
OT_hat_police = "H_Cap_police";
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
	["B_T_MRAP_01_hmg_F",5],
	["B_T_MRAP_01_gmg_F",5],
	["B_T_Static_AT_F",7],
	["B_HMG_01_high_F",10]
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
OT_NATO_Vehicle_Transport = ["B_T_Truck_01_transport_F","B_T_Truck_01_covered_F"];
OT_NATO_Vehicles_PoliceSupport = ["B_T_MRAP_01_hmg_F","B_T_MRAP_01_gmg_F","B_T_LSV_01_armed_F","B_Heli_Light_01_armed_F"];
OT_NATO_Vehicles_AirDrones = ["B_UAV_02_F"];
OT_NATO_Vehicles_CASDrone = "B_UAV_02_CAS_F";
OT_NATO_Vehicles_AirSupport = ["B_Heli_Attack_01_F"];
OT_NATO_Vehicles_GroundSupport = ["B_T_MRAP_01_gmg_F","B_T_MRAP_01_hmg_F","B_T_LSV_01_armed_F"];
OT_NATO_Vehicles_AirWingedSupport = ["B_Plane_CAS_01_F"];
OT_NATO_Vehicle_AirTransport_Small = "B_Heli_Transport_01_camo_F";
OT_NATO_Vehicle_AirTransport = ["B_Heli_Transport_03_F","B_Heli_Transport_01_F","B_Heli_Transport_01_F"];
OT_NATO_Vehicle_AirTransport_Large = "B_Heli_Transport_03_F";

OT_NATO_GroundForces = ["B_T_InfSquad_Weapons","B_T_InfSquad","B_T_InfSquad","B_T_InfSquad","B_T_InfSquad"];

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
OT_CRIM_Weapons = ["arifle_AK12_F","arifle_AKM_F","arifle_AKM_F","arifle_AKM_F"];
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
		["ACE_RangeCard",1,0,0,1],
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
		["ACE_bloodIV",120,0,0,1]
	]] call BIS_fnc_arrayPushStack;
}else{
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

[OT_items,[
	["Laserdesignator",220,1,0,0],
	["Laserdesignator_01_khk_F",220,1,0,0],
	["Laserdesignator_02_ghex_F",200,1,0,0],
	["MineDetector",10,1,0,0],
	["ToolKit",25,1,0,0],
	["ItemGPS",60,0,0,1],
	["ItemCompass",5,0.1,0,0],
	["ItemMap",1,0,0,0],
	["ItemWatch",30,0,0,1],
	["Binocular",70,0,0,1],
	["Rangefinder",130,0,0,1]
]] call BIS_fnc_arrayPushStack;

OT_staticBackpacks = [
	["I_HMG_01_high_weapon_F",500,1,0,1],
	["I_GMG_01_high_weapon_F",1000,1,0,1],
	["I_HMG_01_support_high_F",50,1,0,0],
	["I_Mortar_01_weapon_F",1500,1,0,1],
	["I_Mortar_01_support_F",100,1,0,0],
	["I_AT_01_weapon_F",2500,1,0,1],
	["I_AA_01_weapon_F",2500,1,0,1]
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
	OT_backpacks pushback ["ACE_TacticalLadder_Pack",40,0,0,1];
};

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


	OT_vehicles pushback [_cls,_cost,1,1,1];
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
	_cost = (getNumber (configFile >> "cfgVehicles" >> _cls >> "armor") + getNumber (configFile >> "cfgVehicles" >> _cls >> "enginePower"));
	_cost = _cost + round(getNumber (configFile >> "cfgVehicles" >> _cls >> "maximumLoad") * 3);

	if(isServer) then {
		cost setVariable [_cls,[_cost,1,1,1],true];
	};

	OT_helis pushback [_cls,_cost,1,1,1];
	OT_allVehicles pushback _cls;
} foreach (_allHelis);

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

private _allOptics = "
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2
    &&
    { getNumber ( _x >> ""ItemInfo"" >> ""optics"" ) isEqualTo 1})
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
		case "Handgun": {_cost = 100;OT_allHandGuns pushBack _name};
		case "MissileLauncher": {_cost=2500;OT_allMissileLaunchers pushBack _name};
		case "RocketLauncher": {_cost = 1500;OT_allRocketLaunchers pushBack _name};
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
		cost setVariable [_name,[_cost,1,0,1],true];
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
		cost setVariable [_name,[_cost,0,0,1],true];
	};
} foreach (_allHelmets);

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
		cost setVariable [_name,[_cost,0,0,1],true];
	};
} foreach (_allOptics);

OT_allWeapons = OT_allSubMachineGuns + OT_allAssaultRifles + OT_allMachineGuns + OT_allSniperRifles + OT_allHandGuns + OT_allMissileLaunchers + OT_allRocketLaunchers;

if(isServer) then {
	cost setVariable ["CIV",[100,0,0,0],true];
	cost setVariable [OT_item_UAV,[200,0,0,1],true];

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
OT_warehouses = ["Land_Warehouse_03_F"]; //buildings that will spawn local distribution centers
OT_carShops = ["Land_FuelStation_01_workshop_F","Land_FuelStation_02_workshop_F"]; //buildings that will spawn car salesmen (must have a template with a cash register)
OT_piers = ["Land_PierConcrete_01_4m_ladders_F","Land_PierWooden_01_platform_F","Land_PierWooden_01_hut_F","Land_PierWooden_02_hut_F"]; //spawns dudes that sell boats n stuff
OT_offices = ["Land_MultistoryBuilding_01_F","Land_MultistoryBuilding_04_F"];
OT_portBuildings = ["Land_Warehouse_01_F","Land_Warehouse_02_F","Land_ContainerLine_01_F","Land_ContainerLine_02_F","Land_ContainerLine_03_F"];
OT_airportTerminals = ["Land_Airport_01_terminal_F","Land_Airport_02_terminal_F","Land_Hangar_F"];
OT_portBuilding = "Land_Warehouse_02_F";
OT_policeStation = "Land_Cargo_House_V3_F";
OT_warehouse = "Land_Warehouse_03_F";
OT_barracks = "Land_Barracks_01_grey_F";

OT_loadingMessages = ["Adding Hidden Agendas","Adjusting Bell Curves","Aesthesizing Industrial Areas","Aligning Covariance Matrices","Applying Feng Shui Shaders","Applying Theatre Soda Layer","Asserting Packed Exemplars","Attempting to Lock Back-Buffer","Binding Sapling Root System","Breeding Fauna","Building Data Trees","Bureacritizing Bureaucracies","Calculating Inverse Probability Matrices","Calculating Llama Expectoration Trajectory","Calibrating Blue Skies","Charging Ozone Layer","Coalescing Cloud Formations","Cohorting Exemplars","Collecting Meteor Particles","Compounding Inert Tessellations","Compressing Fish Files","Computing Optimal Bin Packing","Concatenating Sub-Contractors","Containing Existential Buffer","Debarking Ark Ramp","Debunching Unionized Commercial Services","Deciding What Message to Display Next","Decomposing Singular Values","Decrementing Tectonic Plates","Deleting Ferry Routes","Depixelating Inner Mountain Surface Back Faces","Depositing Slush Funds","Destabilizing Economic Indicators","Determining Width of Blast Fronts","Deunionizing Bulldozers","Dicing Models","Diluting Livestock Nutrition Variables","Downloading Satellite Terrain Data","Exposing Flash Variables to Streak System","Extracting Resources","Factoring Pay Scale","Fixing Election Outcome Matrix","Flood-Filling Ground Water","Flushing Pipe Network","Gathering Particle Sources","Generating Jobs","Gesticulating Mimes","Graphing Whale Migration","Hiding Willio Webnet Mask","Implementing Impeachment Routine","Increasing Accuracy of RCI Simulators","Increasing Magmafacation","Initializing Rhinoceros Breeding Timetable","Initializing Robotic Click-Path AI","Inserting Sublimated Messages","Integrating Curves","Integrating Illumination Form Factors","Integrating Population Graphs","Iterating Cellular Automata","Lecturing Errant Subsystems","Mixing Genetic Pool","Modeling Object Components","Mopping Occupant Leaks","Normalizing Power","Obfuscating Quigley Matrix","Overconstraining Dirty Industry Calculations","Partitioning City Grid Singularities","Perturbing Matrices","Pixellating Nude Patch","Polishing Water Highlights","Populating Lot Templates","Preparing Sprites for Random Walks","Prioritizing Landmarks","Projecting Law Enforcement Pastry Intake","Realigning Alternate Time Frames","Reconfiguring User Mental Processes","Relaxing Splines","Removing Road Network Speed Bumps","Removing Texture Gradients","Removing Vehicle Avoidance Behavior","Resolving GUID Conflict","Reticulating Splines","Retracting Phong Shader","Retrieving from Back Store","Reverse Engineering Image Consultant","Routing Neural Network Infanstructure","Scattering Rhino Food Sources","Scrubbing Terrain","Searching for Llamas","Seeding Architecture Simulation Parameters","Sequencing Particles","Setting Advisor ","Setting Inner Deity ","Setting Universal Physical Constants","Sonically Enhancing Occupant-Free Timber","Speculating Stock Market Indices","Splatting Transforms","Stratifying Ground Layers","Sub-Sampling Water Data","Synthesizing Gravity","Synthesizing Wavelets","Time-Compressing Simulator Clock","Unable to Reveal Current Activity","Weathering Buildings","Zeroing Crime Network"];
OT_allBuyableBuildings = OT_lowPopHouses + OT_medPopHouses + OT_highPopHouses + OT_hugePopHouses + OT_mansions + [OT_item_Tent,OT_item_Flag];
OT_allRealEstate = OT_lowPopHouses + OT_medPopHouses + OT_highPopHouses + OT_hugePopHouses + OT_mansions + [OT_warehouse,OT_policeStation,OT_barracks,OT_barracks,"Land_Cargo_House_V4_F"];

OT_Buildables = [
	["Training Camp",1200,[] call compileFinal preProcessFileLineNumbers "templates\military\trainingCamp.sqf","structures\trainingCamp.sqf",true,"Allows training of recruits and hiring of mercenaries"],
	["Bunkers",500,["Land_BagBunker_01_small_green_F","Land_HBarrier_01_big_tower_green_F","Land_HBarrier_01_tower_green_F"],"",false,"Small Defensive Structures. Press space to change type."],
	["Walls",200,["Land_ConcreteWall_01_l_8m_F","Land_ConcreteWall_01_l_gate_F","Land_HBarrier_01_wall_6_green_F","Land_HBarrier_01_wall_4_green_F","Land_HBarrier_01_wall_corner_green_F"],"",false,"Stop people (or tanks) from getting in. Press space to change type."],
	["Helipad",50,["Land_HelipadCircle_F","Land_HelipadCivil_F","Land_HelipadRescue_F","Land_HelipadSquare_F"],"",false,"Apparently helicopter pilots need to be told where they are allowed to land"],
	["Observation Post",800,["Land_Cargo_Patrol_V4_F"],"structures\observationPost.sqf",false,"Includes unarmed personnel to keep an eye over the area and provide intel on enemy positions"],
	["Barracks",5000,[OT_barracks],"",false,"Allows recruiting of squads"],
	["Guard Tower",10000,["Land_Cargo_Tower_V4_F"],"",false,"It's a huge tower, what else do you need? besides 2 x Static MGs maybe but it comes with those."],
	["Hangar",1200,["Land_Airport_01_hangar_F"],"",false,"A big empty building, could probably fit a plane inside it."],
	["Workshop",2500,[] call compileFinal preProcessFileLineNumbers "templates\military\workshop.sqf","structures\workshop.sqf",true,"A place to repair and rearm your vehicles"],
	["House",1100,["Land_House_Small_06_F","Land_House_Small_02_F","Land_House_Small_03_F","Land_GarageShelter_01_F","Land_Slum_04_F"],"",false,"4 walls, a roof, and if you're lucky a door that opens."],
	["Police Station",3500,[OT_policeStation],"structures\policeStation.sqf",false,"Allows hiring of policeman to raise stability in a town and keep the peace. Comes with 2 units."],
	["Warehouse",5000,[OT_warehouse],"structures\warehouse.sqf",false,"A house that you put wares in."]
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
OT_allEnterableHouses = ["Land_House_Small_02_F","Land_House_Big_02_F","Land_House_Small_03_F","Land_House_Small_06_F","Land_House_Big_01_F","Land_Slum_05_F","Land_Slum_01_F","Land_GarageShelter_01_F","Land_House_Small_01_F","Land_Slum_03_F","Land_House_Big_04_F","Land_House_Small_04_F","Land_House_Small_05_F"];

OT_townData = [["Lami",[7941.7,7663.32,-7.3052]],["Lifou",[7080.21,8004.08,-2.67]],["Lobaka",[6028.08,8580.17,-26.4572]],["Lakatoro",[9213.6,8741.29,-220.615]],["La Foa",[8825.16,4778.34,0.205969]],["Savaka",[7211.97,4237.91,-1.39777]],["Regina",[4919.7,8728.68,-2.99988]],["Katkoula",[5684.68,3993.67,0.0045675]],["Moddergat",[9407.35,4133.13,-6.81528]],["Lösi",[10200.8,4964.28,-16.149]],["Tanouka",[9014.23,10214.2,-30.0952]],["Tobakoro",[8741.21,3556.31,0.0318844]],["Georgetown",[5396.22,10334.7,0.00964478]],["Kotomo",[10974.5,6232.58,-11.9053]],["Rautake",[3403.76,6836.13,0]],["Harcourt",[11122.5,5342.93,-0.0348662]],["Buawa",[8316.95,11132.2,-130.3]],["Saint-Julien",[5808.6,11213.3,-2.6792]],["Balavu",[2677.42,7441.56,0.00116708]],["Namuvaka",[2824.25,5700.17,-4.71091]],["Vagalala",[11069.2,9748.43,-112.357]],["Imone",[10487.6,10613.7,-163.045]],["Leqa",[2363.54,8236.87,-4.31921]],["Galili",[8114.07,11957.2,-216.278]],["Sosovu",[2686.79,9280.77,-4.71367]],["Blerick",[10255.9,2738.07,-9.01873]],["Yanukka",[3051.14,3448.56,-17.0524]],["Oua-Oué",[5752.39,12325.8,-26.058]],["Cerebu",[2131.95,4589.63,-6.61045]],["Laikoro",[1628.02,6190.57,0]],["Saioko",[12403.5,4569.93,-32.6168]],["Belfort",[3132.55,10977.1,0.0920983]],["Ouméré",[12984.3,7321.96,-0.00245522]],["Muaceba",[1556.43,8545.12,-0.733838]],["Nicolet",[6164.67,12864.7,0.0123867]],["Lailai",[3627.54,2208.85,-45.4752]],["Doodstil",[12861.9,4691.1,-2.63918]],["Tavu",[974.49,7654.05,-3.96532]],["Lijnhaven",[11802,2662.98,-0.0168395]],["Nani",[1954.62,10727,-5.50346]],["Petit Nicolet",[6813.05,13439.5,0.00345634]],["Port-Boisé",[12715.1,3309.17,-9.54124]],["Saint-Paul",[7829.41,13599.8,0.0181113]],["Nasua",[11417.6,12360.2,-105.833]],["Savu",[8393.35,13778.4,0.000719533]],["Luganville",[14040.9,8308.29,-1.57949]],["Momea",[10423.8,13252.2,-20.6373]],["La Rochelle",[9549.78,13673.4,0.0130114]],["Koumac",[1347.24,2968.37,0.0902042]],["Taga",[12255.2,1880.2,-121.022]],["Bua Bua",[13255.1,3019.73,-58.4955]],["Pénélo",[10966.2,13183.5,-16.9658]],["Vatukoulo",[14057.4,9955.55,-98.8908]],["Nandai",[14496.3,8877.4,-1.13811]],["Tuvanaka",[1579.49,11937.8,-0.253379]],["Rereki",[13069.4,2117.94,2.97365e-005]],["Ovau",[12401.7,12787.8,-1.56371]],["Blue Pearl industrial port",[13523,12134.8,0.26935]],["Ba",[14295.2,11680.3,-1.10196]],["Ipota",[12317.8,13929.5,-9.70543]]];
OT_allTowns = [];
OT_allTownPositions = [];

//get all the templates we need

_allTemplates = ["Land_FuelStation_01_shop_F","Land_FuelStation_01_workshop_F","Land_FuelStation_02_workshop_F","Land_GarageShelter_01_F","Land_House_Native_02_F","Land_House_Small_03_F","Land_Shop_City_02_F","Land_Shop_Town_01_F","Land_Shop_Town_03_F","Land_Slum_01_F","Land_Slum_02_F","Land_Supermarket_01_F"];

{
	_filename = format["templates\houses\%1.sqf",_x];

	_template = call(compileFinal preProcessFileLineNumbers _filename);
	{
		if((_x select 0) in OT_items_Simulate) then {
			_x set [8,true];
		}else{
			_x set [8,false];
		};
	}forEach(_template);

	templates setVariable [_x,_template,true];

} foreach(_allTemplates);

{
	_name = _x select 0;
	_pos = _x select 1;
	OT_allTowns pushBack _name;
	OT_allTownPositions pushBack _pos;
	if(isServer) then {
		server setVariable [_name,_pos,true];
	};
}foreach (OT_townData);

OT_airportData = [["Aéroport de Tanoa",[6952.61,7400.35,-2.66]],["Saint-George Airstrip",[11570,3150.79,-5.56791]],["Bala Airstrip",[2089.06,3523.68,-12.95]],["La Rochelle Aerodrome",[11650.3,13135.4,-6.95]],["Tuvanaka Airbase",[1953.34,13173.8,-13.45]]];
OT_allAirports = [];
{
		OT_allAirports pushBack (_x select 0);
}foreach (OT_airportData);

if(isServer) then {
	cost setVariable ["V_RebreatherIA",[75,0,0,1],true];
};
