private _g = _this;

private _start = getpos ((units _g) select 0);

_g setBehaviour "SAFE";

private _hour = date select 3;

if(_hour > 6 and _hour < 19) then {
	//Walk to a shop and back again
	private _dest = getpos([_start,AIT_allHouses + AIT_allShops + AIT_offices + AIT_portBuildings] call getRandomBuilding);
		
	private _wp = _g addWaypoint [_dest,0];
	_wp setWaypointType "MOVE";
	_wp setWaypointSpeed "LIMITED";
	_wp setWaypointCompletionRadius 40;
	_wp setWaypointTimeout [0, 4, 8];
	
	_wp = _g addWaypoint [_start,0];	
	_wp setWaypointType "MOVE";
	_wp setWaypointSpeed "LIMITED";
	_wp setWaypointCompletionRadius 10;	
	_wp setWaypointTimeout [20, 40, 80];
	
	_wp = _g addWaypoint [_start,0];
	_wp setWaypointType "CYCLE";
}else{
	//Lull around home	
	private _end = false;
	private _bdg = nearestBuilding _start;
	private _c = 0;
	while{!_end} do {
		private _pos = ([_bdg] call BIS_fnc_buildingPositions) call BIS_fnc_selectRandom;
		if!(isNil "_pos") then {
			private _wp = _g addWaypoint [_pos,0];
			_wp setWaypointType "MOVE";
			_wp setWaypointSpeed "LIMITED";
			_wp setWaypointTimeout [10, 20, 40];
		}else{
			_end = true;
		};			
		_c = _c + 1;
		if(_c > 4) then {
			_end = true;
		};
	};
	private _wp = _g addWaypoint [_start,0];
	_wp setWaypointType "CYCLE";
	_wp setWaypointTimeout [20, 40, 80];
};

