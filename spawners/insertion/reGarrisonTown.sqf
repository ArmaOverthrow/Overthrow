private ["_drop","_group","_start","_stability","_vehtype","_num","_count"];

_town = _this;
_townPos = server getVariable _town;

_stability = server getVariable format["stability%1",_town];
_region = server getVariable format["region_%1",_town];

_police = [];
_support = [];

_close = nil;
_dist = 8000;

{
	_pos = _x select 0;
	_name = _x select 1;
	if([_pos,_region] call fnc_isInMarker) then {
		_d = (_pos distance _townPos);
		if(_d < _dist) then {
			_dist = _d;
			_close = _pos;
			
		};
	};
}foreach(AIT_NATOobjectives);

if(!isNil "_close") then {
	_start = [_close,0,200, 1, 0, 0, 0] call BIS_fnc_findSafePos;
	_group = creategroup blufor;
	
	_vehtype = AIT_NATO_Vehicle_Quad;
	
	_drop = (([_townPos, 100, 600, 1, 0, 0, 0] call BIS_fnc_findSafePos) nearRoads 200) select 0;
			
	if(_stability < 20) then {
		//last ditch efforts to save this town
		//send in the big guns
		_vehtype = AIT_NATO_Vehicle_Transport;
		_num = 5 + round(random 6);
		_count = 0;
		while {_count < _num} do {
			_start = [_start, 0, 20, 1, 0, 0, 0] call BIS_fnc_findSafePos;
			_civ = _group createUnit [AIT_NATO_Units_LevelTwo call BIS_fnc_selectRandom, _start, [],0, "NONE"];
			
			_police pushBack _civ;
			[_civ,_town] call initPolice;
			_count = _count + 1;
		};
	}else{
		if(_stability < 40 and (random 100) > 50) then {
			//Shit's getting real, send more dudes
			_vehtype = AIT_NATO_Vehicle_Police;
			_num = 2;
			_count = 0;
			while {_count < _num} do {
				_start = [_start, 0, 20, 1, 0, 0, 0] call BIS_fnc_findSafePos;
				_civ = _group createUnit [AIT_NATO_Unit_Police, _start, [],0, "NONE"];
				
				_police pushBack _civ;
				[_civ,_town] call initPolice;
				_count = _count + 1;
			};
		};
		if(_stability < 40 and (random 100) > 90) then {
			//Random MRAP or heli support
			_vt = (AIT_NATO_Vehicles_PoliceSupport call BIS_fnc_selectRandom);
			_pos = _start findEmptyPosition [0,100,_vt];
			_supportCreated =  [_pos, 180, _vt, WEST] call bis_fnc_spawnvehicle;
			
			_supportVeh = _supportCreated select 0;
			_crew = _supportCreated select 1;
			_g = _supportCreated select 2;
			
			//Guard the dropzone
			_move = _g addWaypoint [_drop,100];
			_move setWaypointType "GUARD";	
			
			[_police,_crew] call BIS_fnc_arrayPushStack;
			_police pushback _supportVeh;
		}
	};
	
	_spawnpos = _start findEmptyPosition [0,100,_vehtype];
	_veh =  _vehtype createVehicle _spawnpos;
	_veh setDir 180;
	_group addVehicle _veh;	
	
	_police pushBack _veh;
	
	_civ = _group createUnit [AIT_NATO_Unit_PoliceCommander, _start, [],0, "NONE"];
	_civ setVariable ["garrison",_town,true];
	_police pushBack _civ;
	[_civ,_town] call initPolice;
	
	if(_stability > 50) then {
		_civ setBehaviour "SAFE";
	};
	sleep 0.01;
	_start = [_start, 0, 20, 1, 0, 0, 0] call BIS_fnc_findSafePos;
	_civ = _group createUnit [AIT_NATO_Unit_Police, _start, [],0, "NONE"];
	_civ setVariable ["garrison",_town,true];
	
	_police pushBack _civ;
	[_civ,_town] call initPolice;
	if(_stability > 50) then {
		_civ setBehaviour "SAFE";
	};
	_count = _count + 2;
	
	_group setVariable ["veh",_veh];
	_group setVariable ["transport",_police];	
	
	if(isNil "_drop") then {
		_drop = (([_townPos, 100, 800, 1, 0, 0, 0] call BIS_fnc_findSafePos) nearRoads 200) select 0;
	};
	
	_move = _group addWaypoint [_spawnpos,0];
	_move setWaypointType "GETIN";
	_move setWaypointSpeed "FULL";	
	
	_move = _group addWaypoint [_drop,0];
	_move setWaypointType "MOVE";
	_move setWaypointSpeed "FULL";	
	
	_move = _group addWaypoint [_drop,0];
	_move setWaypointType "GETOUT";					
	_move setWaypointStatements ["true","(group this) call initPolicePatrol;"];		
	
	{
		_x addCuratorEditableObjects [_police+_support,true];
	} forEach allCurators;
};

_police+_support;