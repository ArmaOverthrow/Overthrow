_things = _this select 0;
_region = _this select 2;

_ret = [];
{

	if(_x inArea _region) then {
		_ret pushBack _x;
	};
}foreach (_things);

[_ret,_this select 1] call BIS_fnc_nearestPosition
