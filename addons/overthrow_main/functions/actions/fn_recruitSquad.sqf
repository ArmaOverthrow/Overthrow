if !(captive player) exitWith {"You cannot recruit while wanted" call OT_fnc_notifyMinor};

params ["_cls","_pos"];

private _cc = player getVariable ["OT_squadcount",0];

if(({side _x isEqualTo west || side _x isEqualTo east} count (_pos nearEntities 50)) > 0) exitWith {
	"You cannot recruit squads with enemies nearby" call OT_fnc_notifyMinor;
};

private _squad = _cls call OT_fnc_getSquad;
_squad params ["_cost","_soldiers","_bought","_shortname"];

private _money = player getVariable ["money",0];
if(_money < _cost) exitWith {
	format ["You need $%1",_cost] call OT_fnc_notifyMinor;
};

[-_cost] call OT_fnc_money;

private _group = creategroup resistance;
private _leader = false;
{
	_civ = [_x,_pos,_group] call OT_fnc_createSoldier;
	_civ setVariable ["OT_spawntrack",true,true];
	player reveal [_civ,4];
	if(!_leader) then {
		_group selectLeader _civ;
		[_civ,getPlayerUID player] call OT_fnc_setOwner;
		_leader=true;
	};
}foreach(_soldiers);

_group setGroupIdGlobal [format["%1-%2",_shortname,_cc]];
_cc = _cc + 1;
player hcSetGroup [_group,groupId _group,"teamgreen"];

player setVariable ["OT_squadcount",_cc,true];

private _recruits = server getVariable ["squads",[]];
_recruits pushback [getplayeruid player,_cls,_group,[]];
server setVariable ["squads",_recruits,true];

"Squad recruited, use ctrl + space to command" call OT_fnc_notifyMinor;
