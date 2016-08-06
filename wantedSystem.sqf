_unit = _this;
private ["_unit","_timer"];

_timer = -1;

_unit setCaptive true;
player setVariable ["hiding",false,true];

while {true and alive _unit} do {
	sleep 2;	
	
	//check wanted status
	if !(captive _unit) then {
		//CURRENTLY WANTED
		if(_timer >= 0) then {
			_timer = _timer + 2;	
			player setVariable ["hiding",30 - _timer,true];
			if(_timer >= 30) then {
				_unit setCaptive true;
			};
			if({(side _x == west or side _x == east) and (((_x knowsAbout _unit > 1.5) and (_x distance _unit < 1000)) or (_x distance _unit < 50))} count allUnits > 0) then {
				player setVariable ["hiding",30,true];
				_timer = 0;
			}
		}else{
			if({(side _x == west or side _x == east) and (((_x knowsAbout _unit > 1.5) and (_x distance _unit < 1000)) or (_x distance _unit < 50))} count allUnits == 0) then {
				player setVariable ["hiding",30,true];
				_timer = 0;
			};
		};
	}else{
		//CURRENTLY NOT WANTED
		_timer = -1;
		player setVariable ["hiding",0,true];
		if({(side _x== west) and (((_x knowsAbout _unit > 1.5) and (_x distance _unit < 1000)))} count allUnits > 0) then {
			//Police can see you, don't do anything bad ok
			
			if ((primaryWeapon _unit != "") or (secondaryWeapon _unit != "") or (handgunWeapon _unit != "")) then {				
				_unit setCaptive false;
				//reveal you to all cops/military within 2km
				{
					if((side _x == west) and (_x distance _unit < 2000)) then {
						_x reveal [_unit,1.5];
						_x setBehaviour "COMBAT";
						_x setCombatMode "RED";
						_group = group _x;
						if(leader _group == _x) then {
							//Tell group to guard the closest building (ARMA AI speak for "TAKE COVER!")							
							_pos = (nearestBuilding _x) buildingPos 0;
							while {(count(waypoints _group))>0} do {
								deletewaypoint ((waypoints _group) select 0);									
							};	
							_wp = _group addWaypoint [_pos,0];
							_wp setWaypointType "GUARD";
							_wp setWaypointBehaviour "COMBAT";
							_wp setWaypointSpeed "NORMAL";
							_group setCombatMode "RED";
							_group setBehaviour "COMBAT";
						}
					};
				}foreach(allUnits);
				
			}else{
				//Chance they will recognize you
				if(isPlayer _unit) then {
					_town = (getpos _unit) call nearestTown;
					_rep = _unit getVariable format["rep%1",_town];
					
					if(_rep < 0) then {
						_chance = ((abs _rep) / 100);
						if((random 100) < _chance) then {
							_unit setCaptive false;
							//reveal you to all cops/military within 800m
							{
								if((side _x == west) and (_x distance _unit < 800)) then {
									_x reveal [_unit,1.5];
									_x setBehaviour "COMBAT";
									_x setCombatMode "RED";								
								};
							}foreach(allUnits);
						};					
					};
				}
			};
		};
		if({(side _x== east) and (((_x knowsAbout _unit > 1) and (_x distance _unit < 800)))} count allUnits > 0) then {
			//Criminals can see you
			if ((primaryWeapon _unit != "") or (secondaryWeapon _unit != "") or (handgunWeapon _unit != "")) then {
				_unit setCaptive false;
				//reveal you to all gang members
				{
					if((side _x == east) and (_x distance _unit < 800)) then {
						_x reveal [_unit,1.5];
						_x setCombatMode "RED";
						_x setBehaviour "COMBAT";
					};
				}foreach(allUnits);
				
			};
		};
	};
};