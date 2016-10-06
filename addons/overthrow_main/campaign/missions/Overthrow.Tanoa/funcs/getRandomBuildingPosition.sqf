private ["_found","_range","_houses","_house","_pos"];

_search = _this select 0;
_type = _this select 1;

_found = false;
_range = 200;
_pos = [];
while {not _found} do {					
	_houses = _search nearObjects [_type,_range];					
	if(count _houses > 0) then {
		_house = _houses call BIS_fnc_selectRandom;
		_pos = _house buildingPos round(random 6);
		if((_pos select 0) != 0) then {
			_found = true;
		};
	};
	_range = _range + 50;					
};

_pos