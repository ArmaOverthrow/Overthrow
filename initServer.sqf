[] execVM "income.sqf";

if (!isMultiplayer) exitWith {};

//VCOM AI, huge credits to Genesis, without VCOM this mission would be so much less
[] execVM "VCOMAI\init.sqf";

//Advanced towing script, credits to Duda http://www.armaholic.com/page.php?id=30575
[] execVM "funcs\fn_advancedTowingInit.sqf";

call compile preprocessFileLineNumbers "initFuncs.sqf";
call compile preprocessFileLineNumbers "initVar.sqf";

if(AIT_fastTime) then {
    setTimeMultiplier 4;
};

waitUntil {sleep 1;server getVariable ["StartupType",""] != ""};
[] execVM "initEconomyLoad.sqf";

[] execVM "factions\NATO.sqf";
[] execVM "factions\GUER.sqf";
[] execVM "factions\CRIM.sqf";  
waitUntil {!isNil "AIT_NATOInitDone"};
waitUntil {!isNil "AIT_CRIMInitDone"};  

//Game systems
[] execVM "bountySystem.sqf";
[] execVM "propagandaSystem.sqf";
[] execVM "weather.sqf";

//Init virtualization
[] execVM "virtualization.sqf"; 
waitUntil {!isNil "AIT_economyLoadDone" and !isNil "AIT_fnc_registerSpawner"};
[] execVM "virtualization\towns.sqf";
[] execVM "virtualization\military.sqf";
[] execVM "virtualization\mobsters.sqf";

addMissionEventHandler ["EntityKilled",compile preprocessFileLineNumbers "events\entityKilled.sqf"];
if(AIT_hasAce) then {
    //ACE events
    ["ace_cargoLoaded",compile preprocessFileLineNumbers "events\cargoLoaded.sqf"] call CBA_fnc_addEventHandler;
};

addMissionEventHandler ["HandleDisconnect",compile preprocessFileLineNumbers "events\playerDisconnect.sqf"];
addMissionEventHandler ["HandleConnnect",compile preprocessFileLineNumbers "events\playerConnect.sqf"];

["Initialize"] call BIS_fnc_dynamicGroups;

AIT_serverInitDone = true;
publicVariable "AIT_serverInitDone";