private ["_Enemy", "_Offset", "_ToWorld1", "_ToWorld2", "_PointHeight", "_PointHeightC", "_LookVar", "_dgn_returnvariable"];

_Unit = _this select 0;
_VCOM_MovedRecentlyCover = _this select 1;
_VCOMAI_ActivelyClearing = _this select 2;
_VCOMAI_StartedInside = _this select 3;

if (_VCOM_MovedRecentlyCover || {_VCOMAI_ActivelyClearing} || {_VCOMAI_StartedInside}) exitWith {_dgn_returnvariable = false;_dgn_returnvariable};

//systemchat format ["A %1",_Unit];
_Enemy = _Unit call VCOMAI_ClosestEnemy;
if (isNil "_Enemy") exitWith {};

if ((typeName _Enemy) isEqualTo "ARRAY") exitWith {_dgn_returnvariable = false;_dgn_returnvariable};

_dgn_returnvariable = false;

_Position = getposASL _Enemy;
_Array = lineIntersectsObjs [_Position,[_Position select 0,_Position select 1,(_Position select 2) + 10], objnull, objnull, true, 4];
{
	if (_x isKindof "Building") exitWith {_dgn_returnvariable = true;};
} foreach _Array;

_Array = lineIntersectsObjs [_Position,[_Position select 0,_Position select 1,(_Position select 2) - 10], objnull, objnull, true, 4];
{
	if (_x isKindof "Building") exitWith {_dgn_returnvariable = true;};
} foreach _Array;

_dgn_returnvariable