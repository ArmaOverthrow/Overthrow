private ["_UnitSide","_Array1"];
_UnitSide = side (group _this);

_Array1 = [];
{
	if !((side _x) isEqualTo _UnitSide && !((side _x) isEqualTo CIVILIAN)) then {_Array1 pushback _x;};
} forEach allUnits;
_Array1