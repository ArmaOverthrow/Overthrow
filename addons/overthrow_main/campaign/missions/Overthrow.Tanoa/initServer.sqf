[] spawn OT_fnc_incomeSystem;
addMissionEventHandler ["EntityKilled",OT_fnc_deathHandler];

["Building", "Dammaged", OT_fnc_buildingDamagedHandler] call CBA_fnc_addClassEventHandler;

if (!isMultiplayer) exitWith {};

//Advanced towing script, credits to Duda http://www.armaholic.com/page.php?id=30575
[] execVM "funcs\fn_advancedTowingInit.sqf";

[] call OT_fnc_initTFAR;

call compile preprocessFileLineNumbers "initFuncs.sqf";
call compile preprocessFileLineNumbers "initVar.sqf";
OT_varInitDone = true;
publicVariable "OT_varInitDone";

if(OT_fastTime) then {
    setTimeMultiplier 4;
};

waitUntil {sleep 1;server getVariable ["StartupType",""] != ""};
[] spawn OT_fnc_initEconomyLoad;

[] call OT_fnc_initNATO;
[] execVM "factions\NATO.sqf";
[] execVM "factions\GUER.sqf";
[] execVM "factions\CRIM.sqf";
waitUntil {!isNil "OT_NATOInitDone"};
waitUntil {!isNil "OT_CRIMInitDone"};

//Game systems
[] spawn OT_fnc_propagandaSystem;
[] spawn OT_fnc_weatherSystem;

//Init virtualization
[] spawn OT_fnc_runVirtualization;
waitUntil {!isNil "OT_economyLoadDone" and !isNil "OT_fnc_registerSpawner"};
[] execVM "virtualization\towns.sqf";
[] execVM "virtualization\military.sqf";
[] execVM "virtualization\mobsters.sqf";
[] execVM "virtualization\economy.sqf";
[] execVM "virtualization\factions.sqf";


["ace_cargoLoaded",OT_fnc_cargoLoadedHandler] call CBA_fnc_addEventHandler;
["ace_common_setFuel",OT_fnc_refuelHandler] call CBA_fnc_addEventHandler;
["ace_explosives_place",OT_fnc_explosivesPlacedHandler] call CBA_fnc_addEventHandler;

addMissionEventHandler ["HandleDisconnect",OT_fnc_playerConnectHandler];
addMissionEventHandler ["HandleConnnect",OT_fnc_playerDisconnectHandler];

OT_serverInitDone = true;
publicVariable "OT_serverInitDone";
