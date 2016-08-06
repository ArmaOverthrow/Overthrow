private ["_found","_range","_houses","_house"];

_search = _this select 0;
_types = _this select 1;

_found = false;
_range = 200;
_house = false;
while {not _found} do {					
	_houses = nearestObjects [_search, _types, _range];
	if(count _houses > 0) then {
		_house = _houses call BIS_fnc_selectRandom;		
		_found = true;		
	};
	_range = _range + 50;					
};

_house