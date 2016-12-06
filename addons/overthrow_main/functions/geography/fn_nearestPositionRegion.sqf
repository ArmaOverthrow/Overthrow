_things = _this select 0;
_region = _this select 2;

_ret = [];
{

	if([getpos _x,_region] call fnc_isInMarker) then {
		_ret pushBack _x;
	};
}foreach (_things);

[_ret,_this select 1] call BIS_fnc_nearestPosition
