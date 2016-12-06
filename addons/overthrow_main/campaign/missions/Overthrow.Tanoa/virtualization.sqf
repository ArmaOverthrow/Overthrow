OT_spawnUniqueCounter = -1;

OT_allspawners = [];

OT_fnc_registerSpawner = {
    private ["_pos","_code","_params","_start","_end","_id"];
    _pos = _this select 0;
    _code = _this select 1;
    _params = [];


    if(count _this > 2) then {
        _params = _this select 2;
    };
    _start = [];
    _end = [];
    if((count _pos) == 2) then {
        _start = _pos select 0;
        _end = _pos select 1;
    }else{
        _start = _pos;
        _end = _pos;
    };

    OT_spawnUniqueCounter = OT_spawnUniqueCounter + 1;

    _id = format["spawn%1",OT_spawnUniqueCounter];

    OT_allspawners pushBack [_id,_start,_end,_code,_params,0];

    OT_spawnUniqueCounter
};
publicVariable "OT_fnc_registerSpawner";

OT_fnc_deregisterSpawner = {
    _found = false;
    _idx = -1;
    {
        _idx = _idx + 1;
        _id = _x select 0;
        if(_id == _this) exitWith{_found = true};
    }foreach(OT_allspawners);
    if(_found) then {
        OT_allspawners deleteAt _idx;
    };
};

OT_fnc_updateSpawnerPosition = {
    _changeid = _this select 0;
    _start = _this select 1;
    _end = _this select 2;

    {
        _id = _x select 0;
        if(_id == _changeid) exitWith{
            _x set[1,_start];
            _x set[2,_end];
        };
    }foreach(OT_allspawners);
};

OT_allSpawned = [];

_spawn = {
	params ["_i","_s","_e","_c","_p","_sp"];

	(_p + [_i]) spawn _c;
    _this set [5,time];
};

_despawn = {
	params ["_i","_s","_e","_c","_p"];

	{
		if(typename _x == "GROUP") then {
			{
				if !(_x call OT_fnc_hasOwner) then {
					deleteVehicle _x;
				};
			}foreach(units _x);
			deleteGroup _x;
		}else{
			if !(_x call OT_fnc_hasOwner) then {
				deleteVehicle _x;
			};
		};
	}foreach(spawner getVariable [_i,[]]);
	spawner setVariable [_i,[],false];
};

OT_activeClients = [];
OT_serverTakesLoad = false;

while{true} do {
    sleep 0.5;
	OT_activeClients = [];
	//Get all headless clients
	OT_serverTakesLoad = false;
	{
		if (_x in allPlayers) then {
			OT_activeClients pushback _x;
			OT_activeClients pushback _x;
			OT_activeClients pushback _x;//Thrice for weight in random sel
		};
	} forEach (entities "HeadlessClient_F");
	//If no headless clients and less than 6 players, server will take load
	if(count OT_activeClients == 0) then {
		if(count allplayers < 6) then {
			OT_serverTakesLoad = true;
		}else{
			OT_serverTakesLoad = false;
		};
		OT_activeClients = [] call CBA_fnc_players;
	}else{
		[OT_activeClients,[] call CBA_fnc_players] call BIS_fnc_arrayPushStack;
	};
    {
        private _id = _x select 0;
        private _start = _x select 1;
        private _end = _x select 2;
        private _time = _x select 5;
		private _spawnidx = OT_allSpawned find _id;
        private _val = (_spawnidx > -1);

        if((_start select 0) == (_end select 0)) then {
            if(_val) then {
                if !(_start call OT_fnc_inSpawnDistance) then {
                    if((time - _time) > 30) then { //Ensures it stays spawned for minimum 30 seconds
                        OT_allSpawned deleteAt _spawnidx;
    					_x call _despawn;
    					sleep 0.1;
                    };
                };
            }else{
                if (_start call OT_fnc_inSpawnDistance) then {
                    OT_allSpawned pushback _id;
					_x call _spawn;
					sleep 0.1;
                };
            };
        }else{
            if(_val) then {
                if !((_start call OT_fnc_inSpawnDistance) || (_end call OT_fnc_inSpawnDistance)) then {
                    if((time - _time) > 30) then {
                        OT_allSpawned deleteAt _spawnidx;
    					_x call _despawn;
    					sleep 0.1;
                    };
                };
            }else{
                if ((_start call OT_fnc_inSpawnDistance) || (_end call OT_fnc_inSpawnDistance)) then {
                    OT_allSpawned pushback _id;
					_x call _spawn;
					sleep 0.1;
                };
            };
        };
    }foreach(OT_allspawners);
}
