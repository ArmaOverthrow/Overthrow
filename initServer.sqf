if (!isMultiplayer) exitWith {};

call compile preprocessFileLineNumbers "initFuncs.sqf";
call compile preprocessFileLineNumbers "initVar.sqf";
//SINGLE PLAYER init
_nul = call compile preprocessFileLineNumbers "initEconomy.sqf";
[] execVM "factions\initNATO.sqf";
[] execVM "factions\initCRIM.sqf";

AIT_serverInitDone = true;
publicVariable "AIT_serverInitDone";