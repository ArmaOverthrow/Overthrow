player spawn statsSystem;
player spawn wantedSystem;
player spawn perkSystem;
player spawn intelSystem;
disableUserInput false;

townChange = {
	_town = _this;
	_pop = server getVariable format["population%1",_town];
	_stability = server getVariable format["stability%1",_town];
	_rep = player getVariable format["rep%1",_town];
	_abandon = "NATO Controlled";
	if(_town in (server getVariable ["NATOabandoned",[]])) then {
		_garrison = server getVariable [format['police%1',_town],0];
		if(_garrison > 0) then {
			_abandon = "Resistance Controlled";
		}else{
			_abandon = "Anarchy";
		};							
	};
	_plusmin = "";
	if(_rep > -1) then {
		_plusmin = "+";
	};
	_txt = format ["<t size='1.5' color='#eeeeee'>%1</t><br/><t size='0.5' color='#bbbbbb'>Status: %7</t><br/><t size='0.5' color='#bbbbbb'>Population: %2</t><br/><t size='0.5' color='#bbbbbb'>Stability: %3%4</t><br/><t size='0.5' color='#bbbbbb'>Your Standing: %5%6</t>",_town,[_pop, 1, 0, true] call CBA_fnc_formatNumber,_stability,"%",_plusmin,_rep,_abandon];
	[_txt, [safeZoneX + (0.8 * safeZoneW), (0.2 * safeZoneW)], 0.5, 10, 0, 0, 2] spawn bis_fnc_dynamicText;
};
_town = (getPos player) call nearestTown;
_town call townChange;

_timer = -1;

player setVariable ["player_uid",getPlayerUID player,true];

_closestcount = 0;

while {alive player} do {
	sleep 1;	

	{
		[_x, -1, -0.2, 10, 0.5, 0, 2] spawn bis_fnc_dynamicText;
		sleep 1;		
	}foreach(OT_notifies);
	OT_notifies = [];
		
	if(_closestcount <= 0) then {
		_closest = (getPos player) call nearestTown;
		if !(isNil "_closest") then {
			if(_closest != _town) then {
				_closest call townChange;	
				_closestcount = 60;		
			};		
		};
		_closestcount = 0;
	};	
	_closestcount = _closestcount - 2;	
};

