_unit = _this select 0;

_unit setSkill 0;

_onCivKilled = _unit addEventHandler ["killed",{
	_me = _this select 0;
	removeAllActions _me;
	
	_killer = _this select 1;
	_town = (getpos _me) call nearestTown;
	_pop = server getVariable format["population%1",_town];
	server setVariable [format["population%1",_town],_pop - 1,true];
	
	_stability = server getVariable format["stability%1",_town];
	server setVariable [format["stability%1",_town],_stability - 1,true];

	if(_killer == _me) then {
		//was probably hit by a vehicle so we need to find the nearest player driver and blame him
		
	}else{
		if(isPlayer _killer) then {
			_standing = player getVariable format["rep%1",_town];
			_killer setVariable [format["rep%1",_town],_standing - 10,true];
			_killer setCaptive false;
			
			format["Standing (%1): %2",_town,_standing-10] remoteExec ["notify",_killer,true];
			
			//reveal you to the local garrison
			{
				_garrison = _x getvariable "garrison";
				if !(isNil "_garrison") then {
					if((side _x == west) and (_garrison == _town)) then {
						_x reveal [_killer,1.5];
						_x setCombatMode "RED";
						_x setBehaviour "COMBAT";					
						
						_group = group _x;
						if(leader _group == _x) then {
							_group setCombatMode "RED";
							_group setSpeedMode "NORMAL";
							_group setBehaviour "COMBAT";
							
							while {(count (waypoints _group)) > 0} do {deleteWaypoint ((waypoints _group) select 0)};
							_wp = _group addWaypoint [getpos _killer,0];
							_wp setWaypointType "SAD";
							_wp setWaypointBehaviour "STEALTH";
						}
					};
				};				
			}foreach(allUnits);
		};
	};
}];

_onCivFiredNear = _unit addEventHandler["FiredNear",{
	//Make civilians be scared when shots are fired
	_me = _this select 0;
	_group = group _me;
	_group setBehaviour "Combat";
	_group setSpeedMode "Normal";
	
	_index = currentWaypoint group player;
	deleteWaypoint [_group, _index];
	_group allowFleeing 1;
}];