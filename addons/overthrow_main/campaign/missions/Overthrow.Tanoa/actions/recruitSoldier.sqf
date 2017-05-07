if !(captive player) exitWith {"You cannot recruit while wanted" call OT_fnc_notifyMinor};

private _cls = _this select 0;
private _pos = _this select 1;
private _group = _this select 2;

_soldier = _cls call OT_fnc_getSoldier;

private _money = player getVariable ["money",0];
private _cost = _soldier select 0;
if(_money < _cost) exitWith {format ["You need $%1",_cost] call OT_fnc_notifyMinor};

[-_cost] call money;

private _civ = [_soldier,_pos,_group] call OT_fnc_createSoldier;

[_civ,getPlayerUID player] call OT_fnc_setOwner;
[_civ] spawn OT_fnc_initRecruit;
_civ setRank "SERGEANT";
