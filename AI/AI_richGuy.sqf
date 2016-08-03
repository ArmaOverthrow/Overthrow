if (!isServer) exitwith {};

_region = _this select 0;

waitUntil{not isNil "AIT_economyInitDone"};

//find a home town in my region
_towns = server getVariable format["towns_%1",_region];

_possible = [];
{
	_pop = server getVariable format["population%1",_x];
	if(_pop > 500) then {
		_possible pushBack _x;		
	};
}foreach(_towns);

_town = _possible call BIS_fnc_selectRandom;

