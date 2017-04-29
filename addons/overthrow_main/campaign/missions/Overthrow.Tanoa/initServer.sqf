[] execVM "income.sqf";
addMissionEventHandler ["EntityKilled",compileFinal preprocessFileLineNumbers "events\somethingDied.sqf"];

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
[] execVM "initEconomyLoad.sqf";

[] execVM "factions\NATO.sqf";
[] execVM "factions\GUER.sqf";
[] execVM "factions\CRIM.sqf";
waitUntil {!isNil "OT_NATOInitDone"};
waitUntil {!isNil "OT_CRIMInitDone"};

//Game systems
[] execVM "bountySystem.sqf";
[] execVM "propagandaSystem.sqf";
[] execVM "weather.sqf";

//Init virtualization
[] spawn OT_fnc_runVirtualization;
waitUntil {!isNil "OT_economyLoadDone" and !isNil "OT_fnc_registerSpawner"};
[] execVM "virtualization\towns.sqf";
[] execVM "virtualization\military.sqf";
[] execVM "virtualization\mobsters.sqf";
[] execVM "virtualization\economy.sqf";
[] execVM "virtualization\factions.sqf";

if(OT_hasAce) then {
    //ACE events
    ["ace_cargoLoaded",compile preprocessFileLineNumbers "events\cargoLoaded.sqf"] call CBA_fnc_addEventHandler;
    ["ace_common_setFuel",compile preprocessFileLineNumbers "events\refuel.sqf"] call CBA_fnc_addEventHandler;
};

addMissionEventHandler ["HandleDisconnect",compile preprocessFileLineNumbers "events\playerDisconnect.sqf"];
addMissionEventHandler ["HandleConnnect",compile preprocessFileLineNumbers "events\playerConnect.sqf"];

OT_serverInitDone = true;
publicVariable "OT_serverInitDone";
