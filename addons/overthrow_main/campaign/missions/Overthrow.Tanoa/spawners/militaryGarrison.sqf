private ["_id","_town","_posTown","_active","_groups","_numNATO","_pop","_count","_range"];
if (!isServer) exitwith {};

_active = false;

_count = 0;
_id = _this select 0;
_posTown = _this select 1;
_name = _this select 3;

_groups = [];

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
			if(_numNATO == 0) exitWith {};
			
			//Make sure the first group spawned in at a comms base are a sniper, spotter, AA specialist and AA assistant
			_count = 0;
			if(_name find "Comms" == 0) then {
				_tower = nearestObjects [_posTown,OT_NATO_CommTowers,100] select 0;
				_posTown = getpos _tower;
				
				_group = createGroup blufor;							
				_groups pushBack _group;
				
				_civ = _group createUnit [OT_NATO_Unit_Sniper, _posTown, [],0, "NONE"];
				_civ setVariable ["garrison",_name,false];
				_civ setRank "CAPTAIN";
				[_civ,_name] call initSniper;
				_civ setBehaviour "SAFE";
				_civ action ["ladderOnUp", _tower, 0, 0];
								
				_count = _count + 1;
				
				if(_count < _numNATO) then {
					sleep 2;
					_civ = _group createUnit [OT_NATO_Unit_Spotter, _posTown, [],0, "NONE"];
					_civ setVariable ["garrison",_name,false];
					_civ setRank "CAPTAIN";
					[_civ,_name] call initSniper;
					_civ setBehaviour "SAFE";
					_civ action ["ladderOnUp", _tower, 0, 0];
					_count = _count + 1;
					sleep 0.1;
				};
				
				if(_count < _numNATO) then {
					_group = createGroup blufor;							
					_groups pushBack _group;
					_start = [[[_posTown,75]]] call BIS_fnc_randomPos;
					_civ = _group createUnit [OT_NATO_Unit_AA_spec, _start, [],0, "NONE"];
					_civ setVariable ["garrison",_name,false];
					_civ setRank "CAPTAIN";
					[_civ,_name] call initMilitary;
					_civ setBehaviour "SAFE";
					_count = _count + 1;
					
					_wp = _group addWaypoint [getpos _tower,0];
					_wp setWaypointType "GUARD";
					_wp setWaypointBehaviour "SAFE";
					_wp setWaypointSpeed "LIMITED";
					
					sleep 0.1;
				};
				
				if(_count < _numNATO) then {
					_start = [[[_posTown,75]]] call BIS_fnc_randomPos;
					_civ = _group createUnit [OT_NATO_Unit_AA_ass, _start, [],0, "NONE"];
					_civ setVariable ["garrison",_name,false];
					_civ setRank "CAPTAIN";
					[_civ,_name] call initMilitary;
					_civ setBehaviour "SAFE";
					_count = _count + 1;
					sleep 0.1;
				};
				
			}else{
				//put up a flag
				_flag =  OT_flag_NATO createVehicle _posTown;
				_groups pushback _flag;
			};			
			
			_range = 100;
			_groupcount = 0;
			while {(spawner getVariable _id) and (_count < _numNATO)} do {			
				_start = [[[_posTown,75]]] call BIS_fnc_randomPos;
				_group = createGroup blufor;							
				_groups pushBack _group;	
				_groupcount = 1;
				
				_civ = _group createUnit [OT_NATO_Unit_LevelOneLeader, _start, [],0, "NONE"];
				_civ setVariable ["garrison",_name,false];
				_civ setRank "CAPTAIN";
				[_civ,_name] call initMilitary;
				_civ setBehaviour "SAFE";
				
				_count = _count + 1;
				sleep 0.1;
				while {(spawner getVariable _id) and (_count < _numNATO) and (_groupcount < 8)} do {
					_start = [_start,0,40, 1, 0, 0, 0] call BIS_fnc_findSafePos;		
					
					_civ = _group createUnit [OT_NATO_Units_LevelOne call BIS_fnc_selectRandom, _start, [],0, "NONE"];
					_civ setVariable ["garrison",_name,false];
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
				
			
			_pos = [];
			_dir = 0;
			_terminal = nearestobjects [_posTown,OT_airportTerminals,350];
			if(count _terminal > 0) then {
				_tp = getpos (_terminal select 0);
				_dir = getdir (_terminal select 0);
				_dist = 35;
				if(typeof (_terminal select 0) == "Land_Hangar_F") then {
					_dir = _dir + 180;
					_dist = 50;
				};
				_pos = [_tp,_dist,_dir] call BIS_fnc_relPos;
				_pos = [_pos,100,_dir-90] call BIS_fnc_relPos;
			}else{
				_dir = 80;
				_pos = [_posTown,20,_dir] call BIS_fnc_relPos;
				_pos = [_pos,130,_dir-90] call BIS_fnc_relPos;
			};
			_airgarrison = server getVariable [format["airgarrison%1",_name],[]];
			{				
				_vehtype = _x;
				
				_pos = [_pos,42,_dir+90] call BIS_fnc_relPos;
												
				_veh =  _vehtype createVehicle _pos;
				_veh setVariable ["airgarrison",_name,false];					
				
				_veh setDir _dir;
				
				_groups pushback _veh;
				sleep 0.1;				
			}foreach(_airgarrison);
			sleep 0.5;
			_vehgarrison = server getVariable [format["vehgarrison%1",_name],[]];
			_pos = [];
			_road = objNull;
			{
				_vgroup = creategroup blufor;
				_groups pushback _vgroup;
				_vehtype = _x;
				_dir = 0;
				_got = false;				
				if(_vehtype in OT_staticWeapons) then {
					_pos = _posTown findEmptyPosition [10,50,_vehtype];					
					_dir = [_posTown,_pos] call BIS_fnc_dirTo;
					_p = [_pos,1.5,_dir] call BIS_fnc_relPos;
					_veh =  "Land_BagFence_Round_F" createVehicle _p;	
					_veh setpos _p;
					_veh setDir (_dir-180);				
					_groups pushback _veh;	
					_p = [_pos,-1.5,_dir] call BIS_fnc_relPos;
					_veh =  "Land_BagFence_Round_F" createVehicle _p;	
					_veh setpos _p;					
					_veh setDir (_dir);				
					_groups pushback _veh;					
				}else{						
					_pos = [_posTown, 10, 100, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
					_dir = random 360;
				};
				_veh =  _vehtype createVehicle _pos;
				_veh setpos _pos;
				_veh setVariable ["vehgarrison",_name,false];
				
				_veh setDir _dir;
				if(random 100 < 99) then {
					createVehicleCrew _veh;
				};
				_groups pushback _veh;
				sleep 0.1;
				{
					[_x] joinSilent _vgroup;
					_x setVariable ["garrison","HQ",false];
				}foreach(crew _veh);
				_vgroup call initMilitaryPatrol;
			}foreach(_vehgarrison);
		};
	}else{
		if (spawner getVariable _id) then {
			//Do updates here that should happen only while spawned
			//...
		}else{			
			_active = false;
			//Tear it all down
			{	
				if(typename _x == "GROUP") then {
					{
						sleep 0.05;				
						if !(_x call hasOwner) then {
							deleteVehicle _x;
						};	
					}foreach(units _x);
					deleteGroup _x;					
				}else{
					if !(_x call hasOwner) then {
						deleteVehicle _x;
					};	
				};		
				sleep 0.05;
			}foreach(_groups);
		};
	};
	sleep 2;
};