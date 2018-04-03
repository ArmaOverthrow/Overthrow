//Created on ???
// Modified on : 9/7/14 - 8/4/15  - Added a check building distance stat.
_Unit = _this select 0;
_VCOM_MovedRecentlyCover = _this select 1;
_VCOMAI_ActivelyClearing = _this select 2;
_VCOMAI_StartedInside = _this select 3;

if (_VCOM_MovedRecentlyCover || {_VCOMAI_ActivelyClearing} || {_VCOMAI_StartedInside} || {_Unit getVariable "VCOM_GARRISONED"}) exitWith {};
_Group = (group _Unit);
_UnitsGroup = units _Group;
_SpecificUnit = _UnitsGroup select 0;


//systemchat format ["G %1",_Unit];
_ClosestEnemy = _Unit call VCOMAI_ClosestEnemy;
if (isNil "_ClosestEnemy" || {_ClosestEnemy isEqualTo []}) exitWith {};

_nBuilding = nearestBuilding _ClosestEnemy;
_IsEnterable = [_nBuilding] call BIS_fnc_isBuildingEnterable;

{


if (!(_IsEnterable)) exitWith {};
_CheckDist = _SpecificUnit distance _nBuilding;
if (_CheckDist > 200) exitWith {};
_bposleft = [];
_pcnt = 0;
while {format ["%1", _nBuilding buildingPos (_pcnt)] != "[0,0,0]" } do {
_bposleft set [count _bposleft, (_pcnt)];
_pcnt = _pcnt + 1;
};
_LocationArray = [];
{
	_LocationArray = _LocationArray + [(_nBuilding buildingPos _x)];
} forEach _bposleft;

if (isNil "_LocationArray") exitWith {};
if ((count _LocationArray) <= 0) exitWith {};
if ((count _LocationArray) < (count _UnitsGroup)) exitWith {};

_AttackPoint = _LocationArray select floor(random(count _LocationArray));
if (isNil "_AttackPoint") exitWith {};
_LocationArray = _LocationArray - [_AttackPoint];
//_Unit setPos _AttackPoint;
//doStop _x;
_x moveTo _AttackPoint;

} foreach _UnitsGroup;