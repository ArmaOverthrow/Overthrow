_group = _this select 0;
_home = _this select 1;
_pos = getpos _home;

_start = getpos ((units _group) select 0);

_group setBehaviour "SAFE";

_hour = date select 3;

if(_hour > 6 and _hour < 19) then {
	//Walk to a shop and back again
	_buildings = AIT_allHouses + AIT_allShops + AIT_offices + AIT_portBuildings;
	_dest = getpos([_home,_buildings] call getRandomBuilding);
		
	_wp = _group addWaypoint [_dest,0];
	_wp setWaypointType "MOVE";
	_wp setWaypointSpeed "LIMITED";
	_wp setWaypointCompletionRadius 40;
	_wp setWaypointTimeout [0, 4, 8];
	
	_wp = _group addWaypoint [_pos,0];	
	_wp setWaypointType "MOVE";
	_wp setWaypointSpeed "LIMITED";
	_wp setWaypointCompletionRadius 10;	
	_wp setWaypointTimeout [20, 40, 80];
	
	_wp = _group addWaypoint [_pos,0];
	_wp setWaypointType "CYCLE";
}else{
	//Lull around home
	_idx = 0;
	_end = false;
	while{!_end} do {
		_pos = ([_home] call BIS_fnc_buildingPositions) call BIS_fnc_selectRandom;
		if!(isNil "_pos") then {
			_wp = _group addWaypoint [_pos,0];
			_wp setWaypointType "MOVE";
			_wp setWaypointSpeed "LIMITED";
			_wp setWaypointTimeout [10, 20, 40];
		}else{
			_end = true;
		};	
	};
	_wp = _group addWaypoint [getpos _home,0];
	_wp setWaypointType "CYCLE";
	_wp setWaypointTimeout [20, 40, 80];
};

