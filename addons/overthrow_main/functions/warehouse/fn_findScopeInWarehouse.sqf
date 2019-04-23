params ["_range"];
private _found = "";
private _possible = [];
{
	private _d = warehouse getvariable [_x,[_x,0]];
	if(typename _d isEqualTo "ARRAY") then {
		_d params ["_cls","_num"];
		if(!isNil "_num") then {
			if(_num isEqualType 0 && {_num > 0} && {_cls in OT_allOptics}) then {
				private _allModes = "true" configClasses ( configFile >> "cfgWeapons" >> _cls >> "ItemInfo" >> "OpticsModes" );
				private _max = 0;
				{
					_max = _max max getNumber (_x >> "distanceZoomMax");
				}foreach(_allModes);

				if(_max >= _range) then {_possible pushback _cls};
			};
		}else{
			warehouse setvariable [_x,nil,true];
		};
	};
}foreach(allvariables warehouse);

if(count _possible > 0) then {
	private _sorted = [_possible,[],{(cost getvariable [_x,[200]]) select 0},"DESCEND"] call BIS_fnc_SortBy;
	_found = _sorted select 0;
};

_found
