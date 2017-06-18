player spawn OT_fnc_statsSystem;
player spawn OT_fnc_wantedSystem;
player spawn OT_fnc_perkSystem;
player spawn OT_fnc_mapSystem;
disableUserInput false;

_townChange = {
	_town = _this;
	_pop = server getVariable format["population%1",_town];
	if(isNil "_pop") exitWith {};
	_stability = server getVariable format["stability%1",_town];
	_rep = [_town] call OT_fnc_standing;
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
_town = (getPos player) call OT_fnc_nearestTown;
_town call _townChange;

_timer = -1;

player setVariable ["player_uid",getPlayerUID player,true];

_closestcount = 0;

while {alive player} do {
	sleep 1;
	private _txt = "";
	private _num = count OT_notifies;

	if(_num > 0) then {
		if(_num == 1) then {
			_txt = OT_notifies select 0;
		}else{
			{
				_txt = format["%1<br/>%2",_txt,_x];
			}foreach(OT_notifies);
		};
		OT_notifies = [];
		[_txt, -1, -0.2, 10, 0.5, 0, 2] spawn bis_fnc_dynamicText;
	};

	if(_closestcount <= 0) then {
		_closest = (getPos player) call OT_fnc_nearestTown;
		if !(isNil "_closest") then {
			if(_closest != _town) then {
				_closest call _townChange;
				_closestcount = 60;
			};
		};
		_closestcount = 0;
	};
	_closestcount = _closestcount - 2;
};
