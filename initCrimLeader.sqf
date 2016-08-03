_unit = _this select 0;
_onCivKilled = _unit addEventHandler ["killed",{
	_me = _this select 0;
	_killer = _this select 1;
	_town = (getpos _me) call nearestTown;
	
	//Gang leader is dead..
	//Reset the criminal element in this town
	server setVariable [format["crimleader%1",_town],false,true];
	server setVariable [format["timecrims%1",_town],0,true];
		
	if(_killer == _me) then {
		//was probably hit by a vehicle so we need to find the nearest player driver and blame him
		
	}else{
		if(isPlayer _killer) then {
			_standing = player getVariable format["rep%1",_town];
			_killer setVariable [format["rep%1",_town],_standing + 10,true];
			
			if(((opfor knowsAbout _killer) > 0) || ((vehicle _killer) != _killer)) then {
				_killer setCaptive false;
				
				//reveal you to all crims nearby
				{
					if((side _x == east) and (_x distance _killer < 800)) then {
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
			
			format["Standing (%1) +10\nGang leader killed",_town] remoteExec ["notify",_killer,true];
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
				if((side _x == east) and (_x distance _firer < 600)) then {
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