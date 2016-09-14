_region = _this select 0;

_ret = [];
{
	if([_x,_region] call fnc_isInMarker) then {
		_ret pushBack _x;
	};
}foreach (OT_allTowns);

_ret