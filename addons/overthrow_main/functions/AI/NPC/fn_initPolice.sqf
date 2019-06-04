private ["_town","_unit","_numweap","_skill","_unit","_magazine","_weapon","_stability","_idx"];

private _unit = _this select 0;
private _town = _this select 1;

_unit setVariable ["polgarrison",_town,true];

_stability = server getVariable format["stability%1",_town];

_unit addEventHandler ["HandleDamage", {
	_me = _this select 0;
	_src = _this select 3;
	if(captive _src) then {
		if((vehicle _src) != _src || (_src call OT_fnc_unitSeenNATO)) then {
			_src setCaptive false;
		};
	};
}];
