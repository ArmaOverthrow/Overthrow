_Unit = _this select 0;
if (isPlayer _Unit) exitWith {};
if ((vehicle _Unit) != _Unit) exitWith {};


//Lay down
_Unit setUnitPosWeak "DOWN";
[_Unit,false,false,false,false] spawn VCOMAI_MoveToCover;