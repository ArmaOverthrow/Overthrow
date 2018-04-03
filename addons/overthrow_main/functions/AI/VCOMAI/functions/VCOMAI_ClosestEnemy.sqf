private ["_Unit", "_UnitSide", "_Array1", "_ReturnedEnemy"];
//Created on ???
// Modified on : 8/19/14 - 8/3/15

_Unit = _this;
_UnitSide = (side _Unit);
_Array1 = [];
{
	_TargetSide = side _x;
	if ([_UnitSide, _TargetSide] call BIS_fnc_sideIsEnemy) then {_Array1 pushback _x;};
} forEach allUnits;

_ReturnedEnemy = [_Array1,_Unit] call VCOMAI_ClosestObject;
if (isNil "_ReturnedEnemy") then {_ReturnedEnemy = [0,0,0]};

//_Unit setVariable ["VCOM_CLOSESTENEMY",_ReturnedEnemy,false];
_ReturnedEnemy