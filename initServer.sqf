if (!isMultiplayer) exitWith {};

call compile preprocessFileLineNumbers "initFuncs.sqf";
call compile preprocessFileLineNumbers "initVar.sqf";

call compile preprocessFileLineNumbers "initEconomy.sqf";
[] execVM "factions\NATO.sqf";
[] execVM "factions\CRIM.sqf";	
waitUntil {!isNil "AIT_NATOInitDone"};
waitUntil {!isNil "AIT_CRIMInitDone"};	

//Init virtualization
[] execVM "virtualization.sqf";	
waitUntil {!isNil "AIT_fnc_registerSpawner"};
[] execVM "virtualization\towns.sqf";
[] execVM "virtualization\shops.sqf";
[] execVM "virtualization\military.sqf";

//Addons
[] execVM "VCOMAI\init.sqf";

addMissionEventHandler ["EntityKilled",compile preprocessFileLineNumbers "entityKilled.sqf"];

AIT_serverInitDone = true;
publicVariable "AIT_serverInitDone";