private ["_Unit", "_WayPointPosition", "_UnitPos", "_direction", "_SetPosition","_MovementDistance","_NearestEnemy"];

_Unit = _this select 0;
_WayPointPosition = _this select 1;
_NearestEnemy = _this select 2;

//_UnitPos = getpos _Unit;
_UnitPos = getpos (leader _Unit);

_direction = [_UnitPos,_WayPointPosition] call BIS_fnc_dirTo;

if (_Unit distance _NearestEnemy < 150) then
{
	_MovementDistance = 25;
}
else
{
	_MovementDistance = 75;
};

_SetPosition = [_UnitPos,_MovementDistance,_direction] call BIS_fnc_relPos;
_SetPosition