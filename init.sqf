/*
 * Overthrow 
 * By ARMAzac
 * 
 * https://github.com/armazac/Overthrow.Tanoa
 */


inGameUISetEventHandler ["PrevAction", ""];
inGameUISetEventHandler ["Action", ""];
inGameUISetEventHandler ["NextAction", ""];

AIT_debug = false;

if(!isMultiplayer) then {		
	call compile preprocessFileLineNumbers "initFuncs.sqf";
	call compile preprocessFileLineNumbers "initVar.sqf";

	//SINGLE PLAYER init
	call compile preprocessFileLineNumbers "initEconomy.sqf";
	
	//Advanced towing script, massive credits to Duda http://www.armaholic.com/page.php?id=30575
	[] execVM "funcs\fn_advancedTowingInit.sqf";
	
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
	
	//Addons
	[] execVM "VCOMAI\init.sqf";
	
	addMissionEventHandler ["EntityKilled",compile preprocessFileLineNumbers "events\entityKilled.sqf"];
	if(AIT_hasAce) then {
		//ACE events
		["ace_cargoLoaded",compile preprocessFileLineNumbers "events\cargoLoaded.sqf"] call CBA_fnc_addEventHandler;
	};
	
	AIT_serverInitDone = true;
	publicVariable "AIT_serverInitDone";
};

//Zeus Debug
if (isServer and AIT_debug) then {
	[] spawn {
		waitUntil {
			sleep 2;
			_objects = [];
			{
				if(_x isKindOf "LandVehicle") then {
					_objects pushback _x;
				};
			}foreach(vehicles);
			{
				if(alive _x) then {
					_objects pushback _x;
				};
			}foreach(allUnits);
			{
				_x addCuratorEditableObjects [_objects,true];
			} foreach allCurators;
			false;
		};
	};
};
