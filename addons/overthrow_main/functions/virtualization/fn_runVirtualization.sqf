//Setup our spawners
diag_log "Overthrow: Virtualization start";
{
	private ["_p","_i"];
	_p = _x select 0;
	_i = _x select 1;
	[_p,OT_fnc_spawnBusinessEmployees,[_p,_i]] call OT_fnc_registerSpawner;
}foreach(OT_economicData);

diag_log format["Overthrow: %1 businesses virtualized",count OT_economicData];

waitUntil {!isNil "OT_economyLoadDone"};

_count = 0;
{
    _x params ["_cls","_name","_side"];
	_pos = server getVariable [format["factionrep%1",_cls],[]];
    if(count _pos > 0) then {
		_count = _count + 1;
		[_pos,OT_fnc_spawnFactionRep,[_cls,_name]] call OT_fnc_registerSpawner;
    }
}foreach(OT_allFactions);

diag_log format["Overthrow: %1 faction reps virtualized",_count];

private _allobs = OT_NATOobjectives + OT_NATOcomms;
{
	_name = _x select 1;
	_pos = _x select 0;
	[_pos,OT_fnc_spawnNATOObjective,[_pos,_name]] call OT_fnc_registerSpawner;
}foreach(_allobs);

diag_log format["Overthrow: %1 objectives virtualized",count _allobs];

{
	_pos = getMarkerPos _x;
	[_pos,OT_fnc_spawnNATOCheckpoint,[_pos,_x]] call OT_fnc_registerSpawner;
}foreach(OT_NATO_control);

diag_log format["Overthrow: %1 checkpoints virtualized",count OT_NATO_control];

OT_townSpawners = [
	OT_fnc_spawnShops,
	OT_fnc_spawnCivilians,
	OT_fnc_spawnGendarmerie,
	OT_fnc_spawnPolice,
	OT_fnc_spawnCarDealers,
	OT_fnc_spawnGunDealer,
	OT_fnc_spawnAmbientVehicles,
	OT_fnc_spawnBoatDealers
];

{
	private _pos = server getVariable _x;
	private _town = _x;
	[_pos,{
			params ["_spawntown","_spawnid"];
			{
				_hdl = [_spawntown,_spawnid] spawn _x;
				sleep 0.2;
			}foreach(OT_townSpawners);
	},[_town]] call OT_fnc_registerSpawner;
}foreach(OT_allTowns);

diag_log format["Overthrow: %1 towns virtualized",count OT_allTowns];

//Start Virtualization Loop
while{true} do {
    sleep 0.5;
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
    					_x spawn OT_fnc_despawn;
    					sleep 0.2;
                    };
                };
            }else{
                if (_start call OT_fnc_inSpawnDistance) then {
                    OT_allSpawned pushback _id;
					_x spawn OT_fnc_spawn;
					sleep 0.2;
                };
            };
        }else{
            if(_val) then {
                if !((_start call OT_fnc_inSpawnDistance) || (_end call OT_fnc_inSpawnDistance)) then {
                    if((time - _time) > 30) then {
                        OT_allSpawned deleteAt _spawnidx;
    					_x spawn OT_fnc_despawn;
    					sleep 0.2;
                    };
                };
            }else{
                if ((_start call OT_fnc_inSpawnDistance) || (_end call OT_fnc_inSpawnDistance)) then {
                    OT_allSpawned pushback _id;
					_x spawn OT_fnc_spawn;
					sleep 0.2;
                };
            };
        };
    }foreach(OT_allspawners);
}
