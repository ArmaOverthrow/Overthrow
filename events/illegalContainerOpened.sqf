_unit = _this select 1;						
_v = _this select 0;				
_unit setCaptive false;		

//send everyone after you
{
	if((side _x == west) and (_x distance _unit < 500)) then {
		_x reveal [_unit,1.5];
		_group = group _x;
		if(leader _group == _x) then {
			while {(count (waypoints _group)) > 0} do {
				deleteWaypoint ((waypoints _group) select 0);
			};
			_wp = _group addWaypoint [getpos _unit,0];
			_wp setWaypointType "SAD";
			_wp setWaypointBehaviour "COMBAT";						
		};
	};
}foreach(allUnits);