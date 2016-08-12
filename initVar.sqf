//Here is where you can change stuff to suit your liking or support mods/another map

AIT_spawnBlacklist = ["Georgetown","Sosovu","Tuvanaka","Belfort","Nani","Saint-Julien","Ipota"]; //dont spawn in these towns

AIT_hasAce = false;
if (!isNil "ace_common_settingFeedbackIcons") then {
	AIT_hasAce = true;
};

AIT_spawnDistance = 1200;
AIT_spawnCivPercentage = 0.08;
AIT_spawnVehiclePercentage = 0.04;
AIT_standardMarkup = 0.2; //Markup in shops is calculated from this
AIT_randomSpawnTown = false; //if true, every player will start in a different town, if false, all players start in the same town (Multiplayer only)
AIT_distroThreshold = 500; //Size a towns order must be before a truck is sent (in dollars)

AIT_spawnTowns = ["Balavu","Rautake","Tavu","Yanukka","Tobakoro","Bua Bua","Saioko","Doodstil","Harcourt","Lijnhaven","Katkoula","Moddergat"]; //Towns where new players will spawn
AIT_spawnHouses = ["Land_Slum_01_F","Land_Slum_02_F","Land_House_Native_02_F"]; //Houses where new players will spawn 

AIT_NATOwait = 300; //Half the Average time between NATO orders
AIT_CRIMwait = 200; //Half the Average time between crim changes

AIT_civTypes_gunDealers = ["CUP_C_C_Profiteer_01","CUP_C_C_Profiteer_02","CUP_C_C_Profiteer_03","CUP_C_C_Profiteer_04"];
AIT_civTypes_locals = ["C_Man_casual_1_F_tanoan","C_Man_casual_2_F_tanoan","C_Man_casual_3_F_tanoan","C_man_sport_1_F_tanoan","C_man_sport_2_F_tanoan","C_man_sport_3_F_tanoan","C_Man_casual_4_F_tanoan","C_Man_casual_5_F_tanoan","C_Man_casual_6_F_tanoan"];
AIT_civTypes_expats = ["CUP_C_C_Citizen_02","CUP_C_C_Citizen_01","CUP_C_C_Citizen_04","CUP_C_C_Citizen_03","CUP_C_C_Rocker_01","CUP_C_C_Rocker_03","CUP_C_C_Rocker_02","CUP_C_C_Rocker_04","C_man_p_beggar_F","C_man_1","C_Man_casual_1_F","C_Man_casual_2_F","C_Man_casual_3_F","C_man_sport_1_F","C_man_sport_2_F","C_man_sport_3_F","C_Man_casual_4_F","C_Man_casual_5_F","C_Man_casual_6_F","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_man_shorts_1_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_p_beggar_F_asia","C_Man_casual_1_F_asia","C_Man_casual_2_F_asia","C_Man_casual_3_F_asia","C_man_sport_1_F_asia","C_man_sport_2_F_asia","C_man_sport_3_F_asia","C_Man_casual_4_F_asia","C_Man_casual_5_F_asia","C_Man_casual_6_F_asia","C_man_polo_1_F_asia","C_man_polo_2_F_asia","C_man_polo_3_F_asia","C_man_polo_4_F_asia","C_man_polo_5_F_asia","C_man_polo_6_F_asia","C_man_shorts_1_F_asia"];
AIT_civTypes_tourists = ["C_man_shorts_2_F","C_man_shorts_3_F","C_man_shorts_4_F","C_man_shorts_2_F_afro","C_man_shorts_3_F_afro","C_man_shorts_4_F_afro","C_man_shorts_2_F_asia","C_man_shorts_3_F_asia","C_man_shorts_4_F_asia","C_man_shorts_2_F_euro","C_man_shorts_3_F_euro","C_man_shorts_4_F_euro"];
AIT_civType_worker = "C_man_w_worker_F";
AIT_vehTypes_civ = ["CUP_C_Skoda_Blue_CIV","CUP_C_Skoda_Green_CIV","CUP_C_Skoda_Red_CIV","CUP_C_Skoda_White_CIV","CUP_C_Datsun","CUP_C_Datsun_4seat","CUP_C_Datsun_Covered","CUP_C_Datsun_Plain","CUP_C_Datsun_Tubeframe","CUP_C_LR_Transport_CTK"];
AIT_vehType_distro = "C_Van_01_box_F";

//Shop items
AIT_item_ShopRegister = "Land_CashDesk_F";//Cash registers
AIT_item_BasicGun = "hgun_P07_F";//Player starts with this weapon in their ammobox
AIT_item_BasicAmmo = "16Rnd_9x21_Mag";

if(AIT_hasAce) then {
	AIT_consumableItems = ["ACE_fieldDressing","ACE_Sandbag_empty"]; //Shops will try to stock more of these
}else{
	AIT_consumableItems = ["FirstAidKit","Medikit"];
};
AIT_illegalHeadgear = ["H_MilCap_gen_F","H_Beret_gen_F"];
AIT_illegalVests = ["V_TacVest_gen_F"];

if(AIT_hasAce) then {
	AIT_illegalItems = ["ACE_morphine","ACE_epinephrine","ACE_adenosine"];
}else{
	AIT_illegalItems = [];
};

//Player items
AIT_item_Main = "Land_Laptop_unfolded_F"; //object for main interactions at owned houses
AIT_item_Secondary = "Land_PortableLongRangeRadio_F"; //object for secondary interactions at owned houses (not used yet, may be a mid game thing)
AIT_items_Sleep = ["CUP_vojenska_palanda"]; //Items with the "sleep" interaction (Single player only)
AIT_items_Heal = ["Land_WaterCooler_01_old_F"]; //Where the player can heal themselves
AIT_items_Repair = ["Toolkit"]; //Inventory items that can be used to repair vehicles

//Interactable items that spawn in your house
AIT_item_Storage = "B_CargoNet_01_ammo_F"; //Your spawn ammobox
AIT_item_Desk = "OfficeTable_01_new_F"; //Your spawn desk
AIT_item_Radio = "Land_PortableLongRangeRadio_F";
AIT_item_Map = "Land_MapBoard_F";
AIT_item_Repair = "Land_ToolTrolley_02_F";

AIT_items_distroStorage = ["CargoNet_01_box_F"]; //Where distribution centers store inventory
AIT_items_Simulate = ["Box_NATO_Equip_F","Box_T_East_Wps_F","B_CargoNet_01_ammo_F","OfficeTable_01_old_F","Land_PortableLongRangeRadio_F"]; //These will be saved, position + inventory and have gravity

AIT_staticMachineGuns = ["B_HMG_01_high_F"];

AIT_clothes_locals = ["CUP_U_I_GUE_Anorak_01","CUP_U_I_GUE_Anorak_02","CUP_U_I_GUE_Anorak_03","U_I_C_Soldier_Bandit_2_F","U_I_C_Soldier_Bandit_3_F","U_C_Poor_1"];
AIT_clothes_expats = ["U_I_C_Soldier_Bandit_5_F","U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_redwhite","U_C_Poloshirt_salmon","U_C_Poloshirt_stripped","U_C_Man_casual_6_F","U_C_Man_casual_4_F","U_C_Man_casual_5_F"];
AIT_clothes_tourists = [];
AIT_clothes_port = "U_Marshal";
AIT_clothes_shops = ["U_C_Man_casual_2_F","U_C_Man_casual_3_F","U_C_Man_casual_1_F"];
AIT_clothes_carDealers = ["CUP_U_C_Mechanic_01","CUP_U_C_Mechanic_02","CUP_U_C_Mechanic_03"];
AIT_clothes_guerilla = ["U_I_C_Soldier_Para_1_F","U_I_C_Soldier_Para_2_F","U_I_C_Soldier_Para_3_F","U_I_C_Soldier_Para_5_F","U_I_C_Soldier_Para_4_F"];

//NATO stuff
AIT_NATOregion = "island_5"; //where NATO lives
AIT_NATOwhitelist = ["Comms Alpha","Comms Bravo","Comms Whiskey","port","fuel depot","railway depot"]; //NameLocal/Airport place names to definitely occupy with military personnel
AIT_NATO_priority = ["Tuvanaka Airbase","Comms Alpha","Blue Pearl industrial port","Nani","Belfort","Tuvanaka"];
AIT_NATO_control = ["control_1","control_2","control_3","control_4","control_5","control_6","control_7","control_8","control_9","control_10","control_11","control_12","control_13","control_14","control_15","control_16","control_17"]; //NATO checkpoints, create markers in editor
AIT_NATO_HQ = "Tuvanaka Airbase";
AIT_NATO_AirSpawn = "NATO_airspawn";
AIT_NATO_HQPos = [0,0,0];//Dont worry this gets populated later

AIT_NATO_Unit_PoliceCommander = "B_Gen_Commander_F";
AIT_NATO_Unit_Police = "B_Gen_Soldier_F";
AIT_NATO_Vehicle_PoliceHeli = "B_Heli_Light_01_F";
AIT_NATO_Vehicle_Quad = "B_Quadbike_01_F";
AIT_NATO_Vehicle_Police = "B_GEN_Offroad_01_gen_F";
AIT_NATO_Vehicle_Transport = "B_T_Truck_01_transport_F";
AIT_NATO_Vehicles_PoliceSupport = ["B_T_MRAP_01_hmg_F","B_T_MRAP_01_gmg_F","B_T_LSV_01_armed_F","B_Heli_Light_01_armed_F"];
AIT_NATO_Vehicles_AirDrones = ["B_UAV_02_F"];
AIT_NATO_Vehicles_AirSupport = ["B_Heli_Light_01_armed_F","B_Heli_Light_01_armed_F"];
AIT_NATO_Vehicles_AirWingedSupport = ["B_Plane_CAS_01_F"];
AIT_NATO_Vehicle_AirTransport = "B_Heli_Transport_03_F";

AIT_NATO_Unit_PoliceHeliPilot = "B_T_HeliPilot_F";
AIT_NATO_Unit_PoliceHeliCoPilot = "B_T_Helicrew_F";
AIT_NATO_Unit_LevelOneLeader = "B_T_Soldier_TL_F";
AIT_NATO_Units_LevelOne = ["B_T_Medic_F","B_T_Soldier_F","B_T_Soldier_LAT_F","B_T_Soldier_AAT_F","B_T_Soldier_AT_F","B_T_soldier_M_F","B_T_Soldier_GL_F","B_T_Soldier_AR_F"];
AIT_NATO_Units_LevelTwo = AIT_NATO_Units_LevelOne + ["B_T_Soldier_AA_F","B_T_Soldier_AAR_F","B_T_Soldier_AAA_F","B_T_Sniper_F","B_T_Spotter_F"];

AIT_NATO_weapons_Police = ["SMG_01_F","SMG_02_F","arifle_Mk20_plain_F","arifle_Mk20C_plain_F","arifle_MX_Black_F","arifle_Katiba_F","srifle_EBR_F","srifle_DMR_01_F"];
AIT_NATO_weapons_Pistols = ["hgun_Pistol_heavy_01_F","hgun_ACPC2_F","hgun_P07_F","hgun_Rook40_F"];



//Criminal stuff
AIT_CRIM_Units_Bandit = ["I_C_Soldier_Bandit_1_F","I_C_Soldier_Bandit_2_F","I_C_Soldier_Bandit_3_F","I_C_Soldier_Bandit_4_F","I_C_Soldier_Bandit_5_F","I_C_Soldier_Bandit_6_F","I_C_Soldier_Bandit_7_F","I_C_Soldier_Bandit_8_F"];
AIT_CRIM_Units_Para = ["I_C_Soldier_Para_1_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_6_F","I_C_Soldier_Para_7_F","I_C_Soldier_Para_8_F"];
AIT_vehTypes_crim = ["I_G_Offroad_01_F","I_C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_F","C_Offroad_01_F","I_C_Offroad_02_unarmed_F","I_C_Offroad_02_unarmed_F","I_C_Offroad_02_unarmed_F"];

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
		["ACE_fieldDressing",10,0,0,0.1],
		["ACE_elasticBandage",15,0,0,0.2],
		["ACE_SpraypaintBlue",20,0,0,0.2],
		["ACE_SpraypaintRed",20,0,0,0.2],
		["ACE_SpraypaintBlack",20,0,0,0.2],
		["ACE_morphine",50,0,0,0.2],
		["ACE_EarPlugs",5,0,0,0.2],
		["ACE_epinephrine",50,0,0,0.2],
		["ACE_adenosine",50,0,0,0.2],
		["ACE_Sandbag_empty",1,0,0,0],
		["ACE_Altimeter",110,0,0,1]		
	]] call BIS_fnc_arrayPushStack;
}else{
	[AIT_items,[
		["FirstAidKit",10,0,0,0.1],
		["Medikit",40,0,0,0.5]
	]] call BIS_fnc_arrayPushStack;
};

[AIT_items,[
	["ToolKit",25,1,0,0],
	["ItemGPS",90,0,0,1],
	["ItemCompass",5,0.1,0,0],
	["ItemMap",1,0,0,0],
	["ItemWatch",50,0,0,1],
	["Binocular",120,0,0,1],
	["Rangefinder",280,0,0,1],
	["Laserdesignator",500,1,0,0],
	["NVGoggles",700,1,0,0],
	["NVGoggles_OPFOR",700,1,0,0],
	["ItemRadio",60,0,0,1]
]] call BIS_fnc_arrayPushStack;

AIT_backpacks = [
	["B_AssaultPack_cbr",50,0,0,1],
	["B_AssaultPack_blk",50,0,0,1],
	["B_AssaultPack_khk",50,0,0,1],
	["B_AssaultPack_sgg",50,0,0,1],
	["B_FieldPack_cbr",70,0,0,1],
	["B_FieldPack_blk",70,0,0,1],
	["B_FieldPack_khk",70,0,0,1],
	["B_FieldPack_oli",70,0,0,1],
	["B_Kitbag_cbr",85,0,0,1],
	["B_Kitbag_sgg",85,0,0,1],
	["B_Carryall_cbr",100,0,0,1],
	["B_Carryall_khk",100,0,0,1],
	["B_Carryall_oli",100,0,0,1],
	["B_Bergen_dgtl_F",150,0,0,1],
	["B_Bergen_hex_F",150,0,0,1]
];
AIT_weapons = [
	["hgun_Pistol_heavy_01_F",40,1,0,0],
	["hgun_ACPC2_F",60,1,0,0],
	["hgun_P07_F",100,1,0,0],
	["hgun_Rook40_F",110,1,0,0],
	["hgun_PDW2000_F",210,1,0,0],
	["SMG_02_F",250,1,0,0],
	["SMG_01_F",290,1,0,0],
	["arifle_Mk20_plain_F",400,1,0,0],
	["arifle_Mk20_GL_plain_F",520,1,0,0],
	["arifle_Mk20C_plain_F",560,1,0,0],
	["arifle_MX_Black_F",760,1,0,0],
	["arifle_Katiba_F",780,1,0,0],
	["arifle_Katiba_GL_F",980,1,0,0],
	["srifle_EBR_F",900,1,0,0],
	["srifle_DMR_01_F",1000,1,0,0],
	["LMG_Mk200_F",1100,1,0,0],
	["srifle_GM6_F",1300,1,0,0]
];
AIT_vehicles = [
	["CUP_C_Skoda_Blue_CIV",50,1,1,1],
	["CUP_C_Skoda_Green_CIV",60,1,1,1],
	["CUP_C_Skoda_Red_CIV",60,1,1,1],
	["CUP_C_Skoda_White_CIV",60,1,1,1],
	["CUP_C_Datsun",100,1,1,1],
	["CUP_C_Datsun_Covered",100,1,1,1],
	["C_Quadbike_01_F",200,1,1,1],
	["CUP_C_Golf4_black_Civ",400,1,1,1],
	["CUP_C_Golf4_blue_Civ",400,1,1,1],
	["CUP_C_Golf4_green_Civ",400,1,1,1],
	["CUP_C_Golf4_white_Civ",400,1,1,1],
	["CUP_C_Golf4_yellow_Civ",400,1,1,1],
	["CUP_C_Octavia_CIV",500,1,1,1],
	["C_SUV_01_F",600,1,1,1],
	["C_Offroad_01_F",700,1,1,1],
	["C_Offroad_02_unarmed_F",800,1,1,1],
	["C_Van_01_transport_F",1000,1,1,1],
	["C_Van_01_box_F",1000,1,1,1],
	["C_Truck_02_transport_F",1500,1,1,1],
	["C_Truck_02_covered_F",1500,1,1,1],
	["C_Truck_02_fuel_F",2000,1,1,1],
	["C_Truck_02_box_F",2500,1,1,1]
];

AIT_allVehicles = [];
AIT_allItems = [];
AIT_allWeapons = [];
AIT_allMagazines = [];
AIT_allBackpacks = [];

cost setVariable ["CIV",[50,0,0,0],true];

//populate the cost gamelogic with the above data so it can be accessed quickly
{
	cost setVariable [_x select 0,[_x select 1,_x select 2,_x select 3,_x select 4],true];
	AIT_allItems pushBack (_x select 0);
}foreach(AIT_items);
{
	cost setVariable [_x select 0,[_x select 1,_x select 2,_x select 3,_x select 4],true];
	AIT_allBackpacks pushBack (_x select 0);
}foreach(AIT_backpacks);
{
	cost setVariable [_x select 0,[_x select 1,_x select 2,_x select 3,_x select 4],true];
	AIT_allVehicles pushBack (_x select 0);
}foreach(AIT_vehicles);

{
	cost setVariable [_x select 0,[_x select 1,_x select 2,_x select 3,_x select 4],true];
	AIT_allWeapons pushBack (_x select 0);
	
	_base = [_x select 0] call BIS_fnc_baseWeapon;
	_magazines = getArray (configFile / "CfgWeapons" / _base / "magazines");
	{
		AIT_allMagazines pushBack _x;
	}foreach(_magazines);
}foreach(AIT_weapons);

publicVariable "AIT_allVehicles";
publicVariable "AIT_allItems";
publicVariable "AIT_allWeapons";
publicVariable "AIT_allMagazines";
publicVariable "AIT_allBackpacks";

AIT_regions = ["island_1","island_2","island_3","island_4","island_5","island_6","island_7"]; //for both economic and travel purposes. define rectangles in eden
AIT_capitals = ["Georgetown","Lijnhaven","Katkoula","Balavu","Tuvanaka","Sosovu","Ipota"]; //region capitals
AIT_sprawling = ["Blue Pearl industrial port"];

AIT_mansions = ["Land_House_Big_02_F","Land_House_Big_03_F","Land_House_Small_04_F"]; //buildings that rich guys like to live in

AIT_gunDealerHouses = ["Land_Slum_01_F","Land_Slum_02_F","Land_House_Big_02_F","Land_House_Small_03_F","Land_House_Small_06_F","Land_GarageShelter_01_F","Land_House_Small_05_F","Land_House_Native_02_F"];//houses where gun dealers will spawn

AIT_crimHouses = AIT_spawnHouses + AIT_gunDealerHouses + AIT_mansions;

AIT_lowPopHouses = ["Land_House_Native_02_F","Land_House_Small_06_F","Land_House_Small_02_F","Land_House_Small_03_F","Land_Slum_01_F","Land_Slum_02_F","Land_GarageShelter_01_F","Land_Slum_04_F"]; //buildings with just 1-4 people living in them (also player start houses)
AIT_medPopHouses = ["Land_House_Native_01_F","Land_House_Big_01_F","Land_Slum_05_F","Land_House_Small_01_F","Land_Slum_03_F","Land_Slum_04_F","Land_House_Small_05_F","Land_Addon_04_F"]; //buildings with 5-10 people living in them
AIT_highPopHouses = ["Land_House_Big_04_F","Land_Warehouse_01_F"]; //buildings with up to 20 (the warehouses are because ports end up with low pop)
AIT_hugePopHouses = ["Land_MultistoryBuilding_03_F"]; //buildings with potentially lots of people living in them
AIT_touristHouses = ["Land_House_Big_05_F"]; //hostels and the like
AIT_allShops = ["Land_Shop_Town_01_F","Land_Shop_Town_02_F","Land_Shop_Town_03_F","Land_Shop_Town_04_F","Land_Shop_Town_05_F","Land_Shop_City_01_F","Land_Shop_City_02_F","Land_Shop_City_03_F","Land_Shop_City_04_F","Land_Shop_City_05_F","Land_Shop_City_06_F","Land_Shop_City_07_F"]; //used to calculate civ spawn positions and initial stability
AIT_markets = []; //buildings/objects that will spawn local markets (no templates required)
AIT_shops = ["Land_Shop_Town_01_F","Land_Shop_Town_03_F","Land_Shop_City_02_F","Land_Supermarket_01_F"]; //buildings that will spawn the main shops (must have a template with a cash register)
AIT_warehouses = ["Land_Warehouse_03_F"]; //buildings that will spawn local distribution centers
AIT_carShops = ["Land_FuelStation_01_workshop_F","Land_FuelStation_02_workshop_F"]; //buildings that will spawn car salesmen (must have a template with a cash register)
AIT_offices = ["Land_MultistoryBuilding_01_F","Land_MultistoryBuilding_04_F"]; 
AIT_portBuildings = ["Land_Warehouse_01_F","Land_Warehouse_02_F","Land_ContainerLine_01_F","Land_ContainerLine_02_F","Land_ContainerLine_03_F"];

AIT_allBuyableBuildings = AIT_lowPopHouses + AIT_medPopHouses;
publicVariable "AIT_allBuyableBuildings";

AIT_allHouses = AIT_lowPopHouses + AIT_medPopHouses + AIT_highPopHouses + AIT_hugePopHouses + AIT_touristHouses;
AIT_allEnterableHouses = ["Land_House_Small_02_F","Land_House_Big_02_F","Land_House_Small_03_F","Land_House_Small_06_F","Land_House_Big_01_F","Land_Slum_05_F","Land_Slum_01_F","Land_GarageShelter_01_F","Land_House_Small_01_F","Land_Slum_03_F","Land_House_Big_04_F","Land_House_Small_04_F","Land_House_Small_05_F"];

AIT_activeShops = [];
AIT_activeCarShops = [];
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
}foreach (nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["NameCityCapital","NameCity","NameVillage","CityCenter"], 50000]);

AIT_varInitDone = true;
publicVariable "AIT_varInitDone";