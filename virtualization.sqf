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
	_same = true;
	if((count _pos) == 2) then {
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
	
	if(typename _code == "ARRAY")then {
		{
			[_id,_start,_end,_params] spawn _x;
		}foreach(_code);
	}else{
		[_id,_start,_end,_params] spawn _code;
	};
	AIT_spawnUniqueCounter
};
publicVariable "AIT_fnc_registerSpawner";

AIT_fnc_deregisterSpawner = {	
	_found = false;
	_idx = -1;
	{
		_idx = _idx + 1;
		_id = _x select 0;
		if(_id == _this) exitWith{_found = true};		
	}foreach(AIT_allspawners);
	if(_found) then {
		AIT_allspawners deleteAt _idx;
	};
};

AIT_fnc_updateSpawnerPosition = {	
	_changeid = _this select 0;
	_start = _this select 1;
	_end = _this select 2;

	{
		_id = _x select 0;
		if(_id == _changeid) exitWith{
			_x set[1,_start];
			_x set[2,_end];
		};		
	}foreach(AIT_allspawners);
};

_last = time;
while{true} do {
	if (time - _last >= 0.2) then {sleep 0.1} else {sleep 0.2 - (time - _last)};
	_last = time;	
	{
		_id = _x select 0;
		_start = _x select 1;
		_end = _x select 2;
		_val = spawner getvariable [_id,false];
		
		if(_val) then {
			if !((_start call inSpawnDistance) || (_end call inSpawnDistance)) then {
				spawner setvariable [_id,false,false];
			};
		}else{
			if ((_start call inSpawnDistance) || (_end call inSpawnDistance)) then {
				spawner setvariable [_id,true,false];
			};
		};
	}foreach(AIT_allspawners);
}