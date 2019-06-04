params ["_unit"];

if((random 100) < 75) then {
	_unit setUnitLoadout [_unit call OT_fnc_getRandomLoadout, true];
};

_unit addEventHandler ["HandleDamage", {
	_me = _this select 0;
	_src = _this select 3;
	if(captive _src) then {
		if((vehicle _src) != _src || (_src call OT_fnc_unitSeenNATO)) then {
			_src setCaptive false;
		};
	};
}];

_unit addEventHandler ["Dammaged", OT_fnc_EnemyDamagedHandler];
