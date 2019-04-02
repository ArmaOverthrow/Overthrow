private _pos = server getVariable _this;
private _range = 200;
private _found = false;
private _house = objNull;
while {!_found && _range < 1200} do {
	private _houses = nearestObjects [_pos, ["house"], _range,false];
	private _possible = [];
	if(count _houses > 0) then {
		{
			if (!(_x call OT_fnc_hasOwner) && (typeof _x) in OT_spawnHouses) then {
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
    _town = selectRandom (OT_spawnTowns - [_this]);
    server setVariable ["spawntown",_town,true];
    _town call OT_fnc_getPlayerHome;
};

_house
