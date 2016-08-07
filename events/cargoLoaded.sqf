_item = _this select 0;
_veh = _this select 1;
_pos = getpos _veh;

_illegal = _item getVariable ["ace_illegalCargo",false];

if(_illegal) then {
	{
		if(isPlayer _x) then {
			_x setCaptive false;
			_unit = _x;
			//send everyone after you
			{
				if((side _x == west) and (_x distance _pos < 500)) then {
					_x reveal [_unit,1.5];
					_group = group _x;
					if(leader _group == _x) then {
						while {(count (waypoints _group)) > 0} do {
							deleteWaypoint ((waypoints _group) select 0);
						};
						_wp = _group addWaypoint [_pos,0];
						_wp setWaypointType "SAD";
						_wp setWaypointBehaviour "COMBAT";						
					};
				};
			}foreach(allUnits);
		};
	}foreach(_pos nearentities 30);
};