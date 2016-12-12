while{true} do {
    sleep 0.5;
	OT_activeClients = [];
	//Get all headless clients
	OT_serverTakesLoad = false;
	{
		if (_x in allPlayers) then {
			OT_activeClients pushback _x;
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
    					_x call OT_fnc_despawn;
    					sleep 0.1;
                    };
                };
            }else{
                if (_start call OT_fnc_inSpawnDistance) then {
                    OT_allSpawned pushback _id;
					_x call OT_fnc_spawn;
					sleep 0.1;
                };
            };
        }else{
            if(_val) then {
                if !((_start call OT_fnc_inSpawnDistance) || (_end call OT_fnc_inSpawnDistance)) then {
                    if((time - _time) > 30) then {
                        OT_allSpawned deleteAt _spawnidx;
    					_x call OT_fnc_despawn;
    					sleep 0.1;
                    };
                };
            }else{
                if ((_start call OT_fnc_inSpawnDistance) || (_end call OT_fnc_inSpawnDistance)) then {
                    OT_allSpawned pushback _id;
					_x call OT_fnc_spawn;
					sleep 0.1;
                };
            };
        };
    }foreach(OT_allspawners);
}
