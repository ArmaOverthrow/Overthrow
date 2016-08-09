private ["_id","_town","_posTown","_active","_groups","_soldiers","_numNATO","_pop","_count","_range"];
if (!isServer) exitwith {};

_active = false;

_count = 0;
_id = _this select 0;
_posTown = _this select 1;
_town = _this select 3;

_groups = [];
_soldiers = []; //Stores all soldiers for tear down

waitUntil{spawner getVariable _id};

while{true} do {
	//Do any updates here that should happen whether spawned or not
	
	//Main spawner
	if !(_active) then {
		if (spawner getVariable _id) then {
			_active = true;
			
			_numCRIM = server getVariable format ["numcrims%1",_town];
			
			if(_numCRIM > 0) then {
				_time = server getVariable format ["timecrims%1",_town];
				_leaderpos = server getVariable format["crimleader%1",_town];
				_group = objNULL;
				
				_skill = 0.7;
				if(_time > 0) then {
					_skill = 0.7 + (0.3 * (_time / 7200));
					if(_skill > 0.95) then {
						_skill = 0.95;
					};
				};				
				//Spawn stuff in			
				_count = 0;	
				_group = createGroup east;	
				_groups pushBack _group;					
				
				if ((typeName _leaderpos) == "ARRAY") then {
					_start = [[[_leaderpos,40]]] call BIS_fnc_randomPos;
					
					_civ = _group createUnit [AIT_CRIM_Units_Para call BIS_fnc_selectRandom, _start, [],0, "NONE"];
					[_civ] joinSilent _group;
					_civ setskill _skill;
					if(_time > 1200) then {
						_civ setRank "MAJOR";
					}else{
						if(_time > 600) then {
							_civ setRank "CAPTAIN";
						}else{
							_civ setRank "LIEUTENANT";
						};
					};
					
					_soldiers pushBack _civ;
					[_civ,_name] call initCrimLeader;
					_civ setBehaviour "SAFE";
					
					_count = _count + 1;					
					
					_wp = _group addWaypoint [_leaderpos,0];
					_wp setWaypointType "GUARD";				
					
					sleep 0.1;
				}else{
					_start = [[[_posTown,150]]] call BIS_fnc_randomPos;
					_group setBehaviour "CARELESS";	
		
					_wp = _group addWaypoint [_leaderpos,0];
					_wp setWaypointType "MOVE";
					_wp setWaypointSpeed "LIMITED";					
					_wp setWaypointTimeout [0, 5, 10];
					
					_end = [[[_posTown,150]]] call BIS_fnc_randomPos;
					
					_wp = _group addWaypoint [_end,0];
					_wp setWaypointType "MOVE";
					_wp setWaypointSpeed "LIMITED";
					_wp setWaypointTimeout [0, 5, 10];
					
					_wp = _group addWaypoint [_leaderpos,0];
					_wp setWaypointType "CYCLE";
					_wp setWaypointSpeed "LIMITED";
				};
				
				while {(spawner getVariable _id) and (_count < _numCRIM)} do {
					_start = [[[_leaderpos,40]]] call BIS_fnc_randomPos;
					
					_civ = _group createUnit [AIT_CRIM_Units_Bandit call BIS_fnc_selectRandom, _start, [],0, "NONE"];
					[_civ] joinSilent _group;
					if(_time > 1200) then {
						_civ setRank "LIEUTENANT";
					}else{
						if(_time > 600) then {
							_civ setRank "SERGEANT";
						}else{
							_civ setRank "CORPORAL";
						};
					};
					_soldiers pushBack _civ;
					[_civ,_town] call initCriminal;
					_civ setBehaviour "SAFE";
					
					sleep 0.1;
					_count = _count + 1;
				};
								
				{
					_x addCuratorEditableObjects [_soldiers,true];
				} forEach allCurators;
				sleep 1;
				{
					_x setDamage 0;
				}foreach(_soldiers);	
			}			
		}else{
			//Do updates here that should only happen while not spawned
			_newpos = server getVariable format["crimnew%1",_town];
			_addnum = server getVariable format["crimadd%1",_town];
			_current = server getVariable format["numcrims%1",_town];
			if((typename "_newpos") == "ARRAY") then {
				server setVariable [format["crimleader%1",_town],_newpos,false];	
				server setVariable [format["crimnew%1",_town],false,false];
			};
			server setVariable [format["numcrims%1",_town],_current+_addnum,false];	
			server setVariable [format["crimadd%1",_town],0,false];					
		}
	}else{
		if (spawner getVariable _id) then {
			//Do updates here that should happen only while spawned
			//...
			_newpos = server getVariable format["crimnew%1",_town];
			_addnum = server getVariable format["crimadd%1",_town];
			if((typename _newpos) == "ARRAY") then {				
				server setVariable [format["crimleader%1",_town],_newpos,true];
				_new = [_newpos,_addnum,_town] call newleader;
				[_soldiers,_new] call BIS_fnc_arrayPushStack;
				_groups pushback group(_new select 0);
			}else{
				if(_addnum > 0) then {
					_new = [_addnum,_town] call sendCrims;
					[_soldiers,_new] call BIS_fnc_arrayPushStack;
					_groups pushback group(_new select 0);
				};
			};
			server setVariable [format["crimnew%1",_town],false,false];
			_current = server getVariable format["numcrims%1",_town];
			server setVariable [format["numcrims%1",_town],_current+_addnum,false];	
			server setVariable [format["crimadd%1",_town],0,false];
		}else{			
			_active = false;
			//Tear it all down
			{				
				deleteVehicle _x;			
			}foreach(_soldiers);
			{				
				deleteGroup _x;			
			}foreach(_groups);
			_soldiers = [];
		};
	};
	sleep 1;
};