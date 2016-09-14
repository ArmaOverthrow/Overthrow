private ["_id","_pos","_building","_tracked","_vehs","_group","_all","_shopkeeper","_groups"];
if (!isServer) exitwith {};

_active = false;
_spawned = false;

_count = 0;
_id = _this select 0;
_pos = _this select 1;
_mobsterid = _this select 3;

_groups = [];

waitUntil{spawner getVariable _id};

sleep 4;
while{true} do {
	//Do any updates here that should happen whether spawned or not
	_a = server getVariable [format["mobleader%1",_mobsterid],0];
	if(typename _a != "ARRAY") exitWith {};
	//Main spawner
	if !(_active) then {
		if (spawner getVariable _id) then {
			_active = true;
							
			_group = createGroup east;
			_groups pushback _group;
			_group setBehaviour "SAFE";
			_garrison = server getVariable [format["crimgarrison%1",_mobsterid],0];
			
			//the camp
			_veh = createVehicle ["Campfire_burning_F",_pos,[],0,"CAN_COLLIDE"];
			_groups pushback _veh;
			_dir = random 360;
			_flagpos = [_pos,2,_dir] call BIS_fnc_relPos;
			_veh = createVehicle [AIT_flag_CRIM,_flagpos,[],0,"CAN_COLLIDE"];
			_groups pushback _veh;
			sleep 0.1;
			_count = 0;
			_d = 0;
			while {_count < 8} do {
				_p = [_pos,10,_d] call SHK_pos;
				_cls = AIT_item_wrecks call BIS_fnc_selectRandom;
				_p = _p findEmptyPosition [1,50,_cls];
				_veh = createVehicle [_cls,_p,[],0,"CAN_COLLIDE"];
				_veh setDir (_d+90);
				_groups pushback _veh;
				_count = _count + 1;
				_d = _d + 45;
			};	
			sleep 0.1;
			_numtents = 2 + round(random 3);
			_count = 0;
			
			while {_count < _numtents} do {
				//this code is in tents
				_d = random 360;
				_p = [_pos,[2,9],_d] call SHK_pos;
				_p = _p findEmptyPosition [1,40,"Land_TentDome_F"];
				_veh = createVehicle ["Land_TentDome_F",_p,[],0,"CAN_COLLIDE"];
				_veh setDir _d;
				_groups pushback _veh;
				_count = _count + 1;
			};
			sleep 0.1;			
			
			//spawn in the crime boss
			_start = [[[_pos,40]]] call BIS_fnc_randomPos;
			_civ = _group createUnit [AIT_CRIM_Unit, _start, [],0, "NONE"];
			_civ setRank "COLONEL";
			[_civ] joinSilent nil;
			[_civ] joinSilent _group;
			_civ setVariable ["garrison",_mobsterid,true];
			_civ call initMobBoss;
			sleep 0.1;
			
			//spawn in his protection
			_count = 0;
			while {_count < _garrison} do {
				_start = [[[_pos,40]]] call BIS_fnc_randomPos;
				_civ = _group createUnit [AIT_CRIM_Unit, _start, [],0, "NONE"];
				_civ setRank "MAJOR";
				[_civ] joinSilent nil;
				[_civ] joinSilent _group;
				_civ setVariable ["garrison",_mobsterid,true];
				_civ call initMobster;
				_count = _count + 1;
			};
			
			_wp = _group addWaypoint [_flagpos,0];
			_wp setWaypointType "GUARD";
		};
	}else{
		if (spawner getVariable _id) then {
			//Do updates here that should happen only while spawned
			//...
			
		}else{			
			_active = false;
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
			_groups = [];
		};
	};
	sleep 2;
};