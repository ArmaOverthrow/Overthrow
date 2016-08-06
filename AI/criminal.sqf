_unit = _this select 0;
_onCivKilled = _unit addEventHandler ["killed",{
	_me = _this select 0;
	_killer = _this select 1;
	_town = (getpos _me) call nearestTown;
	_pop = server getVariable format["numcrims%1",_town];
	if(_pop < 1) then {_pop = 1};
	server setVariable [format["numcrims%1",_town],_pop - 1,true];
	
	if((random 100) > 75) then {
		[_town,+1] call stability;
	};
	
	if(_killer == _me) then {
		//was probably hit by a vehicle so we need to find the nearest player driver and blame him
		
	}else{
		if(isPlayer _killer) then {			
			[_town,+1] remoteExec ["standing",_killer,true];
			
			if(((opfor knowsAbout _killer) > 0) || ((vehicle _killer) != _killer)) then {
				_killer setCaptive false;
				
				//reveal you to all crims nearby
				{
					if((side _x == east) and (_x distance _killer < 500)) then {
						_x reveal [_killer,1];
						_x setCombatMode "RED";
						_x setBehaviour "COMBAT";
						_group = group _x;
						_group setCombatMode "RED";
						_group setSpeedMode "NORMAL";
						_group setBehaviour "COMBAT";
					};
				}foreach(allUnits);
			};
			
		};
	};
}];



_onCivFiredNear = _unit addEventHandler["FiredNear",{
	_me = _this select 0;
	_firer = _this select 1;
	
	_group = group _me;
	_group setBehaviour "COMBAT";
	_group setSpeedMode "NORMAL";
	
	if(isPlayer _firer) then {		
		if((opfor knowsAbout _firer) > 1) then {
			_firer setCaptive false;
			
			//reveal you to all nearby crims
			{
				if((side _x == east) and (_x distance _firer < 400)) then {
					_x reveal [_firer,1];
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