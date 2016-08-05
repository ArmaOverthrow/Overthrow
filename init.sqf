// block script injection exploit
inGameUISetEventHandler ["PrevAction", ""];
inGameUISetEventHandler ["Action", ""];
inGameUISetEventHandler ["NextAction", ""];

AIT_debug = false;

if(!isMultiplayer) then {		
	call compile preprocessFileLineNumbers "initFuncs.sqf";
	call compile preprocessFileLineNumbers "initVar.sqf";

	//SINGLE PLAYER init
	call compile preprocessFileLineNumbers "initEconomy.sqf";
	[] execVM "factions\initNATO.sqf";
	[] execVM "factions\initCRIM.sqf";
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
