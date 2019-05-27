private ["_unit"];

_unit = _this select 0;
_unit setskill ["courage",1];

removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeGoggles _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeVest _unit;

_unit setVariable ["NOAI",true,false];
_unit setVariable ["civ",true,true];

_unit addEventHandler ["FiredNear", {
	_u = _this select 0;
	_group = group _u;
	if !(_group getVariable ["fleeing",false]) then {
		_group setVariable ["fleeing",true,false];
		_group setVariable ["fleeingstart",time,false];
		_group setBehaviour "COMBAT";
		_by = _this select 1;
	};
}];

_unit addEventHandler ["Dammaged", OT_fnc_EnemyDamagedHandler];
