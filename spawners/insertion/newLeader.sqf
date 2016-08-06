
_leaderpos = _this select 0;
_numcrim = _this select 1;
_town = _this select 2;
_townPos = server getVariable _town;

_stability = server getVariable format["stability%1",_town];
_region = server getVariable format["region_%1",_town];

_crims = [];
_support = [];

_close = nil;
_dist = 8000;

{
	_name = _x;
	_pos = server getVariable _x;
	if(_name != _town and ([_pos,_region] call fnc_isInMarker)) then {
		_d = (_pos distance _townPos);
		if(_d < _dist) then {
			_dist = _d;
			_close = _pos;				
		};
	};
}foreach(AIT_allTowns);

if(!isNil "_close") then {
	_close = [_close, 100, 800, 1, 0, 0, 0] call BIS_fnc_findSafePos;
	_start = getpos((_close nearRoads 500) select 0);

	_group = creategroup opfor;
	
	_type = AIT_vehTypes_crim call BIS_fnc_selectRandom;

	_spawnpos = _start findEmptyPosition [0,100,_type];
	_veh =  _type createVehicle _spawnpos;
	_veh setDir ([_spawnpos,_leaderpos] call BIS_fnc_dirTo);
	_group addVehicle _veh;	
	
	_crims pushBack _veh;
	
	_civ = _group createUnit [AIT_CRIM_Units_Para call BIS_fnc_selectRandom, _start, [],0, "NONE"];
	_civ setRank "MAJOR";
	[_civ] joinSilent _group;
	_crims pushBack _civ;
	[_civ,_town] call initCrimLeader;
	_civ setBehaviour "SAFE";
	sleep 0.01;
	
	_count = 0;
	_start = [_spawnpos, 0, 100, 1, 0, 0, 0] call BIS_fnc_findSafePos;
	while{_count < _numcrim} do {
		
		_civ = _group createUnit [AIT_CRIM_Units_Bandit call BIS_fnc_selectRandom, _start, [],0, "NONE"];
		[_civ] joinSilent _group;
		_civ setRank "CORPORAL";
		
		_crims pushBack _civ;
		[_civ,_town] call initCriminal;
		_civ setBehaviour "SAFE";
		_count = _count + 1;
		_start = [_start, 0, 20, 1, 0, 0, 0] call BIS_fnc_findSafePos;
	};	
	
	_group setVariable ["veh",_veh];
	_group setVariable ["transport",_crims];	
	
	_drop = (([_townPos, 100, 500, 1, 0, 0, 0] call BIS_fnc_findSafePos) nearRoads 200) select 0;
	
	_move = _group addWaypoint [_spawnpos,0];
	_move setWaypointType "GETIN";
	_move setWaypointSpeed "FULL";	
	
	_move = _group addWaypoint [_drop,0];
	_move setWaypointType "MOVE";
	_move setWaypointSpeed "FULL";	
	
	_move = _group addWaypoint [_drop,0];
	_move setWaypointType "GETOUT";					
	
	_move = _group addWaypoint [_leaderpos,0];
	_move setWaypointType "GUARD";
	
	{
		_x addCuratorEditableObjects [_crims+_support,true];
	} forEach allCurators;
};

_crims+_support;