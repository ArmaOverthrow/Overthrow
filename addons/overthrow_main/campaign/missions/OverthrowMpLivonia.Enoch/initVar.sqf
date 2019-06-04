
OT_nation = "Livonia";
OT_saveName = "Overthrow.Livonia.save.001";

OT_tutorial_backstoryText = "TBC";
OT_startDate = [2025,7,27,8,00];

OT_startCameraPos = [9530.23,1138.76,5];
OT_startCameraTarget = [9154.2,987.363,50];

//Used to control updates and persistent save compatability. When these numbers go up, that section will be reinitialized on load if required. (ie leave them alone)
OT_economyVersion = 1;
OT_NATOversion = 1;
OT_CRIMversion = 1;

OT_faction_NATO = "BLU_T_F";
OT_spawnFaction = "IND_F"; //This faction will have a rep in spawn town

OT_flag_NATO = "Flag_NATO_F";
OT_flag_CRIM = "Flag_Syndikat_F";
OT_flag_IND = "Flag_HorizonIslands_F";
OT_flagImage = "\A3\ui_f\data\map\markers\flags\Tanoa_ca.paa";
OT_flagMarker = "flag_Tanoa";

OT_populationMultiplier = 0.8; //Used to tweak populations per map

//Building templates
//To generate these templates:
//1. Open Arma editor, choose VR map
//2. Add the building you want to make a template for, set its location and rotation to 0,0,0
//3. Add furniture objects
//4. Add a player (any unit), Play the Scenario
//5. Run this in console: [getPos player, 50, true] call BIS_fnc_ObjectsGrabber
//6. Copy the results, paste them here and remove any extraneous items (ie the building, Logic, babe_helper, Signs)

OT_shopBuildings = [
	["Land_VillageStore_01_F",[]],
	["Land_Workshop_03_F",[]],
	["Land_FuelStation_03_shop_F",[]]
];
OT_carShopBuildings = [
	["Land_FuelStation_Build_F",[]],
	["Land_FuelStation_02_workshop_F",[]]
];
OT_spawnHouseBuildings = [
	["Land_House_1W01_F",[
		["Land_MetalCase_01_small_F",[-0.0391073,-2.38339,-0.00100088],269.766,1,0,[2.80922e-005,-0.000455107],"","",true,false],
		["Land_CampingChair_V2_F",[-0.95352,2.19191,-0.000998974],205.312,1,0,[0.000419523,0.00036544],"","",true,false],
		["OfficeTable_01_new_F",[-0.669114,2.76221,-0.000998974],3.3096e-005,1,0,[-6.48772e-005,0.000181224],"","",true,false],
		["MapBoard_altis_F",[2.80548,0.361253,-0.00155544],86.6927,1,0,[-0.294008,-0.0546504],"","",true,false],
		["B_CargoNet_01_ammo_F",[2.65323,-1.62338,-0.00099659],360,1,0,[-0.000187827,0.000360995],"","",true,false],
		["Land_Workbench_01_F",[2.20189,2.67528,-0.000597],359.805,1,0,[0.103474,-0.00103475],"","",true,false]
	]],
	["Land_House_1W10_F",[
		["Land_CampingChair_V2_F",[0.920077,-0.901972,0.034317],24.7907,1,0,[-0.124043,0.271041],"","",true,false],
		["OfficeTable_01_new_F",[0.640592,-1.47487,0.0357647],179.487,1,0,[-0.00276878,-0.297944],"","",true,false],
		["Land_MetalCase_01_small_F",[1.14552,1.94735,0.0331335],92.3128,1,0,[-0.297861,-0.0119579],"","",true,false],
		["Land_Workbench_01_F",[-2.52448,-1.38322,0.0522304],180.992,1,0,[0.0054578,-0.297945],"","",true,false],
		["B_CargoNet_01_ammo_F",[-3.02816,1.29547,0.0548558],179.482,1,0,[-0.00272333,-0.298135],"","",true,false],
		["MapBoard_altis_F",[3.00379,-1.43205,0.061625],134.089,1,0,[0.654025,0.845397],"","",true,false]
	]],
	["Land_House_1W02_F",[
		["Land_MetalCase_01_small_F",[-0.538328,0.901626,-0.0010004],174.741,1,0,[-9.37514e-005,9.29899e-005],"","",true,false],
		["Land_CampingChair_V2_F",[2.85857,-0.415011,-0.000994682],292.015,1,0,[-0.00038614,-0.00123639],"","",true,false],
		["OfficeTable_01_new_F",[3.44428,-0.666138,-0.000999928],86.7032,1,0,[0.000145824,6.21702e-005],"","",true,false],
		["MapBoard_altis_F",[-1.49216,3.31236,0.0428715],355.179,1,0,[-0.360939,0.0461294],"","",true,false],
		["B_CargoNet_01_ammo_F",[2.64869,3.16984,-0.0010004],179.483,1,0,[-0.000110829,1.88703e-005],"","",true,false],
		["Land_Workbench_01_F",[-4.55341,1.23832,-0.00100088],269.89,1,0,[0.00126416,2.55769e-005],"","",true,false]
	]]
];

//Interactable items that spawn in your house
OT_item_Storage = "B_CargoNet_01_ammo_F"; //Your spawn ammobox
OT_item_Desk = "OfficeTable_01_new_F"; //Your spawn desk
OT_item_Radio = "Land_PortableLongRangeRadio_F";
OT_item_Map = "Land_MapBoard_Enoch_F";
OT_item_Tent = "Land_TentDome_F";
OT_item_Safe = "Land_MetalCase_01_small_F";
OT_item_Workbench = "Land_Workbench_01_F";

//Animals to spawn (@todo: spawn animals)
OT_allLowAnimals = ["Rabbit_F","Turtle_F"];
OT_allHighAnimals = ["Goat_random_F"];
OT_allFarmAnimals = ["Hen_random_F","Cock_random_F","Sheep_random_F"];
OT_allVillageAnimals = ["Hen_random_F","Cock_random_F"];
OT_allTownAnimals = ["Alsatian_Random_F","Fin_random_F"];

OT_fuelPumps = ["Land_FuelStation_03_pump_F","Land_FuelStation_Feed_F"];

OT_churches = ["Land_Church_03_F","Land_Church_01_F","Land_Church_02_F","Land_Temple_Native_01_F"];

OT_language_local = "LanguageENG_F";
OT_identity_local = "Head_Euro";

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
OT_NATO_Vehicle_Transport_Light = "B_LSV_01_unarmed_F";
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

OT_piers = []; //spawns dudes that sell boats n stuff
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
OT_hardwareStore = "Land_Workshop_05_F";
OT_radarBuilding = "Land_Radar_Small_F";
