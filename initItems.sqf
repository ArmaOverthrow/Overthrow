//Item table

AIT_legalItems = ["FirstAidKit","Medikit","Toolkit","ItemGPS","ItemCompass","ItemMap","ItemWatch","Binocular","Rangefinder","ItemRadio"]; //Anyone can create/buy/sell/carry these without NATO getting pissed off, all other items including mod items are considered illegal
AIT_consumableItems = ["FirstAidKit","Medikit","Toolkit"]; //Shops will try to stock more of these
publicVariable "AIT_legalItems";

//Player items
AIT_item_Main = "Land_Laptop_unfolded_F"; //object for main interactions at owned houses
AIT_item_Secondary = "Land_PortableLongRangeRadio_F"; //object for secondary interactions at owned houses (not used yet, may be a mid game thing)
AIT_items_Sleep = ["CUP_vojenska_palanda"]; //Items with the "sleep" interaction (Single player only)
AIT_items_Heal = ["Land_WaterCooler_01_old_F"]; //Where the player can heal themselves
AIT_items_Repair = ["Toolkit"]; //Inventory items that can be used to repair vehicles
AIT_items_Storage = ["B_CargoNet_01_ammo_F"]; //Where gun dealers will deliver your shit
AIT_items_Simulate = ["Box_NATO_Equip_F","Box_T_East_Wps_F","B_CargoNet_01_ammo_F","OfficeTable_01_old_F","Land_PortableLongRangeRadio_F"]; //These will be saved, position + inventory and have gravity

//Shop items
AIT_item_ShopRegister = "Land_CashDesk_F";//Cash registers
AIT_item_BasicGun = "hgun_Pistol_heavy_01_F";//All dealers will stock this close to cost price to ensure starting players can afford a weapon


//This is the prices table, shops will only stock these items, any others must be imported or produced and will have their costs generated automatically
//Format ["Cfg class",Base price,Steel,Wood,Plastics]

//The price of an item in a shop will be the base price + local markup (taking into account stability and player rep)
//The cost to produce an item will be the Base price - player/factory bonuses + raw materials
//The wholesale sell price of an item will be the base price - local markup
//NB: the local markup can be negative, making buy prices lower and sell prices higher, in certain situations (high stability and/or player rep)
AIT_items = [
	["FirstAidKit",10,0,0,0.1],
	["Medikit",40,0,0,0.5],
	["ToolKit",25,1,0,0],
	["ItemGPS",90,0,0,1],
	["ItemCompass",5,0.1,0,0],
	["ItemMap",1,0,0,0],
	["ItemWatch",50,0,0,1],
	["Binocular",120,0,0,1],
	["Rangefinder",280,0,0,1],
	["Laserdesignator",500,1,0,0],
	["NVGoggles",700,1,0,0],
	["ItemRadio",60,0,0,1]	
];

AIT_weapons = [
	["hgun_Pistol_heavy_01_F",80,1,0,0],
	["hgun_ACPC2_F",100,1,0,0],
	["hgun_P07_F",120,1,0,0],
	["hgun_Rook40_F",110,1,0,0],
	["hgun_PDW2000_F",410,1,0,0],
	["SMG_02_F",450,1,0,0],
	["SMG_01_F",390,1,0,0],
	["arifle_Mk20_plain_F",800,1,0,0],
	["arifle_Mk20_GL_plain_F",1520,1,0,0],
	["arifle_Mk20C_plain_F",730,1,0,0]
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

//populate the cost gamelogic
{
	cost setVariable [_x select 0,[_x select 1,_x select 2,_x select 3,_x select 4],true];
	AIT_allItems pushBack (_x select 0);
}foreach(AIT_items);

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

AIT_itemInitDone = true;
publicVariable "AIT_itemInitDone";
