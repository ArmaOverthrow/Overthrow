_unit = _this select 0;
_onCivKilled = _unit addEventHandler ["killed",{
	_me = _this select 0;
	_killer = _this select 1;
	_town = (getpos _me) call nearestTown;
	_pop = server getVariable format["garrison%1",_town];
	server setVariable [format["garrison%1",_town],_pop - 1,true];
	
	_stability = server getVariable format["stability%1",_town];
	server setVariable [format["stability%1",_town],_stability - 2,true];

	if(_killer == _me) then {
		//was probably hit by a vehicle so we need to find the nearest player driver and blame him
		
	}else{
		if(isPlayer _killer) then {
			_standing = player getVariable format["rep%1",_town];
			_killer setVariable [format["rep%1",_town],_standing - 1,true];
			
			if(((blufor knowsAbout _killer) > 0) || ((vehicle _killer) != _killer)) then {
				_killer setCaptive false;
				
				//reveal you to all cops/military within 2km
				{
					if((side _x == west) and (_x distance _killer < 2000)) then {
						_x reveal _killer;
						_x setCombatMode "RED";
						_x setBehaviour "COMBAT";
						_group = group _x;
						_group setCombatMode "RED";
						_group setSpeedMode "NORMAL";
						_group setBehaviour "COMBAT";
					};
				}foreach(allUnits);
			};
			
			format["Standing (%1) -1",_town] remoteExec ["notify",_killer,true];
		};
	};
}];



_onCivFiredNear = _unit addEventHandler["FiredNear",{
	//Make police break patrol when shots are fired
	_me = _this select 0;
	_firer = _this select 1;
	
	_group = group _me;
	_group setBehaviour "COMBAT";
	_group setSpeedMode "NORMAL";
	
	while {(count(waypoints _group))>0} do {
		deletewaypoint ((waypoints _group) select 0);									
	};	
	
	if(isPlayer _firer) then {		
		if((blufor knowsAbout _firer) > 1) then {
			_firer setCaptive false;
			
			//reveal you to all cops/military within 1km
			{
				if((side _x == west) and (_x distance _firer < 1000)) then {
					_x reveal _firer;
					_x setCombatMode "RED";
					_x setBehaviour "COMBAT";
					_group = group _x;
					_group setCombatMode "RED";
					_group setSpeedMode "NORMAL";
					_group setBehaviour "COMBAT";
				};
			}foreach(allUnits);
		}
	}
}];