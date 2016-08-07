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
[] execVM "virtualization\distribution.sqf";

//Addons
[] execVM "VCOMAI\init.sqf";

addMissionEventHandler ["EntityKilled",compile preprocessFileLineNumbers "events\entityKilled.sqf"];
if(AIT_hasAce) then {
	//ACE events
	["ace_cargoLoaded",compile preprocessFileLineNumbers "events\cargoLoaded.sqf"] call CBA_fnc_addEventHandler;
};

addMissionEventHandler ["HandleDisconnect",compile preprocessFileLineNumbers "events\playerDisconnect.sqf"];

AIT_serverInitDone = true;
publicVariable "AIT_serverInitDone";