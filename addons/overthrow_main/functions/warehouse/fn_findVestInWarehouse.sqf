private _found = "";
private _possible = [];
{
	private _d = warehouse getvariable [_x,false];
	if(_d isEqualType []) then {
		_d params ["_cls",["_num",0,[0]]];
		if(_num > 0 && {_cls in OT_allVests}) then {
			_possible pushback _cls;
		};
	};
}foreach((allVariables warehouse) select {((toLower _x select [0,5]) isEqualTo "item_")});

if(count _possible > 0) then {
	private _sorted = [_possible,[],{(cost getvariable [_x,[200]]) select 0},"DESCEND"] call BIS_fnc_SortBy;
	_found = _sorted select 0;
};

_found
