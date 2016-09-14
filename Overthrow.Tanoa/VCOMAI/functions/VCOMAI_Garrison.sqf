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
if ((_nBuilding distance _Unit) > 15 || {_GrabVariable}) exitWith {};


//Find positions in a house.
_BuildingPositions = [_nBuilding] call BIS_fnc_buildingPositions;


//If the array is not more than 0 - then exit.
if ((count _BuildingPositions) isEqualTo 0) exitWith {};

//Find the units in the group!
_GroupUnits = units _group;

//Put each unit in a seperate group 
{[_x] joinSilent grpNull} forEach _GroupUnits;

if (isNil "_PassFunction") then
{
	[_GroupUnits,side _Unit] spawn VCOMAI_ReGroup;
};

{
	if !((count _BuildingPositions) isEqualTo 0) then
	{
		_BuildingLocation = _BuildingPositions select 0;
		_BuildingPositions = _BuildingPositions - [_BuildingLocation];
		_GroupUnits = _GroupUnits - [_x];
		_x doMove _BuildingLocation;
		_x setUnitPosWeak "UP";
		_x setVariable ["VCOM_GARRISONED",true,false];
	};
} foreach _GroupUnits;


if ((count _GroupUnits) > 0) then
{
	{
		_CurrentPos = getPosASL _x;
		_rnd = random 25;
		_dist = (_rnd + 25);
		_dir = random 360;
		_positions = [(_CurrentPos select 0) + (sin _dir) * _dist, (_CurrentPos select 1) + (cos _dir) * _dist, 0];
		_x doMove _positions;
		sleep 15;
		[_x,(group _x),false] spawn VCOMAI_Garrison;
	} foreach _GroupUnits;
};