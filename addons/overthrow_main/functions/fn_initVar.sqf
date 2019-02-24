//VCOM AI, huge credits to Genesis, without VCOM this campaign would be so much less

[] call OT_fnc_initVCOMAI;

[] execVM "\ot\functions\geography\SHK_pos\shk_pos_init.sqf";

OT_ACEremoveAction = ["OT_Remove","Remove","",{deleteVehicle _target;},{(call OT_fnc_playerIsGeneral) or (_target call OT_fnc_playerIsOwner)},{},[], [0,0,0], 10] call ace_interact_menu_fnc_createAction;

//Find markers
OT_ferryDestinations = [];
OT_NATO_control = [];
OT_regions = [];
{
	if((_x select [0,12]) isEqualTo "destination_") then {OT_ferryDestinations pushback _x};
	if((_x select [0,8]) isEqualTo "control_") then {OT_NATO_control pushback _x};
	if((_x select [0,7]) isEqualTo "island_") then {OT_regions pushback _x};
	if((_x select [0,7]) isEqualTo "region_") then {OT_regions pushback _x};
}foreach(allMapMarkers);

OT_missions = [];
OT_localMissions = [];
private _allMissions = "true" configClasses ( configFile >> "CfgOverthrowMissions" );
{
	_name = configName _x;
	_script = getText (_x >> "script");
	_code = compileFinal preprocessFileLineNumbers _script;
	OT_missions pushback _code;
}foreach(_allMissions);

OT_tutorialMissions = [];
OT_tutorialMissions pushback (compileFinal preprocessFileLineNumbers "\ot\missions\tutorial\tut_NATO.sqf");
OT_tutorialMissions pushback (compileFinal preprocessFileLineNumbers "\ot\missions\tutorial\tut_CRIM.sqf");
OT_tutorialMissions pushback (compileFinal preprocessFileLineNumbers "\ot\missions\tutorial\tut_Drugs.sqf");
OT_tutorialMissions pushback (compileFinal preprocessFileLineNumbers "\ot\missions\tutorial\tut_Economy.sqf");

call compileFinal preprocessFileLineNumbers "data\names.sqf";
call compileFinal preprocessFileLineNumbers "data\towns.sqf";
call compileFinal preprocessFileLineNumbers "data\airports.sqf";
call compileFinal preprocessFileLineNumbers "data\objectives.sqf";
call compileFinal preprocessFileLineNumbers "data\economy.sqf";
call compileFinal preprocessFileLineNumbers "data\comms.sqf";

//Identity
OT_faces_local = [];
OT_faces_western = [];
OT_faces_eastern = [];
{
    _types = getArray(_x >> "identityTypes");
	if(OT_identity_local in _types) then {OT_faces_local pushback configName _x};
	if(OT_identity_western in _types) then {OT_faces_western pushback configName _x};
	if(OT_identity_eastern in _types) then {OT_faces_eastern pushback configName _x};
}foreach("getNumber(_x >> 'disabled') isEqualTo 0" configClasses (configfile >> "CfgFaces" >> "Man_A3"));

OT_voices_local = [];
OT_voices_western = [];
OT_voices_eastern = [];
{
    _types = getArray(_x >> "identityTypes");
	if(OT_language_local in _types) then {OT_voices_local pushback configName _x};
	if(OT_language_western in _types) then {OT_voices_western pushback configName _x};
	if(OT_language_eastern in _types) then {OT_voices_eastern pushback configName _x};
}foreach("getNumber(_x >> 'scope') isEqualTo 2" configClasses (configfile >> "CfgVoice"));

//Find houses
OT_hugePopHouses = ["Land_MultistoryBuilding_01_F","Land_MultistoryBuilding_03_F","Land_MultistoryBuilding_04_F"]; //buildings with potentially lots of people living in them
OT_mansions = ["Land_House_Big_02_F","Land_House_Big_03_F","Land_Hotel_01_F","Land_Hotel_02_F"]; //buildings that rich guys like to live in
OT_lowPopHouses = [];
OT_medPopHouses = [];
OT_highPopHouses = [];
{
    _cost = getNumber(_x >> "cost");
    call {
        if(_cost > 70000) then {OT_hugePopHouses pushback configName _x};
        if(_cost > 55000) then {OT_highPopHouses pushback configName _x};
        if(_cost > 25000) then {OT_medPopHouses pushback configName _x};
        OT_lowPopHouses pushback configName _x
    };
}foreach("(getNumber (_x >> 'scope') isEqualTo 2) && (configName _x isKindOf 'House') && (configName _x find '_House' > -1)" configClasses (configfile >> "CfgVehicles"));

OT_allBuyableBuildings = OT_lowPopHouses + OT_medPopHouses + OT_highPopHouses + OT_hugePopHouses + OT_mansions + [OT_item_Tent,OT_flag_IND];

OT_allHouses = OT_lowPopHouses + OT_medPopHouses + OT_highPopHouses + OT_hugePopHouses;
OT_allRealEstate = OT_lowPopHouses + OT_medPopHouses + OT_highPopHouses + OT_hugePopHouses + OT_mansions + [OT_warehouse,OT_policeStation,OT_barracks,OT_barracks,OT_workshopBuilding,OT_refugeeCamp,OT_trainingCamp];

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

//Global overthrow variables related to any map

OT_menuHandler = {};
OT_currentMissionFaction = "";
OT_rankXP = [100,250,500,1000,4000,10000,100000];

OT_adminMode = false;
OT_deepDebug = false;
OT_hasAce = true;
OT_allIntel = [];
OT_notifies = [];

OT_NATO_HQPos = [0,0,0];

OT_fastTime = true; //When true, 1 day will last 6 hrs real time
OT_spawnDistance = 1200;
OT_spawnCivPercentage = 0.1;
OT_spawnVehiclePercentage = 0.04;
OT_standardMarkup = 0.2; //Markup in shops is calculated from this
OT_randomSpawnTown = false; //if true, every player will start in a different town, if false, all players start in the same town (Multiplayer only)
OT_distroThreshold = 500; //Size a towns order must be before a truck is sent (in dollars)
OT_saving = false;
OT_activeShops = [];
OT_selling = false;
OT_taking = false;
OT_interactingWith = objNull;

OT_garrisonBuildings = ["Land_Cargo_Patrol_V1_F","Land_Cargo_Patrol_V2_F","Land_Cargo_Patrol_V3_F","Land_Cargo_Patrol_V4_F","Land_Cargo_HQ_V1_F","Land_Cargo_HQ_V2_F","Land_Cargo_HQ_V3_F","Land_Cargo_HQ_V4_F","Land_Cargo_Tower_V1_F","Land_Cargo_Tower_V2_F","Land_Cargo_Tower_V3_F","Land_Cargo_Tower_V4_F","Land_Cargo_Tower_V1_No1_F","Land_Cargo_Tower_V1_No2_F","Land_Cargo_Tower_V1_No3_F","Land_Cargo_Tower_V1_No4_F","Land_Cargo_Tower_V1_No5_F","Land_Cargo_Tower_V1_No6_F","Land_Cargo_Tower_V1_No7_F","Land_Cargo_Tower_V2_F", "Land_Cargo_Tower_V3_F"]; //Put HMGs in these buildings

OT_ammo_50cal = "OT_ammo50cal";

OT_item_wrecks = ["Land_Wreck_HMMWV_F","Land_Wreck_Skodovka_F","Land_Wreck_Truck_F","Land_Wreck_Car2_F","Land_Wreck_Car_F","Land_Wreck_Hunter_F","Land_Wreck_Offroad_F","Land_Wreck_Offroad2_F","Land_Wreck_UAZ_F","Land_Wreck_Truck_dropside_F"]; //rekt

OT_NATOwait = 30; //Half the Average time between NATO orders (x 10 seconds)
OT_CRIMwait = 500; //Half the Average time between crim changes
OT_jobWait = 60;

OT_Resources = ["OT_Wood","OT_Steel","OT_Plastic","OT_Sugarcane","OT_Sugar","OT_Fertilizer"];

OT_item_CargoContainer = "B_Slingload_01_Cargo_F";

//Shop items
OT_item_ShopRegister = "Land_CashDesk_F";//Cash registers
OT_item_BasicGun = "hgun_P07_F";//Dealers always sell this cheap
OT_item_BasicAmmo = "16Rnd_9x21_Mag";

OT_allDrugs = ["OT_Ganja","OT_Blow"];
OT_illegalItems = OT_allDrugs;

OT_item_UAV = "I_UAV_01_F";
OT_item_UAVterminal = "I_UavTerminal";

OT_item_DefaultBlueprints = [];

call OT_fnc_detectItems;

OT_notifyHistory = [];

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
	["B_AssaultPack_cbr",20,0,0,1],
	["B_AssaultPack_blk",20,0,0,1],
	["B_AssaultPack_khk",20,0,0,1],
	["B_AssaultPack_sgg",20,0,0,1],
	["B_FieldPack_cbr",30,0,0,1],
	["B_FieldPack_blk",30,0,0,1],
	["B_FieldPack_khk",30,0,0,1],
	["B_FieldPack_oli",30,0,0,1],
	["B_Kitbag_cbr",45,0,0,1],
	["B_Kitbag_sgg",45,0,0,1],
	["B_Carryall_cbr",60,0,0,1],
	["B_Carryall_khk",60,0,0,1],
	["B_Carryall_oli",60,0,0,1],
	["B_Parachute",50,0,0,1]
];

cost setVariable ["OT_Wood",[5,0,0,0],true];
cost setVariable ["OT_Steel",[25,0,0,0],true];
cost setVariable ["OT_Plastic",[40,0,0,0],true];
cost setVariable ["OT_Sugarcane",[5,0,0,0],true];
cost setVariable ["OT_Grapes",[5,0,0,0],true];
cost setVariable ["OT_Sugar",[15,0,0,0],true];
cost setVariable ["OT_Wine",[25,0,0,0],true];
cost setVariable ["OT_Olives",[7,0,0,0],true];
cost setVariable ["OT_Fertilizer",[20,0,0,0],true];

if(OT_hasTFAR) then {
	[OT_backpacks,[
		["tf_anprc155",100,0,0,0.1],
		["tf_anarc210",150,0,0,0.1],
		["tf_anarc164",20,0,0,0.5],
		["tf_anprc155_coyote",10,0,0,0.5]
	]] call BIS_fnc_arrayPushStack;
};

//Detecting vehicles && weapons

OT_boats = [
	["C_Scooter_Transport_01_F",150,1,0,1],
	["C_Boat_Civil_01_rescue_F",300,1,1,1],
	["C_Boat_Transport_02_F",600,1,0,1]
];
OT_vehicles = [];
OT_helis = [];
OT_allVehicles = [];
OT_allBoats = ["B_Boat_Transport_01_F"];
OT_allWeapons = [];
OT_allOptics = [];
OT_allMagazines = [OT_ammo_50cal];
OT_allBackpacks = [];
OT_allStaticBackpacks = [];
OT_vehWeights_civ = [];
_mostExpensive = 0;
OT_mostExpensiveVehicle = "";

private _allHouses = "getNumber ( _x >> ""ot_isPlayerHouse"" ) isEqualTo 1" configClasses ( configFile >> "CfgVehicles" );
OT_spawnHouses = [];
{
	_cls = configName _x;
	OT_spawnHouses pushback _cls;
	if((OT_allBuyableBuildings find _cls) isEqualTo -1) then {
		OT_allBuyableBuildings pushback _cls;
	};
	if((OT_allRealEstate find _cls) isEqualTo -1) then {
		OT_allRealEstate pushback _cls;
	};
}foreach(_allHouses);

OT_gunDealerHouses = OT_spawnHouses;

private _allShops = "getNumber ( _x >> ""ot_isShop"" ) isEqualTo 1" configClasses ( configFile >> "CfgVehicles" );
OT_shops = [];
{
	_cls = configName _x;
	OT_shops pushback _cls;
}foreach(_allShops);

private _allCarShops = "getNumber ( _x >> ""ot_isCarDealer"" ) isEqualTo 1" configClasses ( configFile >> "CfgVehicles" );
OT_carShops = [];
{
	_cls = configName _x;
	OT_carShops pushback _cls;
}foreach(_allCarShops);

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
	if(getText (configFile >> "cfgVehicles" >> _cls >> "faction") isEqualTo "CIV_F") then {
		if(getText(configFile >> "cfgVehicles" >> _cls >> "textSingular") != "truck" && getText(configFile >> "cfgVehicles" >> _cls >> "driverAction") != "Kart_driver") then {
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
	_numturrets = count("true" configClasses(configFile >> "cfgVehicles" >> _cls >> "Turrets"));
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
    ( getNumber ( _x >> ""scope"" ) > 0 )
" configClasses ( configFile >> "cfgVehicles" );

private _allFactions = "
    ( getNumber ( _x >> ""side"" ) < 3 )
" configClasses ( configFile >> "cfgFactionClasses" );

private _allGlasses = "
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2 )
" configClasses ( configFile >> "CfgGlasses" );

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
OT_allGlasses = [];
OT_allFacewear = [];
OT_allGoggles = [];

{
	_name = configName _x;
	_title = getText (_x >> "displayname");
	_m = getNumber(_x >> "mass");
	_ignore = getNumber(_x >> "ot_shopignore");
	if(_ignore != 1) then {
		if((_name find "Balaclava_TI_") > -1) then {
			_m = _m * 2;
		};

		_protection = getNumber(_x >> "ACE_Protection");
		if(_protection > 0) then {
			_m = round(_m * 1.5);
		};

		call {
			if(_name isEqualTo "None") exitWith {};
			if(_name isEqualTo "G_Goggles_VR") exitWith {};
			if((_title find "Tactical") > -1 or (_title find "Diving") > -1 or (_title find "Goggles") > -1) exitWith {
				OT_allGoggles pushback _name;
			};
			if((_title find "Balaclava") > -1 or (_title find "Bandana") > -1) exitWith {
				OT_allFacewear pushback _name;
			};
			OT_allGlasses pushback _name;
		};
		if(isServer && _name != "None") then {
			cost setVariable [_name,[_m*3,0,0,ceil(_m*0.5)],true];
		};
	};
}foreach(_allGlasses);

{
	_name = configName _x;
	_title = getText (configFile >> "cfgFactionClasses" >> _name >> "displayName");
	_side = getNumber (configFile >> "cfgFactionClasses" >> _name >> "side");
	_flag = getText (configFile >> "cfgFactionClasses" >> _name >> "flag");
	_numblueprints = 0;

	//Get vehicles && weapons
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
				if(_cls isKindOf "LandVehicle" or _cls isKindOf "Air" or _cls isKindOf "Ship") then {
					_vehicles pushback _cls;
					_numblueprints = _numblueprints + 1;
				};
			};
		};
	}foreach(_all);

	if(isServer) then {
		spawner setVariable [format["facweapons%1",_name],_weapons,true];
		spawner setVariable [format["facvehicles%1",_name],_vehicles,true];
	};
	if(_side > -1 && _numblueprints > 0) then {
		OT_allFactions pushback [_name,_title,_side,_flag];
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
	_steel = 2;
	switch (_weaponType) do	{
		case "SubmachineGun": {_steel = 0.5;_cost = 250;OT_allSubMachineGuns pushBack _name};

		case "AssaultRifle": {
			call {
				if(_caliber isEqualTo " 5.56" or _caliber isEqualTo "5.56" or _caliber isEqualTo " 5.45" or _caliber isEqualTo " 5.8") exitWith {_cost = 500};
				if(_caliber isEqualTo " 12 gauge") exitWith {_cost = 1200};
				if(_caliber isEqualTo " .408") exitWith {_cost = 4000};
				if(_caliber isEqualTo " .338 Lapua Magnum" or _caliber isEqualTo " .303") exitWith {_cost = 700};
				if(_caliber isEqualTo " 9") exitWith {_cost = 400}; //9x21mm
				if(_caliber isEqualTo " 6.5") exitWith {_cost = 1000};
				if(_caliber isEqualTo " 7.62") exitWith {_cost = 1500};
				if(_caliber isEqualTo " 9.3" or _caliber isEqualTo "9.3") exitWith {_cost = 1700};
				if(_caliber isEqualTo " 12.7") exitWith {_cost = 3000};
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
		case "SniperRifle": {_cost = 4000;OT_allSniperRifles pushBack _name};
		case "Handgun": {
			_steel = 1;
			_cost = 100;
			call {
				if(_caliber isEqualTo " .408") exitWith {_cost = 2000};
				if(_caliber isEqualTo " .338 Lapua Magnum" or _caliber isEqualTo " .303") exitWith {_cost = 700};
			};
			if(_short != "Metal Detector") then {
				OT_allHandGuns pushBack _name
			}
		};
		case "MissileLauncher": {_cost=15000;OT_allMissileLaunchers pushBack _name};
		case "RocketLauncher": {_cost = 1500;if(_name isEqualTo "launch_NLAW_F") then {_cost=1000};OT_allRocketLaunchers pushBack _name};
		case "Vest": {
			if !(_name in ["V_RebreatherB","V_RebreatherIA","V_RebreatherIR","V_Rangemaster_belt"]) then {
				_cost = 40 + (getNumber(configFile >> "CfgWeapons" >> _name >> "ItemInfo" >> "HitpointsProtectionInfo" >> "Chest" >> "armor") * 20);
				if !(_name in ["V_Press_F","V_TacVest_blk_POLICE"]) then {
					OT_allVests pushBack _name;
					if(_cost > 40) then {
						OT_allProtectiveVests pushback _name;
					};
					if(_cost > 300) then {
						OT_allExpensiveVests pushback _name;
					};
					if(_cost < 300 && _cost > 40) then {
						OT_allCheapVests pushback _name;
					};
				};
			};
		};
	};
	if(isServer) then {
		cost setVariable [_name,[_cost,0,_steel,0],true];
	};
} foreach (_allWeapons);

OT_allLegalClothing = [];
{
	_name = configName _x;
	_short = getText (configFile >> "CfgWeapons" >> _name >> "descriptionShort");
	_supply = getText(configfile >> "CfgWeapons" >> _name >> "ItemInfo" >> "containerClass");
	_carry = getNumber(configfile >> "CfgVehicles" >> _supply >> "maximumLoad");
	_cost = round(_carry * 0.5);

	OT_allClothing pushback _name;
	_c = _name splitString "_";
	_side = _c select 1;
	if((_name isEqualTo "V_RebreatherIA" or _side isEqualTo "C" or _side isEqualTo "I") && (_c select (count _c - 1) != "VR")) then {
		OT_allLegalClothing pushback _name;
	};
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
	if(_name isKindOf ["CA_Magazine",configFile >> "CfgMagazines"] && (_name != "NLAW_F") && !(_name isKindOf ["VehicleMagazine",configFile >> "CfgMagazines"])) then {
		_cost = round(_m * 4);
		_desc = getText(_x >> "descriptionShort");
		if((_desc find ".408") > -1) then {
			_cost = _cost * 4;
		};
		_exp = false;
		_steel = 0.1;
		_plastic = 0;
		if(getNumber(_x >> "ace_explosives_Placeable") isEqualTo 1) then {
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

		if(_name isEqualTo OT_ammo_50cal) then {_cost = 50};

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
		if((_name isKindOf "AllVehicles") && !(_name in OT_allVehicles)) then {
			_multiply = 80;
			if(_name isKindOf "Air") then {_multiply = 700}; //Planes/Helis have less armor

			_cost = getNumber (configFile >> "cfgVehicles" >> _name >> "armor") * _multiply;
			_steel = round(getNumber (configFile >> "cfgVehicles" >> _name >> "armor") * 0.5);
			_numturrets = count("!((configName _x) select [0,5] isEqualTo ""Cargo"")" configClasses(configFile >> "cfgVehicles" >> _name >> "Turrets"));
			_plastic = 2;
			if(_numturrets > 0) then {
				_cost = _cost + (_numturrets * _cost * 10);
				_steel = _steel + 50;
				_plastic = 5 * _numturrets;

				if(_name isKindOf "Air") then {_cost = _cost * 2};
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
	if(_t isEqualTo 302) then {
		//Bipods
		_cost = 150;
	};
	if(_t isEqualTo 101) then {
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
		if(_mode isEqualTo "NVS") then {_mul = 0.2};
		if(_mode isEqualTo "TWS") then {_mul = 0.5};
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

OT_staticMachineGuns = ["I_HMG_01_F","I_HMG_01_high_F","I_HMG_01_A_F","O_HMG_01_F","O_HMG_01_high_F","O_HMG_01_A_F","B_HMG_01_F","B_HMG_01_high_F","B_HMG_01_A_F"];
OT_staticWeapons = ["I_Mortar_01_F","I_static_AA_F","I_static_AT_F","I_GMG_01_F","I_GMG_01_high_F","I_GMG_01_A_F","I_HMG_01_F","I_HMG_01_high_F","I_HMG_01_A_F","O_static_AA_F","O_static_AT_F","O_Mortar_01_F","O_GMG_01_F","O_GMG_01_high_F","O_GMG_01_A_F","O_HMG_01_F","O_HMG_01_high_F","O_HMG_01_A_F","B_static_AA_F","B_static_AT_F","B_Mortar_01_F","B_GMG_01_F","B_GMG_01_high_F","B_GMG_01_A_F","B_HMG_01_F","B_HMG_01_high_F","B_HMG_01_A_F"];

OT_miscables = ["ACE_Wheel","ACE_Track","Land_PortableLight_double_F","Land_PortableLight_single_F","Land_Camping_Light_F","Land_PortableHelipadLight_01_F","PortableHelipadLight_01_blue_F",
"PortableHelipadLight_01_green_F","PortableHelipadLight_01_red_F","PortableHelipadLight_01_white_F","PortableHelipadLight_01_yellow_F","Land_Campfire_F","ArrowDesk_L_F",
"ArrowDesk_R_F","ArrowMarker_L_F","ArrowMarker_R_F","Pole_F","Land_RedWhitePole_F","RoadBarrier_F","RoadBarrier_small_F","RoadCone_F","RoadCone_L_F","Land_VergePost_01_F",
"TapeSign_F","Land_WheelChock_01_F","Land_Sleeping_bag_F","Land_Sleeping_bag_blue_F","Land_WoodenLog_F","FlagChecked_F","FlagSmall_F","Land_LandMark_F","Land_Bollard_01_F"];

//Stuff you can build
OT_Buildables = [
	["Training Camp",1500,[
		["Land_IRMaskingCover_02_F",[-0.039865,0.14918,0],0,1,0,[],"","",true,false],
		["Box_NATO_Grenades_F",[1.23933,-1.05774,0],93.4866,1,0,[],"","",true,false],
		["Land_CampingTable_F",[-0.0490456,-1.74478,0],0,1,0,[],"","",true,false],
		["Land_CampingChair_V2_F",[-1.44146,-1.7173,0],223.485,1,0,[],"","",true,false],
		["Land_ClutterCutter_large_F",[0,0,0],0,1,0,[],"","",true,false]
	],"OT_fnc_initTrainingCamp",true,"Allows training of recruits && hiring of mercenaries"],
	["Bunkers",500,["Land_BagBunker_01_small_green_F","Land_HBarrier_01_big_tower_green_F","Land_HBarrier_01_tower_green_F"],"",false,"Small Defensive Structures. Press space to change type."],
	["Walls",200,["Land_ConcreteWall_01_l_8m_F","Land_ConcreteWall_01_l_gate_F","Land_HBarrier_01_wall_6_green_F","Land_HBarrier_01_wall_4_green_F","Land_HBarrier_01_wall_corner_green_F"],"",false,"Stop people (or tanks) from getting in. Press space to change type."],
	["Helipad",50,["Land_HelipadCircle_F","Land_HelipadCivil_F","Land_HelipadRescue_F","Land_HelipadSquare_F"],"",false,"Informs helicopter pilots of where might be a nice place to land"],
	["Observation Post",800,["Land_Cargo_Patrol_V4_F"],"OT_fnc_initObservationPost",false,"Includes unarmed personnel to keep an eye over the area && provide intel on enemy positions"],
	["Barracks",5000,[OT_barracks],"",false,"Allows recruiting of squads"],
	["Guard Tower",5000,["Land_Cargo_Tower_V4_F"],"",false,"It's a huge tower, what else do you need?."],
	["Hangar",1200,["Land_Airport_01_hangar_F"],"",false,"A big empty building, could probably fit a plane inside it."],
	["Workshop",1000,[
		["Land_Cargo_House_V4_F",[0,0,0],0,1,0,[],"","",true,false],
		["Land_ClutterCutter_large_F",[0,0,0],0,1,0,[],"","",true,false],
		["Box_NATO_AmmoVeh_F",[-2.91,-2.008,0],90,1,0,[],"","",true,false],
		["Land_WeldingTrolley_01_F",[-3.53163,1.73366,0],87.0816,1,0,[],"","",true,false],
		["Land_ToolTrolley_02_F",[-3.47775,3.5155,0],331.186,1,0,[],"","",true,false]
	],"OT_fnc_initWorkshop",true,"Attach weapons to vehicles"],
	["House",1100,["Land_House_Small_06_F","Land_House_Small_02_F","Land_House_Small_03_F","Land_GarageShelter_01_F","Land_Slum_04_F"],"",false,"4 walls, a roof, && if you're lucky a door that opens."],
	["Police Station",2500,[OT_policeStation],"OT_fnc_initPoliceStation",false,"Allows hiring of policeman to raise stability in a town && keep the peace. Comes with 2 units."],
	["Warehouse",4000,[OT_warehouse],"OT_fnc_initWarehouse",false,"A house that you put wares in."],
	["Refugee Camp",600,[OT_refugeeCamp],"",false,"Attracts scared civilians that are more likely to join your cause"]
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

//Items you can place
OT_Placeables = [
	["Sandbags",20,["Land_BagFence_01_long_green_F","Land_BagFence_01_short_green_F","Land_BagFence_01_round_green_F","Land_BagFence_01_corner_green_F","Land_BagFence_01_end_green_F"],[0,3,0.8],"Bags filled with lots of sand. Apparently this can stop bullets or something?"],
	["Camo Nets",40,["CamoNet_ghex_F","CamoNet_ghex_open_F","CamoNet_ghex_big_F"],[0,7,2],"Large && terribly flimsy structures that may or may not obscure your forces from airborne units."],
	["Barriers",60,["Land_HBarrier_01_line_5_green_F","Land_HBarrier_01_line_3_green_F","Land_HBarrier_01_line_1_green_F"],[0,4,1.2],"Really big sandbags, basically."],
	["Map",30,[OT_item_Map],[0,2,1.2],"Use these to save your game, change options or check town info."],
	["Safe",50,[OT_item_Safe],[0,2,0.5],"Store && retrieve money"],
	["Misc",30,OT_miscables,[0,3,1.2],"Various other items, including spare wheels && lights"]
];

//People you can recruit, && squads are composed of
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

OT_workshop = [
	["Static MG","C_Offroad_01_F",600,"I_HMG_01_high_weapon_F","I_HMG_01_high_F",[[0.25,-2,1]],0],
	["Static GL","C_Offroad_01_F",1100,"I_GMG_01_high_weapon_F","I_GMG_01_high_F",[[0.25,-2,1]],0],
	["Static AT","C_Offroad_01_F",2600,"I_AT_01_weapon_F","I_static_AT_F",[[0,-1.5,0.25],180]],
	["Static AA","C_Offroad_01_F",2600,"I_AA_01_weapon_F","I_static_AA_F",[[0,-1.5,0.25],180]]
];

OT_loadingMessages = ["Adding Hidden Agendas","Adjusting Bell Curves","Aesthesizing Industrial Areas","Aligning Covariance Matrices","Applying Feng Shui Shaders","Applying Theatre Soda Layer","Asserting Packed Exemplars","Attempting to Lock Back-Buffer","Binding Sapling Root System","Breeding Fauna","Building Data Trees","Bureacritizing Bureaucracies","Calculating Inverse Probability Matrices","Calculating Llama Expectoration Trajectory","Calibrating Blue Skies","Charging Ozone Layer","Coalescing Cloud Formations","Cohorting Exemplars","Collecting Meteor Particles","Compounding Inert Tessellations","Compressing Fish Files","Computing Optimal Bin Packing","Concatenating Sub-Contractors","Containing Existential Buffer","Debarking Ark Ramp","Debunching Unionized Commercial Services","Deciding What Message to Display Next","Decomposing Singular Values","Decrementing Tectonic Plates","Deleting Ferry Routes","Depixelating Inner Mountain Surface Back Faces","Depositing Slush Funds","Destabilizing Economic Indicators","Determining Width of Blast Fronts","Deunionizing Bulldozers","Dicing Models","Diluting Livestock Nutrition Variables","Downloading Satellite Terrain Data","Exposing Flash Variables to Streak System","Extracting Resources","Factoring Pay Scale","Fixing Election Outcome Matrix","Flood-Filling Ground Water","Flushing Pipe Network","Gathering Particle Sources","Generating Jobs","Gesticulating Mimes","Graphing Whale Migration","Hiding Willio Webnet Mask","Implementing Impeachment Routine","Increasing Accuracy of RCI Simulators","Increasing Magmafacation","Initializing Rhinoceros Breeding Timetable","Initializing Robotic Click-Path AI","Inserting Sublimated Messages","Integrating Curves","Integrating Illumination Form Factors","Integrating Population Graphs","Iterating Cellular Automata","Lecturing Errant Subsystems","Mixing Genetic Pool","Modeling Object Components","Mopping Occupant Leaks","Normalizing Power","Obfuscating Quigley Matrix","Overconstraining Dirty Industry Calculations","Partitioning City Grid Singularities","Perturbing Matrices","Pixellating Nude Patch","Polishing Water Highlights","Populating Lot Templates","Preparing Sprites for Random Walks","Prioritizing Landmarks","Projecting Law Enforcement Pastry Intake","Realigning Alternate Time Frames","Reconfiguring User Mental Processes","Relaxing Splines","Removing Road Network Speed Bumps","Removing Texture Gradients","Removing Vehicle Avoidance Behavior","Resolving GUID Conflict","Reticulating Splines","Retracting Phong Shader","Retrieving from Back Store","Reverse Engineering Image Consultant","Routing Neural Network Infanstructure","Scattering Rhino Food Sources","Scrubbing Terrain","Searching for Llamas","Seeding Architecture Simulation Parameters","Sequencing Particles","Setting Advisor ","Setting Inner Deity ","Setting Universal Physical Constants","Sonically Enhancing Occupant-Free Timber","Speculating Stock Market Indices","Splatting Transforms","Stratifying Ground Layers","Sub-Sampling Water Data","Synthesizing Gravity","Synthesizing Wavelets","Time-Compressing Simulator Clock","Unable to Reveal Current Activity","Weathering Buildings","Zeroing Crime Network"];

//Find markers
OT_ferryDestinations = [];
OT_NATO_control = [];
OT_regions = [];
{
	if((_x select [0,12]) isEqualTo "destination_") then {OT_ferryDestinations pushback _x};
	if((_x select [0,8]) isEqualTo "control_") then {OT_NATO_control pushback _x};
	if((_x select [0,7]) isEqualTo "island_") then {OT_regions pushback _x};
	if((_x select [0,7]) isEqualTo "region_") then {OT_regions pushback _x};
}foreach(allMapMarkers);

OT_cigsArray = ["EWK_Cigar1", "EWK_Cigar2", "EWK_Cig1", "EWK_Cig2", "EWK_Cig3", "EWK_Cig4", "EWK_Glasses_Cig1", "EWK_Glasses_Cig2", "EWK_Glasses_Cig3", "EWK_Glasses_Cig4", "EWK_Glasses_Shemag_GRE_Cig6", "EWK_Glasses_Shemag_NB_Cig6", "EWK_Glasses_Shemag_tan_Cig6", "EWK_Cig5", "EWK_Glasses_Cig5", "EWK_Cig6", "EWK_Glasses_Cig6", "EWK_Shemag_GRE_Cig6", "EWK_Shemag_NB_Cig6", "EWK_Shemag_tan_Cig6", "murshun_cigs_cig0", "murshun_cigs_cig1", "murshun_cigs_cig2", "murshun_cigs_cig3", "murshun_cigs_cig4"];

// Weapon mags to delete or not copy on transfers.
OT_noCopyMags = ["ACE_PreloadedMissileDummy"];

if(isServer) then {
	cost setVariable ["ToolKit",[80,0,0,0],true];
	OT_varInitDone = true;
	publicVariable "OT_varInitDone";
};
