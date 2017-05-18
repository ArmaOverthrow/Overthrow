//Setup our spawners

{
	private ["_p","_i"];
	_p = _x select 0;
	_i = _x select 1;
	[_p,OT_fnc_spawnBusinessEmployees,[_p,_i]] call OT_fnc_registerSpawner;
}foreach(OT_economicData);

waitUntil {!isNil "OT_economyLoadDone"};
{
    _x params ["_cls","_name","_side"];
	_pos = server getVariable [format["factionrep%1",_cls],[]];
    if(count _pos > 0) then {
	       [_pos,OT_fnc_spawnFactionRep,[_cls,_name]] call OT_fnc_registerSpawner;
    }
}foreach(OT_allFactions);

{
	_name = _x select 1;
	_pos = _x select 0;
	[_pos,OT_fnc_spawnNATOObjective,[_pos,_name]] call OT_fnc_registerSpawner;
}foreach(OT_NATOobjectives + OT_NATOcomms);

{
	_pos = getMarkerPos _x;
	[_pos,OT_fnc_spawnNATOCheckpoint,[_pos,_x]] call OT_fnc_registerSpawner;
}foreach(OT_NATO_control);

OT_townSpawners = [
	OT_fnc_spawnCivilians,
	OT_fnc_spawnGendarmerie,
	OT_fnc_spawnPolice,
	OT_fnc_spawnCarDealers,
	OT_fnc_spawnGunDealer,
	OT_fnc_spawnAmbientVehicles,
	OT_fnc_spawnShops,
	OT_fnc_spawnBoatDealers
];

{
	private _pos = server getVariable _x;
	private _town = _x;
	[_pos,{
			params ["_spawntown","_spawnid"];
			{
				_hdl = [_spawntown,_spawnid] spawn _x;
				waitUntil {sleep 0.2;scriptDone _hdl};
				sleep 0.5;
			}foreach(OT_townSpawners);
	},[_town]] call OT_fnc_registerSpawner;
}foreach(OT_allTowns);

//Start Virtualization Loop
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
