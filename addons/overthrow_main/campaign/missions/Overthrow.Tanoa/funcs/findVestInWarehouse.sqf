private _found = "";
private _possible = [];
{
	private _d = warehouse getvariable [_x,[_x,0]];
	private _cls = _d select 0;
	private _num = _d select 1;
	if(_num > 0 and (_cls in OT_allVests)) then {
		_possible pushback _cls;
	};
}foreach(allvariables warehouse);

if(count _possible > 0) then {
	_sorted = [_possible,[],{(cost getvariable [_x,[200]]) select 0},"DESCEND"] call BIS_fnc_SortBy;
	_found = _sorted select 0;
};

_found