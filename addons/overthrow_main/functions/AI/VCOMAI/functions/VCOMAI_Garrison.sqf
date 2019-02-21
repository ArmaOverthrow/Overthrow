private ["_Unit", "_nBuilding", "_GrabVariable", "_BuildingPositions", "_GroupUnits", "_BuildingLocation", "_CurrentPos", "_rnd", "_dist", "_dir", "_positions"];
//Created on ???
// Modified on :8/15/14 - 8/3/15 - 9/10/15

_Unit = _this select 0;
_group	= _this select 1;
_PassFunction = _this select 2;

//Lets find the closest building
_nBuilding = nearestBuilding _Unit;

//Lets find out if the unit is already garrisoned or not. If he is, exit the script
_GrabVariable = _Unit getVariable ["VCOM_GARRISONED",false];

//If the closest building is greate than 15 meters, exit
if ((_nBuilding distance _Unit) > 50 || {_GrabVariable}) exitWith {};


//Find positions in a house.
_BuildingPositions = [_nBuilding] call BIS_fnc_buildingPositions;
private _OriginalPositions = _BuildingPositions;

//If the array is not more than 0 - then exit.
if ((count _BuildingPositions) isEqualTo 0) exitWith {};

//Find the units in the group!
_GroupUnits = units _group;

{
	if !((count _BuildingPositions) isEqualTo 0) then
	{
		_BuildingLocation = selectRandom _BuildingPositions;
		_x doMove _BuildingLocation;
		_x setUnitPos "UP";
		_x setVariable ["VCOM_GARRISONED",true,false];
		[_x,_BuildingLocation,_BuildingPositions] spawn
		{
			params ["_unit","_BuildingLocation","_BuildingPositions"];
			private _group	= group _Unit;
			private _index = currentWaypoint _group;
			private _WaypointIs = waypointType [_group,_index];			
			while {_WaypointIs isEqualTo "HOLD"} do
			{
				waitUntil {_unit distance _BuildingLocation < 1.3};
				_unit disableAI "PATH";
				sleep (30 + (random 60));
				_unit enableAI "PATH";
				_BuildingLocation = selectRandom _BuildingPositions;
				_unit doMove _BuildingLocation;
				_unit setUnitPos "UP";			
			};
		};
	};
} foreach _GroupUnits;

