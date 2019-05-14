if !(captive player) exitWith {"You cannot recruit while wanted" call OT_fnc_notifyMinor};

private _cls = _this select 0;
private _pos = _this select 1;
private _group = _this select 2;

if(({side _x isEqualTo west || side _x isEqualTo east} count (_pos nearEntities 50)) > 0) exitWith {
	"You cannot recruit with enemies nearby" call OT_fnc_notifyMinor;
};

private _soldier = _cls call OT_fnc_getSoldier;

private _money = player getVariable ["money",0];
private _cost = _soldier select 0;
if(_money < _cost) exitWith {format ["You need $%1",_cost] call OT_fnc_notifyMinor};

[-_cost] call OT_fnc_money;

private _civ = [_soldier,_pos,_group] call OT_fnc_createSoldier;

[_civ,getPlayerUID player] call OT_fnc_setOwner;
[_civ] call OT_fnc_initRecruit;
_civ setRank "SERGEANT";
_civ setSkill 0.4 + (random 0.3);
_civ setVariable ["OT_spawntrack",true,true];
