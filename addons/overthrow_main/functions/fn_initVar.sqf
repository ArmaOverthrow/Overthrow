//Global overthrow variables related to any map

OT_currentMissionFaction = "";
OT_rankXP = [100,250,500,1000,4000,10000,100000];

OT_adminMode = false;
OT_economyLoadDone = false;
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

OT_ammo_50cal = "100Rnd_127x99_mag";

OT_item_wrecks = ["Land_Wreck_HMMWV_F","Land_Wreck_Skodovka_F","Land_Wreck_Truck_F","Land_Wreck_Car2_F","Land_Wreck_Car_F","Land_Wreck_Hunter_F","Land_Wreck_Offroad_F","Land_Wreck_Offroad2_F","Land_Wreck_UAZ_F","Land_Wreck_Truck_dropside_F"]; //rekt

OT_NATOwait = 30; //Half the Average time between NATO orders (x 10 seconds)
OT_CRIMwait = 500; //Half the Average time between crim changes

OT_Resources = ["OT_Wood","OT_Steel","OT_Plastic","OT_Sugarcane","OT_Sugar","OT_Fertilizer"];

OT_item_CargoContainer = "B_Slingload_01_Cargo_F";

//Shop items
OT_item_ShopRegister = "Land_CashDesk_F";//Cash registers
OT_item_BasicGun = "hgun_P07_F";//Dealers always sell this cheap
OT_item_BasicAmmo = "16Rnd_9x21_Mag";
OT_consumableItems = ["ACE_fieldDressing","ACE_Sandbag_empty","ACE_elasticBandage","ItemMap","ToolKit","ACE_epinephrine","OT_Fertilizer"]; //Shops will try to stock more of these

OT_allDrugs = ["OT_Ganja","OT_Blow"];
OT_illegalItems = OT_allDrugs;

OT_item_UAV = "I_UAV_01_F";
OT_item_UAVterminal = "I_UavTerminal";

OT_item_DefaultBlueprints = [];

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

//Detecting vehicles and weapons

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
			if !(_name in ["V_RebreatherB","V_RebreatherIA","V_RebreatherIR","V_Rangemaster_belt"]) then {
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

OT_staticMachineGuns = ["I_HMG_01_F","I_HMG_01_high_F","I_HMG_01_A_F","O_HMG_01_F","O_HMG_01_high_F","O_HMG_01_A_F","B_HMG_01_F","B_HMG_01_high_F","B_HMG_01_A_F"];
OT_staticWeapons = ["I_Mortar_01_F","I_static_AA_F","I_static_AT_F","I_GMG_01_F","I_GMG_01_high_F","I_GMG_01_A_F","I_HMG_01_F","I_HMG_01_high_F","I_HMG_01_A_F","O_static_AA_F","O_static_AT_F","O_Mortar_01_F","O_GMG_01_F","O_GMG_01_high_F","O_GMG_01_A_F","O_HMG_01_F","O_HMG_01_high_F","O_HMG_01_A_F","B_static_AA_F","B_static_AT_F","B_Mortar_01_F","B_GMG_01_F","B_GMG_01_high_F","B_GMG_01_A_F","B_HMG_01_F","B_HMG_01_high_F","B_HMG_01_A_F"];

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

OT_workshop = [
	["Static MG","C_Offroad_01_F",600,"I_HMG_01_high_weapon_F","I_HMG_01_high_F",[[0.25,-2,1]],0],
	["Static GL","C_Offroad_01_F",1100,"I_GMG_01_high_weapon_F","I_GMG_01_high_F",[[0.25,-2,1]],0],
	["Static AT","C_Offroad_01_F",2600,"I_AT_01_weapon_F","I_static_AT_F",[[0,-1.5,0.25],180]],
	["Static AA","C_Offroad_01_F",2600,"I_AA_01_weapon_F","I_static_AA_F",[[0,-1.5,0.25],180]]
];
