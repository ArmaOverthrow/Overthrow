if !(captive player) exitWith {"You cannot recruit while wanted" call notify_minor};

private _cls = _this select 0;
private _pos = _this select 1;

_d = [];
{
	_name = _x select 0;
	if(_name == _cls) exitWith {_d = _x};
}foreach(OT_squadables);

_comp = _d select 1;
_soldiers = [];
private _cost = 0;
{
	_s = OT_recruitables select _x;
	
	_soldier = (_s select 0) call getSoldier;
	_cost = _cost + (_soldier select 0);
	_soldiers pushback _soldier;
}foreach(_comp);

private _money = player getVariable ["money",0];
if(_money < _cost) exitWith {format ["You need $%1",_cost] call notify_minor};

[-_cost] call money;

_group = creategroup resistance;
_leader = false;
{		
	_civ = [_x,_pos,_group] call createSoldier;
	player reveal [_civ,4];	
	if(!_leader) then {_group selectLeader _civ;_civ setVariable ["owner",getplayeruid player,true],_leader=true};
}foreach(_soldiers);
player hcSetGroup [_group,_cls];

_recruits = server getVariable ["squads",[]];
_recruits pushback [getplayeruid player,_cls,_group,[]];
server setVariable ["squads",_recruits,true];