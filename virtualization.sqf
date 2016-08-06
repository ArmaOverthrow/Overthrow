private ["_uniqueCounter","_allspawners","_id","_start","_end"];

AIT_spawnUniqueCounter = -1;
publicVariable "AIT_spawnUniqueCounter";

AIT_allspawners = [];
publicVariable "AIT_allspawners";

AIT_fnc_registerSpawner = {
	_pos = _this select 0;
	_code = _this select 1;
	_params = [];
	if(count _this > 2) then {
		_params = _this select 2;
	};
	_start = [];
	_end = [];
	
	if(count _pos == 2) then {
		_start = _pos select 0;
		_end = _pos select 1;
	}else{
		_start = _pos;
		_end = _pos;
	};
	
	AIT_spawnUniqueCounter = AIT_spawnUniqueCounter + 1;
	publicVariable "AIT_spawnUniqueCounter";
	_id = format["spawn%1",AIT_spawnUniqueCounter];
	publicVariable "AIT_spawnUniqueCounter";
	
	spawner setvariable [_id,false,true];
	AIT_allspawners pushBack [_id,_start,_end];
	
	[_id,_start,_end,_params] spawn _code;
	AIT_spawnUniqueCounter
};
publicVariable "AIT_fnc_registerSpawner";

while{true} do {
	sleep 0.1;	
	{
		_id = _x select 0;
		_start = _x select 1;
		_end = _x select 1;
		if((_start distance _end) > 1) then {
			if((_start call inSpawnDistance) || (_end call inSpawnDistance)) then {
				spawner setvariable [_id,true,false];
			}else{
				spawner setvariable [_id,false,false];
			}
		}else{
			if(_start call inSpawnDistance) then {
				spawner setvariable [_id,true,false];
			}else{
				spawner setvariable [_id,false,false];
			}
		};
	}foreach(AIT_allspawners);
}