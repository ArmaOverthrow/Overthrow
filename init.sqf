/*
 * Overthrow 
 * By ARMAzac
 * 
 * https://github.com/armazac/Overthrow.Tanoa
 */


inGameUISetEventHandler ["PrevAction", ""];
inGameUISetEventHandler ["Action", ""];
inGameUISetEventHandler ["NextAction", ""];

if(!isMultiplayer) then {		
	//VCOM AI, huge credits to Genesis, without VCOM this mission would be so much less
	[] execVM "VCOMAI\init.sqf";
	
	//Advanced towing script, credits to Duda http://www.armaholic.com/page.php?id=30575
	[] execVM "funcs\fn_advancedTowingInit.sqf";
	
	call compile preprocessFileLineNumbers "initFuncs.sqf";
	call compile preprocessFileLineNumbers "initVar.sqf";

	//SINGLE PLAYER init
	[] execVM "initEconomy.sqf";
		
	//Init factions
	[] execVM "factions\NATO.sqf";
	[] execVM "factions\CRIM.sqf";	
	waitUntil {!isNil "AIT_NATOInitDone"};
	waitUntil {!isNil "AIT_CRIMInitDone"};	
	
	//Bounty system
	[] execVM "bountySystem.sqf";
	
	//Init virtualization
	[] execVM "virtualization.sqf";	
	waitUntil {!isNil "AIT_fnc_registerSpawner"};
	[] execVM "virtualization\towns.sqf";
	[] execVM "virtualization\shops.sqf";
	[] execVM "virtualization\military.sqf";	
	[] execVM "virtualization\distribution.sqf";
	
	
	addMissionEventHandler ["EntityKilled",compile preprocessFileLineNumbers "events\entityKilled.sqf"];
	if(AIT_hasAce) then {
		//ACE events
		["ace_cargoLoaded",compile preprocessFileLineNumbers "events\cargoLoaded.sqf"] call CBA_fnc_addEventHandler;
	};
	
	AIT_serverInitDone = true;
	publicVariable "AIT_serverInitDone";
};
