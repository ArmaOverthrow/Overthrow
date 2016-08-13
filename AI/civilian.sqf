private ["_unit","_group","_clothes","_scared"];

_unit = _this select 0;

removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeGoggles _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeVest _unit;

_unit setskill ["courage",1];
_unit setVariable ["scared",-1,false];

_clothes = AIT_clothes_locals;

if((typeof _unit) in AIT_civTypes_expats) then {
	_clothes = AIT_clothes_expats;
};
_counter = 0;

_unit forceAddUniform (_clothes call BIS_fnc_selectRandom);

_unit addEventHandler ["FiredNear", {
	_u = _this select 0;
	_u setVariable ["scared",0,false];
	
	_u allowFleeing 1;
	_u setskill ["courage",0];
	_u disableAI "fsm";
}];

_unit addEventHandler ["HandleDamage", {
	_me = _this select 0;
	_dmg = _this select 2;
	_src = _this select 3;
	_proj = _this select 4;
	_veh = vehicle _src;
	if(_veh != _src) then {
		if((driver _veh) == _src) then {
			_dmg = 0;
		};
	};
	_dmg;
}];

while {alive _unit} do {
	_s = _unit getVariable ["scared",-1];
	if(_s > -1) then {
		_counter = _counter + 1;
		if(_counter > 30) then {
			_unit allowFleeing 0;
			_unit setskill ["courage",1];
			_unit enableAI "fsm";
			_counter = -1;
		};
	};
};