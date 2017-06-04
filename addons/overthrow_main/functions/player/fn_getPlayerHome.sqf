_pos = server getVariable _this;
_range = 200;
_found = false;
_house = objNull;
while {!_found and _range < 1200} do {
	_houses = nearestObjects [_pos, ["house"], _range,false];
	_possible = [];
	if(count _houses > 0) then {
		{
			if (!(_x call OT_fnc_hasOwner) and (typeof _x) in OT_spawnHouses) then {
				_possible pushback _x
			};
		}foreach(_houses);

		if(count _possible > 0) then {
			_house = selectRandom _possible;
			_found = true;
		}
	};
	_range = _range + 100;
};

if(!_found) exitWith {
    //Spawn town is full, make a new one
    _town = (OT_spawnTowns - [_town]) call BIS_fnc_selectrandom;
    server setVariable ["spawntown",_town,true];
    _town call OT_fnc_getPlayerHome;
};

_house
