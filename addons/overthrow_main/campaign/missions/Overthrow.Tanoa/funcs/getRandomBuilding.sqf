private ["_found","_range","_houses","_house"];

_search = _this select 0;
_types = _this select 1;

_found = false;
_range = 500;
_house = false;
while {not _found} do {					
	_houses = nearestObjects [_search, _types, _range];
	_possible = [];
	if(count _houses > 0) then {
		{if !(_x call hasOwner) then {_possible pushback _x}}foreach(_houses);
		if(count _possible > 0) then {
			_house = _possible call BIS_fnc_selectRandom;		
			_found = true;	
		}		
	};
	_range = _range + 100;					
};

_house