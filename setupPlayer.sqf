townChange = {
	_town = _this;
	_pop = server getVariable format["population%1",_town];
	_stability = server getVariable format["stability%1",_town];
	_rep = player getVariable format["rep%1",_town];
	_abandon = "NATO Controlled";
	if(_town in (server getVariable ["NATOabandoned",[]])) then {
		if(_stability < 50) then {
			_abandon = "Anarchy";
		}else{
			_abandon = "Resistance Controlled";
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

player spawn wantedSystem;
[] execVM "stats.sqf";
_closestcount = 0;

while {true} do {
	sleep 2;
		
	if(_closestcount <= 0) then {
		_closest = (getPos player) call nearestTown;
		if(_closest != _town) then {
			_closest call townChange;	
			_closestcount = 20;		
		};		
	};	
	_closestcount = _closestcount - 2;	
};

