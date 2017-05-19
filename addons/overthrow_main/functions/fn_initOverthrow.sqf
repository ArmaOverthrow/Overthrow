if !(isClass (configFile >> "CfgPatches" >> "OT_Overthrow_Main")) exitWith {
	_txt = format ["<t size='0.5' color='#000000'>Overthrow addon not detected, you must add @Overthrow to your -mod commandline</t>",_this];
    [_txt, 0, 0.2, 30, 0, 0, 2] spawn bis_fnc_dynamicText;
};

private _center = createCenter sideLogic;
private _group = createGroup _center;

server = _group createUnit ["LOGIC",[0,0,0] , [], 0, ""];
cost = _group createUnit ["LOGIC",[1,0,0] , [], 0, ""];
warehouse = _group createUnit ["LOGIC",[2,0,0] , [], 0, ""];
spawner = _group createUnit ["LOGIC",[3,0,0] , [], 0, ""];
templates = _group createUnit ["LOGIC",[4,0,0] , [], 0, ""];
owners = _group createUnit ["LOGIC",[5,0,0] , [], 0, ""];
buildingpositions = _group createUnit ["LOGIC",[5,0,0] , [], 0, ""];

publicVariable "server";
publicVariable "cost";
publicVariable "warehouse";
publicVariable "spawner";
publicVariable "templates";
publicVariable "owners";
publicVariable "buildingpositions";

if(!isMultiplayer) then {
    addMissionEventHandler ["Loaded", {
        [] spawn OT_fnc_setupPlayer;
    }];
};


OT_centerPos = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");

[] call OT_fnc_initTFAR;

call compile preprocessFileLineNumbers "initVar.sqf";

//VCOM AI, huge credits to Genesis, without VCOM this campaign would be so much less
[] call OT_fnc_initVCOMAI;

[] execVM "\ot\functions\geography\SHK_pos\shk_pos_init.sqf";

OT_missions = [];
OT_localMissions = [];
private _allMissions = "" configClasses ( configFile >> "CfgOverthrowMissions" );
{
	_name = configName _x;
	_script = getText (_x >> "script");
	_code = compileFinal preprocessFileLineNumbers _script;
	if(getNumber(_x >> "faction") > 0) then {
		OT_missions pushback _code;
	}else{
		OT_localMissions pushback _code;
	};
}foreach(_allMissions);

call OT_fnc_initVar;

//Find markers
OT_ferryDestinations = [];
OT_NATO_control = [];
OT_regions = [];
{
	if((_x select [0,12]) == "destination_") then {OT_ferryDestinations pushback _x};
	if((_x select [0,8]) == "control_") then {OT_NATO_control pushback _x};
	if((_x select [0,7]) == "island_") then {OT_regions pushback _x};
	if((_x select [0,7]) == "region_") then {OT_regions pushback _x};
}foreach(allMapMarkers);

if(isServer) then {
    diag_log "Overthrow: Server Pre-Init";

    server setVariable ["StartupType","",true];
    call OT_fnc_initVirtualization;
};

OT_tpl_checkpoint = [] call compileFinal preProcessFileLineNumbers "data\templates\NATOcheckpoint.sqf";

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
}foreach("getNumber(_x >> 'disabled') == 0" configClasses (configfile >> "CfgFaces" >> "Man_A3"));

OT_voices_local = [];
OT_voices_western = [];
OT_voices_eastern = [];
{
    _types = getArray(_x >> "identityTypes");
	if(OT_language_local in _types) then {OT_voices_local pushback configName _x};
	if(OT_language_western in _types) then {OT_voices_western pushback configName _x};
	if(OT_language_eastern in _types) then {OT_voices_eastern pushback configName _x};
}foreach("getNumber(_x >> 'scope') == 2" configClasses (configfile >> "CfgVoice"));

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
}foreach("(getNumber (_x >> 'scope') == 2) && (configName _x isKindOf 'House') && (configName _x find '_House' > -1)" configClasses (configfile >> "CfgVehicles"));

OT_allBuyableBuildings = OT_lowPopHouses + OT_medPopHouses + OT_highPopHouses + OT_hugePopHouses + OT_mansions + [OT_item_Tent,OT_flag_IND];
{
	_istpl = _x select 4;
	if(_istpl) then {
		_tpl = _x select 2;
		OT_allBuyableBuildings pushback ((_tpl select 0) select 0);
	}else{
		[OT_allBuyableBuildings,(_x select 2)] call BIS_fnc_arrayPushStack;
	}
}foreach(OT_Buildables);

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

//Advanced towing script, credits to Duda http://www.armaholic.com/page.php?id=30575
[] spawn OT_fnc_advancedTowingInit;

waitUntil {sleep 1;server getVariable ["StartupType",""] != ""};
[] spawn OT_fnc_initEconomyLoad;

if(OT_fastTime) then {
    setTimeMultiplier 4;
};

//Init factions
[] call OT_fnc_initNATO;
[] spawn OT_fnc_factionNATO;
[] spawn OT_fnc_factionGUER;
waitUntil {!isNil "OT_NATOInitDone"};

//Game systems
[] spawn OT_fnc_propagandaSystem;
[] spawn OT_fnc_weatherSystem;
[] spawn OT_fnc_incomeSystem;

//Init virtualization
[] spawn OT_fnc_runVirtualization;
waitUntil {!isNil "OT_economyLoadDone"};

//Subscribe to events
if(isMultiplayer) then {
    addMissionEventHandler ["HandleDisconnect",OT_fnc_playerConnectHandler];
    addMissionEventHandler ["HandleConnnect",OT_fnc_playerDisconnectHandler];
};
addMissionEventHandler ["EntityKilled",OT_fnc_deathHandler];

//ACE3 events
["ace_cargoLoaded",OT_fnc_cargoLoadedHandler] call CBA_fnc_addEventHandler;
["ace_common_setFuel",OT_fnc_refuelHandler] call CBA_fnc_addEventHandler;
["ace_explosives_place",OT_fnc_explosivesPlacedHandler] call CBA_fnc_addEventHandler;
["Building", "Dammaged", OT_fnc_buildingDamagedHandler] call CBA_fnc_addClassEventHandler;

//Setup fuel pumps for interaction
{
    [_x,0] call ace_interact_menu_fnc_addMainAction;
}foreach(OT_fuelPumps);


OT_serverInitDone = true;
publicVariable "OT_serverInitDone";
