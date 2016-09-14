private ["_id","_town","_posTown","_active","_groups","_soldiers","_numNATO","_pop","_count","_range"];
if (!isServer) exitwith {};

_active = false;

_count = 0;
_id = _this select 0;
_start = _this select 1;
_name = _this select 3;

_groups = [];
_soldiers = []; //Stores all soldiers for tear down
_vehs = [];

waitUntil{spawner getVariable _id};

while{true} do {
	//Do any updates here that should happen whether spawned or not
	if(_name in (server getVariable "NATOabandoned")) exitWith{};
	
	//Main spawner
	if !(_active) then {
		if (spawner getVariable _id) then {
			_active = true;
			//Spawn stuff in	

			_road = [_start] call BIS_fnc_nearestRoad;
			_start = getPos _road;
			_vehtype = AIT_vehTypes_civ call BIS_Fnc_selectRandom;
			
			_roadscon = roadsConnectedto _road;
			_dir = [_road, _roadscon select 0] call BIS_fnc_DirTo;
			
			_vehs = [_start,_dir,template_checkpoint] call BIS_fnc_objectsMapper;
						
			_numNATO = server getVariable format["garrison%1",_name];
			if(isNil "_numNATO") then {
				//New checkpoint was added to game
				_numNATO = 4 + (random 4);
				server setVariable [format["garrison%1",_name],_numNATO,true];
			};
			
			_count = 0;
			_range = 100;
			_groupcount = 0;
	
			_group = createGroup blufor;							
			_groups pushBack _group;	
			_groupcount = 1;
			
			_start = [_start,12,_dir+90] call BIS_fnc_relPos;
			
			_civ = _group createUnit [AIT_NATO_Unit_LevelOneLeader, _start, [],0, "NONE"];
			_civ setVariable ["garrison",_name,false];
			_civ setRank "MAJOR";
			_soldiers pushBack _civ;
			[_civ,_name] call initMilitary;
			_civ setBehaviour "SAFE";
			
			{
				if(typeof _x in AIT_staticMachineGuns) then {
					_group addVehicle _x;
				};
			}foreach(_vehs);
			
			_count = _count + 1;
			sleep 0.1;
			while {(spawner getVariable _id) and (_count < _numNATO)} do {	
				_pos = [_start,0,60, 0.1, 0, 0, 0] call BIS_fnc_findSafePos;		
				_civ = _group createUnit [AIT_NATO_Units_LevelTwo call BIS_fnc_selectRandom, _pos, [],0, "NONE"];
				_civ setVariable ["garrison",_name,false];
				_soldiers pushBack _civ;
				_civ setRank "CAPTAIN";
				[_civ,_name] call initMilitary;
				_civ setBehaviour "SAFE";					
									
				sleep 0.1;
				_count = _count + 1;
				_groupcount = _groupcount + 1;
			};
			_group call initCheckpoint;

			
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
				deleteVehicle _x;			
			}foreach(_soldiers);
			{
				if!(_x call hasOwner) then {
					deleteVehicle _x;			
				};
			}foreach(_vehs);
			{				
				deleteGroup _x;			
			}foreach(_groups);
			_soldiers = [];
		};
	};
	sleep 1;
};