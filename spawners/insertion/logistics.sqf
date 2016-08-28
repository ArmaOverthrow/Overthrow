private ["_id","_params","_town","_posTown","_active","_groups","_civs","_numCiv","_shops","_houses","_stability","_pop","_count","_mSize","_civTypes","_hour","_range","_found"];
if (!isServer) exitwith {};

_active = false;

_count = 0;
_id = _this select 0;
_pos = _this select 1;
_dest = _this select 2;
_data = _this select 3;

_building = _data select 0;
_load = _data select 1;
_delivery = _data select 2;

_groups = [];

_civs = []; //Stores all civs for tear down
_vehs = [];

_counter = 0;
_distance = _pos distance _dest;

//assuming 40km/hr and a straight line
if(_distance < 450) exitWith {
	//Don't need a truck, just walk up the road mate
	sleep 10;
	_id call AIT_fnc_deregisterSpawner;
	_building setVariable ["deliveryid","",true];
};

_towndest = _dest call nearestTown;
_townstart = _pos call nearestTown;

_triplength = round((_distance / 40000) * 3600);

_status = "loading";
_veh = objNULL;

while{_status != "done"} do {
	//Do any updates here that should happen whether spawned or not
	_counter = _counter + 1;
	//Main spawner
	if !(_active) then {
		if (spawner getVariable _id) then {			
			_active = true;
			//Spawn stuff in
			
			//Do I already have a truck?
			_veh = _building getVariable "truck";
			if (isNil "_veh") then {
				_vehtype = AIT_vehType_distro;
				_start = [_pos,11,(getDir _building)-155] call BIS_fnc_relPos;
				_posVeh = _start findEmptyPosition [0,10,_vehtype];
							
				_veh = _vehtype createVehicle _posVeh;
				clearItemCargoGlobal _veh;
						
				_veh setDir (getDir _building)+90;
				_vehs pushBack _veh;
				_building setVariable ["truck",_veh,true];
				_veh setVariable ["distro",_building,true];
				
				_veh addEventHandler ["Take",{
					_unit setCaptive false;
				}];				
				_vehs pushback _veh;
			};
			if !(isNull _veh) then {
				_veh setVariable ["delivery",_delivery];
				clearItemCargoGlobal _veh;
				{				
					_cls = _x select 0;
					_num = _x select 1;
					if(_cls in AIT_allBackpacks) then {	
						_veh addBackpackCargoGlobal _x;
					}else{
						_veh addItemCargoGlobal _x;
					};				
				}foreach(_load);
				
				_group = createGroup civilian;
				_group addVehicle _veh;
				_groups pushback _group;	
				_start = [_pos,-2,getDir _building] call BIS_fnc_relPos;			
				_numworkers = 2;
				while {_count < _numworkers} do {							
					_civ = _group createUnit [AIT_civType_worker, _start, [],0, "NONE"];
					_civ setBehaviour "SAFE";
					[_civ,_building] spawn initCivilian;
					_civs pushBack _civ;				
					_count = _count + 1;				
					sleep 0.01;
				};
				_veh setVariable ["workers",_civs];
				
				_wp = _group addWaypoint [getpos _veh,0];
				_wp setWaypointType "GETIN";
				_wp setWaypointBehaviour "SAFE";
				_wp setWaypointSpeed "LIMITED";
				
				{
					_b = _x select 0;
					_wp = _group addWaypoint [getpos _b,0];
					_wp setWaypointType "MOVE";
					_wp setWaypointBehaviour "SAFE";
					_wp setWaypointSpeed "LIMITED";
					_wp setWaypointTimeout[2,6,9];
					_wp setWaypointStatements ["true","this call logisticsUnload"];
				}foreach(_delivery);
				
				_wp = _group addWaypoint [getpos _veh,0];
				_wp setWaypointType "GETOUT";
				_wp setWaypointBehaviour "SAFE";
				_wp setWaypointSpeed "LIMITED";
				
				{
					_x addCuratorEditableObjects [_civs+_vehs,true];
				} forEach allCurators;
				
				sleep 1;
				{
					_x setDamage 0;				
				}foreach(_civs);	
			}			
		}else{			
			if(_counter > _triplength) then {
				////delivery is done
				_id call AIT_fnc_deregisterSpawner;
				_status = "done";
				_building setVariable ["deliveryid","",true];
			};
		};
	}else{
		_counter = 0;
		if (spawner getVariable _id) then {
			//Do updates here that should happen only while spawned
			//...
			[_id,getpos _veh,_dest] call AIT_fnc_updateSpawnerPosition;
		}else{		
			_active = false;
			//Tear it all down
			{
				if !(_x call hasOwner) then {
					deleteVehicle _x;
				};				
			}foreach(_civs + _vehs);
			{				
				deleteGroup _x;								
			}foreach(_groups);
			_civs = [];
			_groups = [];
		};
	};
	sleep 1;
};