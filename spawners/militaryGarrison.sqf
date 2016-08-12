private ["_id","_town","_posTown","_active","_groups","_soldiers","_numNATO","_pop","_count","_range"];
if (!isServer) exitwith {};

_active = false;

_count = 0;
_id = _this select 0;
_posTown = _this select 1;
_name = _this select 3;

_groups = [];
_soldiers = []; //Stores all soldiers for tear down

waitUntil{spawner getVariable _id};

while{true} do {
	//Do any updates here that should happen whether spawned or not
	if(_name in (server getVariable "NATOabandoned")) exitWith{};
	
	//Main spawner
	if !(_active) then {
		if (spawner getVariable _id) then {
			_active = true;
			//Spawn stuff in			
			_numNATO = server getVariable format["garrison%1",_name];
			
			_count = 0;
			_range = 100;
			_groupcount = 0;
			while {(spawner getVariable _id) and (_count < _numNATO)} do {			
				_start = [[[_posTown,75]]] call BIS_fnc_randomPos;
				_group = createGroup blufor;							
				_groups pushBack _group;	
				_groupcount = 1;
				
				_civ = _group createUnit [AIT_NATO_Unit_LevelOneLeader, _start, [],0, "NONE"];
				_civ setVariable ["garrison",_name,false];
				_civ setRank "CAPTAIN";
				_soldiers pushBack _civ;
				[_civ,_name] call initMilitary;
				_civ setBehaviour "SAFE";
				
				_count = _count + 1;
				sleep 0.1;
				while {(spawner getVariable _id) and (_count < _numNATO) and (_groupcount < 8)} do {
					_start = [_start,0,40, 1, 0, 0, 0] call BIS_fnc_findSafePos;		
					
					_civ = _group createUnit [AIT_NATO_Units_LevelOne call BIS_fnc_selectRandom, _start, [],0, "NONE"];
					_civ setVariable ["garrison",_name,false];
					_soldiers pushBack _civ;
					_civ setRank "LIEUTENANT";
					[_civ,_name] call initMilitary;
					_civ setBehaviour "SAFE";
					
										
					sleep 0.1;
					_count = _count + 1;
					_groupcount = _groupcount + 1;
				};
				_group call initMilitaryPatrol;
				_range = _range + 50;
			};
			{
				_x addCuratorEditableObjects [_soldiers,true];
			} forEach allCurators;
			sleep 1;
			{
				_x setDamage 0;
			}foreach(_soldiers);			
		};
	}else{
		if (spawner getVariable _id) then {
			//Do updates here that should happen only while spawned
			//...
		}else{			
			_active = false;
			//Tear it all down
			{
				sleep 0.1;
				deleteVehicle _x;			
			}foreach(_soldiers);
			{				
				deleteGroup _x;			
			}foreach(_groups);
			_soldiers = [];
		};
	};
	sleep 2;
};