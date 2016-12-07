private ["_UnitSide"];
_UnitSide = side (group _this);

_Array1 = [];
{
	if ((side _x) isEqualTo _UnitSide && !(_x in (units (group _this)))) then {_Array1 pushback _x;};
} forEach allUnits;
_Array1