
OT_nation = "Tanoa";
OT_saveName = "Overthrow.save.001";

OT_tutorial_backstoryText = "This is Tanoa, a small island nation in the South Pacific with a history of British and French colonialism. Tanoa is currently under occupation by NATO forces and has been at the center of international attention since the Vunakece regime was ousted in 2020. The Tanoan population is currently in dissaray and there are many conspiracy theories as to the economic and political future of this small but strategically valuable archipelago.<br/><br/>A massive protest against the NATO occupation recently took place in the nation's capital of Georgetown, where the spokesperson for the 'Free Tanoa' movement was assassinated by an unknown assailant. In response, NATO forces have issued a strict curfew and increased security to extreme levels; fuelling tension and conspiracy theories even further.";
OT_startDate = [2025,7,27,8,00];

OT_startCameraPos = [1385.17,505.453,1.88826];
OT_startCameraTarget = [1420,535,5.8];

//Used to control updates and persistent save compatability. When these numbers go up, that section will be reinitialized on load if required. (ie leave them alone)
OT_economyVersion = 13;
OT_NATOversion = 10;
OT_CRIMversion = 1;

OT_faction_NATO = "BLU_T_F";
OT_spawnFaction = "IND_F"; //This faction will have a rep in spawn town

OT_flag_NATO = "Flag_NATO_F";
OT_flag_CRIM = "Flag_Syndikat_F";
OT_flag_IND = "Flag_HorizonIslands_F";
OT_flagImage = "\A3\ui_f\data\map\markers\flags\Tanoa_ca.paa";
OT_flagMarker = "flag_Tanoa";

OT_populationMultiplier = 1.2; //Used to tweak populations per map

//Interactable items that spawn in your house
OT_item_Storage = "B_CargoNet_01_ammo_F"; //Your spawn ammobox
OT_item_Desk = "OfficeTable_01_new_F"; //Your spawn desk
OT_item_Radio = "Land_PortableLongRangeRadio_F";
OT_item_Map = "Mapboard_tanoa_F";
OT_item_Tent = "Land_TentDome_F";
OT_item_Safe = "Land_MetalCase_01_small_F";
OT_item_Workbench = "Land_Workbench_01_F";

//Animals to spawn (@todo: spawn animals)
OT_allLowAnimals = ["Rabbit_F","Turtle_F"];
OT_allHighAnimals = ["Goat_random_F"];
OT_allFarmAnimals = ["Hen_random_F","Cock_random_F","Sheep_random_F"];
OT_allVillageAnimals = ["Hen_random_F","Cock_random_F"];
OT_allTownAnimals = ["Alsatian_Random_F","Fin_random_F"];

OT_fuelPumps = ["Land_FuelStation_02_pump_F","Land_FuelStation_01_pump_F","Land_fs_feed_F","Land_FuelStation_Feed_F"];

OT_churches = ["Land_Church_03_F","Land_Church_01_F","Land_Church_02_F","Land_Temple_Native_01_F"];

OT_language_local = "LanguageENGFRE_F";
OT_identity_local = "Head_Tanoan";

OT_language_western = "LanguageENG_F";
OT_identity_western = "Head_Euro";

OT_language_eastern = "LanguageCHI_F";
OT_identity_eastern = "Head_Asian";

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
OT_vehType_service = "C_Offroad_01_repair_F";
OT_vehTypes_civignore = ["C_Hatchback_01_F","C_Hatchback_01_sport_F",OT_vehType_service]; //Civs cannot drive these vehicles for whatever reason

OT_illegalHeadgear = ["H_MilCap_gen_F","H_Beret_gen_F","H_HelmetB_TI_tna_F"];
OT_illegalVests = ["V_TacVest_gen_F"];

OT_clothes_locals = ["U_I_C_Soldier_Bandit_2_F","U_I_C_Soldier_Bandit_3_F","U_C_Poor_1","U_C_Poor_2","U_C_Poor_shorts_1","U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_redwhite","U_C_Poloshirt_stripped"];
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

//NATO stuff
OT_NATO_HMG = "B_HMG_01_high_F";
OT_NATO_Vehicles_AirGarrison = [
	["B_T_VTOL_01_vehicle_F",1],
	["B_T_VTOL_01_infantry_F",1],
	["B_Heli_Light_01_armed_F",1],
	["B_Heli_Transport_03_unarmed_F",2],
	["B_Heli_Light_01_F",3],
	["B_Heli_Attack_01_F",1],
	["B_Heli_Transport_01_F",2]
];

OT_NATO_Vehicles_StaticAAGarrison = [
	"B_T_static_AA_F",
	"B_T_static_AA_F"
]; //Added to every airfield

OT_NATO_Vehicles_JetGarrison = [
	["B_Plane_CAS_01_F",1]
];

if(OT_hasJetsDLC) then {
	OT_NATO_Vehicles_JetGarrison pushback ["B_Plane_Fighter_01_F",1];
	OT_NATO_Vehicles_JetGarrison pushback ["B_Plane_Fighter_01_Stealth_F",1];
	OT_NATO_Vehicles_StaticAAGarrison pushback "B_Radar_System_01_F";
	OT_NATO_Vehicles_StaticAAGarrison pushback "B_SAM_System_03_F";
};

OT_NATO_StaticGarrison_LevelOne = ["B_HMG_01_high_F"];
OT_NATO_StaticGarrison_LevelTwo = ["B_HMG_01_high_F","B_HMG_01_high_F","B_GMG_01_high_F","B_T_MRAP_01_hmg_F"];
OT_NATO_StaticGarrison_LevelThree = ["B_T_Static_AT_F","B_T_Static_AA_F","B_HMG_01_high_F","B_HMG_01_high_F","B_GMG_01_high_F","B_T_MRAP_01_hmg_F","B_T_MRAP_01_gmg_F"];

OT_NATO_CommTowers = ["Land_TTowerBig_1_F","Land_TTowerBig_2_F"];

OT_NATO_Unit_Sniper = "B_T_Sniper_F";
OT_NATO_Unit_Spotter = "B_T_Spotter_F";
OT_NATO_Unit_AA_spec = "B_T_Soldier_AA_F";
OT_NATO_Unit_AA_ass = "B_T_Soldier_AAA_F";
OT_NATO_Unit_HVT = "B_T_Officer_F";
OT_NATO_Unit_TeamLeader = "B_T_Soldier_TL_F";
OT_NATO_Unit_SquadLeader = "B_T_Soldier_SL_F";

OT_NATO_Unit_PoliceCommander = "B_Gen_Commander_F";
OT_NATO_Unit_Police = "B_Gen_Soldier_F";
OT_NATO_Vehicle_PoliceHeli = "B_Heli_Light_01_F";
OT_NATO_Vehicle_Quad = "B_Quadbike_01_F";
OT_NATO_Vehicle_Police = "B_GEN_Offroad_01_gen_F";
OT_NATO_Vehicle_Transport = ["B_T_Truck_01_transport_F","B_T_Truck_01_covered_F"];
OT_NATO_Vehicle_Transport_Light = "B_T_LSV_01_unarmed_F";
OT_NATO_Vehicles_PoliceSupport = ["B_T_MRAP_01_hmg_F","B_T_MRAP_01_gmg_F","B_T_LSV_01_armed_F","B_Heli_Light_01_armed_F"];
OT_NATO_Vehicles_ReconDrone = "B_UAV_01_F";
OT_NATO_Vehicles_CASDrone = "B_UAV_02_CAS_F";
OT_NATO_Vehicles_AirSupport = ["B_Heli_Attack_01_F"];
OT_NATO_Vehicles_AirSupport_Small = ["B_Heli_Light_01_armed_F"];
OT_NATO_Vehicles_GroundSupport = ["B_T_MRAP_01_gmg_F","B_T_MRAP_01_hmg_F","B_T_LSV_01_armed_F"];
OT_NATO_Vehicles_TankSupport = ["B_T_MBT_01_TUSK_F","B_T_MBT_01_cannon_F"];
OT_NATO_Vehicles_Convoy = ["B_T_UGV_01_rcws_olive_F","B_T_MRAP_01_hmg_F","B_T_LSV_01_armed_F","B_T_LSV_01_armed_F","B_T_LSV_01_armed_F"];
OT_NATO_Vehicles_AirWingedSupport = ["B_Plane_CAS_01_F"];
OT_NATO_Vehicle_AirTransport_Small = "B_Heli_Transport_01_camo_F";
OT_NATO_Vehicle_AirTransport = ["B_Heli_Transport_03_F","B_Heli_Transport_01_F","B_Heli_Transport_01_F"];
OT_NATO_Vehicle_AirTransport_Large = "B_Heli_Transport_03_F";
OT_NATO_Vehicle_Boat_Small = "B_T_Boat_Armed_01_minigun_F";
OT_NATO_Vehicles_APC = ["B_T_APC_Wheeled_01_cannon_F"];

OT_NATO_Sandbag_Curved = "Land_BagFence_01_round_green_F";
OT_NATO_Barrier_Small = "Land_HBarrier_01_line_5_green_F";
OT_NATO_Barrier_Large = "Land_HBarrier_01_wall_6_green_F";

OT_NATO_Mortar = "B_T_Mortar_01_F";

OT_NATO_Vehicle_HVT = "B_MRAP_01_F";

OT_NATO_Vehicle_CTRGTransport = "B_CTRG_Heli_Transport_01_tropic_F";

OT_NATO_weapons_Police = [];
OT_NATO_weapons_Pistols = ["hgun_Pistol_heavy_01_F","hgun_ACPC2_F","hgun_P07_F","hgun_Rook40_F"];

//Criminal stuff
OT_CRIM_Unit = "C_man_p_fugitive_F";
OT_CRIM_Clothes = ["U_I_C_Soldier_Bandit_3_F","U_BG_Guerilla3_1","U_C_HunterBody_grn","U_I_G_Story_Protagonist_F"];
OT_CRIM_Goggles = ["G_Balaclava_blk","G_Balaclava_combat","G_Balaclava_lowprofile","G_Balaclava_oli","G_Bandanna_blk","G_Bandanna_khk","G_Bandanna_oli","G_Bandanna_shades","G_Bandanna_sport","G_Bandanna_tan"];
OT_CRIM_Weapons = ["arifle_AK12_F","arifle_AKM_F","arifle_AKM_F","arifle_AKM_F"];
OT_CRIM_Pistols = ["hgun_Pistol_heavy_01_F","hgun_ACPC2_F","hgun_P07_F","hgun_Rook40_F"];
OT_CRIM_Launchers = ["launch_RPG32_F","launch_RPG7_F","launch_RPG7_F","launch_RPG7_F"];

OT_piers = ["Land_PierConcrete_01_4m_ladders_F","Land_PierWooden_01_platform_F","Land_PierWooden_01_hut_F","Land_PierWooden_02_hut_F"]; //spawns dudes that sell boats n stuff
OT_offices = ["Land_MultistoryBuilding_01_F","Land_MultistoryBuilding_04_F"];
OT_portBuildings = ["Land_Warehouse_01_F","Land_Warehouse_02_F","Land_ContainerLine_01_F","Land_ContainerLine_02_F","Land_ContainerLine_03_F"];
OT_airportTerminals = ["Land_Airport_01_terminal_F","Land_Airport_02_terminal_F","Land_Hangar_F"];
OT_portBuilding = "Land_Warehouse_02_F";
OT_policeStation = "Land_Cargo_House_V3_F";
OT_warehouse = "Land_Warehouse_03_F";
OT_warehouses = [OT_warehouse];
OT_barracks = "Land_Barracks_01_grey_F";
OT_workshopBuilding = "Land_Cargo_House_V4_F";
OT_refugeeCamp = "Land_Medevac_house_V1_F";
OT_trainingCamp = "Land_IRMaskingCover_02_F";
OT_hardwareStore = "Land_Shop_Town_02_F";
OT_radarBuilding = "Land_Radar_Small_F";
