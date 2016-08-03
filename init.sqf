// block script injection exploit
inGameUISetEventHandler ["PrevAction", ""];
inGameUISetEventHandler ["Action", ""];
inGameUISetEventHandler ["NextAction", ""];

if(!isMultiplayer) then {		
	call compile preprocessFileLineNumbers "initFuncs.sqf";
	call compile preprocessFileLineNumbers "initVar.sqf";
	//SINGLE PLAYER init
	call compile preprocessFileLineNumbers "initEconomy.sqf";
	[] execVM "initNATO.sqf";
	[] execVM "initCRIM.sqf";
	[] execVM "agentSpawner.sqf";
	[] execVM "addons\real_weather.sqf";
	AIT_serverInitDone = true;
	publicVariable "AIT_serverInitDone";
};
