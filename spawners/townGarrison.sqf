private ["_id","_town","_posTown","_active","_groups","_numNATO","_pop","_count","_range"];
if (!isServer) exitwith {};

_active = false;

_count = 0;
_id = _this select 0;
_posTown = _this select 1;
_town = _this select 3;

_groups = [];

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
			_range = 300;
			_pergroup = 4;
						
			while {(spawner getVariable _id) and (_count < _numNATO)} do {
				_groupcount = 0;
				_group = createGroup blufor;				
				_groups pushBack _group;
				
				_start = [[[_posTown,_range]]] call BIS_fnc_randomPos;
				_civ = _group createUnit [AIT_NATO_Unit_PoliceCommander, _start, [],0, "NONE"];
				_civ setVariable ["garrison",_town,false];

				_civ setRank "CORPORAL";
				_civ setBehaviour "SAFE";
				[_civ,_town] call initPolice;
				_count = _count + 1;
				_groupcount = _groupcount + 1;
				
				while {(spawner getVariable _id) and (_groupcount < _pergroup) and (_count < _numNATO)} do {							
					_pos = [[[_start,50]]] call BIS_fnc_randomPos;
					
					_civ = _group createUnit [AIT_NATO_Unit_Police, _pos, [],0, "NONE"];
					_civ setVariable ["garrison",_town,false];

					_civ setRank "PRIVATE";
					[_civ,_town] call initPolice;
					_civ setBehaviour "SAFE";
					
					_groupcount = _groupcount + 1;
					_count = _count + 1;
				};				
				_group call initPolicePatrol;				
				_range = _range + 50;
			};
			
			{
				_cur = _x;
				{	
					_cur addCuratorEditableObjects [(units _x),true];				
				}foreach(_groups);				
			} forEach allCurators;
			
			sleep 1;
			{	
				{					
					_x setDamage 0;							
				}foreach(units _x);							
			}foreach(_groups);		
		}else{
			_need = server getVariable [format ["garrisonadd%1",_town],0];			
			if(_need > 1) then {		
				server setVariable[format ["garrisonadd%1",_town],_need-2,false];
				server setVariable[format ["garrison%1",_town],_numNATO+2,false];
			}			
		};
	}else{
		if (spawner getVariable _id) then {
			//Do updates here that should happen only while spawned
			//...
			_need = server getVariable [format ["garrisonadd%1",_town],0];			
			if(_need > 1) then {
				_town spawn reGarrisonTown;				
				server setVariable[format ["garrisonadd%1",_town],_need-2,false];
			}			
		}else{			
			_active = false;
			//Tear it all down
			{	
				{		
					sleep 0.1;
					deleteVehicle _x;							
				}foreach(units _x);
				deleteGroup _x;								
			}foreach(_groups);
			_groups = [];
		};
	};
	sleep 2;
	
	_numNATO = server getVariable [format["garrison%1",_town],0];
};