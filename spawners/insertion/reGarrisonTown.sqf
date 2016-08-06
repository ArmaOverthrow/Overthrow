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

	_spawnpos = _start findEmptyPosition [0,100,AIT_NATO_Vehicle_Police];
	_veh =  AIT_NATO_Vehicle_Police createVehicle _spawnpos;
	_veh setDir 180;
	_group addVehicle _veh;	
	
	_police pushBack _veh;
	
	_civ = _group createUnit [AIT_NATO_Unit_PoliceCommander, _start, [],0, "NONE"];
	_police pushBack _civ;
	[_civ,_town] call initPolice;
	_civ setBehaviour "SAFE";
	sleep 0.01;
	_start = [_start, 0, 20, 1, 0, 0, 0] call BIS_fnc_findSafePos;
	_civ = _group createUnit [AIT_NATO_Unit_Police, _start, [],0, "NONE"];
	
	_police pushBack _civ;
	[_civ,_town] call initPolice;
	_civ setBehaviour "SAFE";
	_count = _count + 2;
	
	_group setVariable ["veh",_veh];
	_group setVariable ["transport",_police];	
	
	_drop = (([_townPos, 100, 500, 1, 0, 0, 0] call BIS_fnc_findSafePos) nearRoads 200) select 0;
	
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