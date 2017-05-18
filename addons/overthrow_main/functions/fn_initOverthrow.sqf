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

if(isServer) then {
    diag_log "Overthrow: Server Pre-Init";

    server setVariable ["StartupType","",true];
    call OT_fnc_initVirtualization;
};

OT_tpl_playerDesk = [] call compileFinal preProcessFileLineNumbers "templates\playerdesk.sqf";
OT_tpl_checkpoint = [] call compileFinal preProcessFileLineNumbers "templates\NATOcheckpoint.sqf";

call compileFinal preprocessFileLineNumbers "data\names.sqf";
call compileFinal preprocessFileLineNumbers "data\towns.sqf";
call compileFinal preprocessFileLineNumbers "data\airports.sqf";
call compileFinal preprocessFileLineNumbers "data\objectives.sqf";
call compileFinal preprocessFileLineNumbers "data\economy.sqf";
call compileFinal preprocessFileLineNumbers "data\comms.sqf";



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
