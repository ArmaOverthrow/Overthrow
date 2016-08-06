private ["_town","_posTown","_active","_groups","_police","_numNATO","_pop","_count","_range"];
if (!isServer) exitwith {};

_active = false;

_count = 0;
_id = _this select 0;
_posTown = _this select 1;
_town = _this select 3;

_groups = [];
_police = []; //Stores all civs for tear down

waitUntil{spawner getVariable _id};



while{true} do {
	//Do any updates here that should happen whether spawned or not
	if(_town in (server getVariable "NATOabandoned")) exitWith{};
	//Main spawner
	if !(_active) then {
		if (spawner getVariable _id) then {
			_active = true;
			//Spawn stuff in
			_numNATO = server getVariable format["garrison%1",_town];
			_count = 0;
			_range = 100;
			while {(spawner getVariable _id) and (_count < _numNATO)} do {
				_left = _numNATO - _count;
				_group = createGroup blufor;
						
				_groups pushBack _group;
				
				_start = [_posTown,_range-100,_range, 1, 0, 0, 0] call BIS_fnc_findSafePos;						
				if(_left < 2) then {
					_civ = _group createUnit [AIT_NATO_Unit_PoliceCommander, _start, [],0, "NONE"];
					_police pushBack _civ;
					_civ setBehaviour "SAFE";
					[_civ,_town] call initPolice;
					_count = _count + 1;
				}else {
					_civ = _group createUnit [AIT_NATO_Unit_PoliceCommander, _start, [],0, "NONE"];
					_police pushBack _civ;
					[_civ,_town] call initPolice;
					_civ setBehaviour "SAFE";
					sleep 0.01;
					_start = [_start, 0, 50, 1, 0, 0, 0] call BIS_fnc_findSafePos;
					_civ = _group createUnit [AIT_NATO_Unit_Police, _start, [],0, "NONE"];
					_police pushBack _civ;
					[_civ,_town] call initPolice;
					_civ setBehaviour "SAFE";
					_count = _count + 2;
				};
				_group call initPolicePatrol;
				_range = _range + 50;
				
				sleep 0.1;
			};
			{
				_x addCuratorEditableObjects [_police,true];
			} forEach allCurators;
			sleep 1;
			{
				_x setDamage 0;
			}foreach(_police);			
		};
	}else{
		if (spawner getVariable _id) then {
			//Do updates here that should happen only while spawned
			//...
			_need = server getVariable format ["garrisonadd%1",_town];			
			if(_need > 1) then {
				[_police,_town call reGarrisonTown] call BIS_fnc_arrayPushStack;
				server setVariable[format ["garrisonadd%1",_town],_need-2,true];
			}			
		}else{			
			_active = false;
			//Tear it all down
			{				
				deleteVehicle _x;			
			}foreach(_police);
			{				
				deleteGroup _x;			
			}foreach(_groups);
			_police = [];
		};
	};
	sleep 1;
	
	_numNATO = server getVariable format["garrison%1",_town];
};