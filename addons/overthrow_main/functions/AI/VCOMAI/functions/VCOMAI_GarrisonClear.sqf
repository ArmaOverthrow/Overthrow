private ["_Enemy", "_nBuilding", "_Locations"];

_Unit = _this select 0;
_VCOM_MovedRecentlyCover = _this select 1;
_VCOM_InCover = _this select 2;
_VCOMAI_ActivelyClearing = _this select 3;
_VCOMAI_StartedInside = _this select 4;
_VCOM_GARRISONED = _this select 5;

//Function to send AI to clear buildings
if (_VCOM_MovedRecentlyCover || {_VCOMAI_ActivelyClearing} || {_VCOMAI_StartedInside} || {_VCOM_GARRISONED}) exitWith {};
//Find the closest enemy (This should be the one that is in a building

//systemchat format ["F %1",_Unit];
_Enemy = _Unit call VCOMAI_ClosestEnemy;
if (isNil "_Enemy" || {(typeName _Enemy) isEqualTo "ARRAY"}) exitWith {};

//Find nearest building to the enemy
_nBuilding = nearestBuilding _Enemy;

//Find the locations of the buildings
_Locations = [_nBuilding] call BIS_fnc_buildingPositions;

//Stop the AI - and then tell them to move to the house
{
	//Set variable to true to prevent AI clearing buildings to often
	//_x spawn VCOMAI_StanceModifier;
	if (_Enemy distance _x < 200) then
	{
		[_Locations,_x,_VCOM_InCover,_VCOMAI_ActivelyClearing,_Enemy] spawn VCOMAI_GarrisonClearPatrol;
	};
} foreach units (group _Unit);

