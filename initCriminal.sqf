_unit = _this select 0;
_onCivKilled = _unit addEventHandler ["killed",{
	_me = _this select 0;
	_killer = _this select 1;
	_town = (getpos _me) call nearestTown;
	_pop = server getVariable format["numcrims%1",_town];
	if(_pop < 1) then {_pop = 1};
	server setVariable [format["numcrims%1",_town],_pop - 1,true];
	
	_stability = server getVariable format["stability%1",_town];
	if(_stability > 99) then {_stability = 99};
	server setVariable [format["stability%1",_town],_stability + 1,true];
	
	if(_killer == _me) then {
		//was probably hit by a vehicle so we need to find the nearest player driver and blame him
		
	}else{
		if(isPlayer _killer) then {
			_standing = player getVariable format["rep%1",_town];
			_killer setVariable [format["rep%1",_town],_standing + 1,true];
			
			if(((opfor knowsAbout _killer) > 0) || ((vehicle _killer) != _killer)) then {
				_killer setCaptive false;
				
				//reveal you to all crims nearby
				{
					if((side _x == east) and (_x distance _killer < 500)) then {
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
			
			format["Stability: %1%2\nYour Standing: %2",_stability+1,"%",_standing + 1] remoteExec ["notify_minor",_killer,true];
		};
	};
}];



_onCivFiredNear = _unit addEventHandler["FiredNear",{
	_me = _this select 0;
	_firer = _this select 1;
	
	_group = group _me;
	_group setBehaviour "COMBAT";
	_group setSpeedMode "NORMAL";
	
	while {(count(waypoints _group))>0} do {
		deletewaypoint ((waypoints _group) select 0);									
	};	
	
	if(isPlayer _firer) then {		
		if((opfor knowsAbout _firer) > 1) then {
			_firer setCaptive false;
			
			//reveal you to all nearby crims
			{
				if((side _x == east) and (_x distance _firer < 400)) then {
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