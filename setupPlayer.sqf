townChange = {
	_town = _this;
	_pop = server getVariable format["population%1",_town];
	_stability = server getVariable format["stability%1",_town];
	_rep = player getVariable format["rep%1",_town];
	_txt = format ["<t size='1.5' color='#eeeeee'>%1</t><br/><t size='0.5' color='#bbbbbb'>Population: %2</t><br/><t size='0.5' color='#bbbbbb'>Stability: %3%4</t><br/><t size='0.5' color='#bbbbbb'>Your Standing: %5</t>",_town,[_pop, 1, 0, true] call CBA_fnc_formatNumber,_stability,"%",_rep];
	[_txt, [safeZoneX + (0.8 * safeZoneW), (0.2 * safeZoneW)], 0.5, 10, 0, 0, 2] spawn bis_fnc_dynamicText;
};
_town = (getPos player) call nearestTown;
_town call townChange;

_timer = -1;

player addEventHandler ["InventoryOpened", {
	[] spawn {
		waitUntil {!isNull (findDisplay 602)}; // Wait until the right dialog is really open 
		player addEventHandler ["InventoryClosed", {
			removeMissionEventHandler ["Draw3D", missionNamespace getVariable "WGP_UI_redraw"];
		}];
		_whileopen = addMissionEventHandler ["Draw3D", {
			_load = (round (loadAbs player* (1 / 2.2046) * 10 ^ 2 / 10)) / 10 ^ 2; // Load converted to kg and rounded to two decimals. Change the "^2" to change the number of decimal places. Remove the "* (1 / 2.2046)" to have weight in lb.
			(findDisplay 602 displayCtrl 111) ctrlSetText (name player + " " + str(_load)+ "kg");
		}];
		missionNamespace setVariable ["WGP_UI_redraw", _whileopen];
	};
}];

while {true} do {
	sleep 2;
	
	_closest = (getPos player) call nearestTown;
	if(_closest != _town) then {
		_closest call townChange;
	};
	
	//check wanted status
	if !(captive player) then {
		_rep = player getVariable format["rep%1",_town];
		
		if({(side _x== west) and (((_x knowsAbout player > 0) and (_x distance player < 1000)) or (_x distance player < 50))} count allUnits == 0) then {
			_timer = 0;
		};
		if(_timer >= 0) then {
			_timer = _timer + 2;				
			if(_timer == 30) then {
				_timer = -1;
				player setCaptive true;
			};
		};
	}else{
		if({(side _x== west) and (((_x knowsAbout player > 1) and (_x distance player < 1000)))} count allUnits > 0) then {
			//Police can see you, don't do anything bad ok
			if ((primaryWeapon player != "") or (secondaryWeapon player != "") or (handgunWeapon player != "")) then {
				hint "The police have seen your weapon!";
				player setCaptive false;
				//reveal you to all cops/military within 3km
				{
					if((side _x == west) and (_x distance player < 2000)) then {
						_x reveal player;
						_x setBehaviour "COMBAT";
						_x setCombatMode "RED";
						_group = group _x;
						while {(count(waypoints _group))>0} do {
							deletewaypoint ((waypoints _group) select 0);									
						};	
						_wp = _group addWaypoint [getpos player,0];
						_wp setWaypointType "SAD";
						_wp setWaypointBehaviour "COMBAT";
						_wp setWaypointSpeed "NORMAL";
						_group setCombatMode "RED";
						_group setBehaviour "COMBAT";
					};
				}foreach(allUnits);
				
			};
		};
		if({(side _x== east) and (((_x knowsAbout player > 1) and (_x distance player < 800)))} count allUnits > 0) then {
			//Criminals can see you
			if ((primaryWeapon player != "") or (secondaryWeapon player != "") or (handgunWeapon player != "")) then {
				hint "The gang has seen your weapon!";
				player setCaptive false;
				//reveal you to all gang members
				{
					if((side _x == east) and (_x distance player < 800)) then {
						_x reveal player;
						_x setCombatMode "RED";
						_x setBehaviour "COMBAT";
						
						_group = group _x;
						while {(count(waypoints _group))>0} do {
							deletewaypoint ((waypoints _group) select 0);									
						};	
						_wp = _group addWaypoint [getpos player,0];
						_wp setWaypointType "SAD";
						_wp setWaypointBehaviour "COMBAT";
						_wp setWaypointSpeed "NORMAL";
						_group setCombatMode "RED";
						_group setBehaviour "COMBAT";
					};
				}foreach(allUnits);
				
			};
		};
	};
};

