if(!isServer) exitWith {};

if !(isClass (configFile >> "CfgPatches" >> "OT_Overthrow_Main")) exitWith {
	diag_log "Overthrow addon not detected, you must add @Overthrow to your -mod commandline";
};

missionNamespace setVariable ["OT_varInitDone", false, true];

server = [true] call CBA_fnc_createNamespace;
players = [true] call CBA_fnc_createNamespace;
cost = [true] call CBA_fnc_createNamespace;
warehouse = [true] call CBA_fnc_createNamespace;
spawner = [true] call CBA_fnc_createNamespace;
templates = [true] call CBA_fnc_createNamespace;
owners = [true] call CBA_fnc_createNamespace;
buildingpositions = [true] call CBA_fnc_createNamespace;
OT_civilians = [true] call CBA_fnc_createNamespace;

OT_centerPos = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");

[] call OT_fnc_initTFAR;

call compile preprocessFileLineNumbers "initVar.sqf";
call OT_fnc_initVar;

if(isServer) then {
    diag_log "Overthrow: Server Pre-Init";

    server setVariable ["StartupType","",true];
    call OT_fnc_initVirtualization;
};

OT_tpl_checkpoint = [] call compileFinal preProcessFileLineNumbers "data\templates\NATOcheckpoint.sqf";

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
[] spawn OT_fnc_factionCIV;
[] spawn OT_fnc_factionCRIM;
waitUntil {!isNil "OT_NATOInitDone"};

//Game systems
[] spawn OT_fnc_propagandaSystem;
[] spawn OT_fnc_weatherSystem;
[] spawn OT_fnc_incomeSystem;
[] spawn OT_fnc_jobSystem;

//Init virtualization
waitUntil {!isNil "OT_economyLoadDone"};
[] spawn OT_fnc_runVirtualization;

//Subscribe to events
if(isMultiplayer) then {
    addMissionEventHandler ["HandleConnect",OT_fnc_playerConnectHandler];
    addMissionEventHandler ["HandleDisconnect",OT_fnc_playerDisconnectHandler];
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
if(isServer) then {
    diag_log "Overthrow: Server Pre-Init Done";
};
