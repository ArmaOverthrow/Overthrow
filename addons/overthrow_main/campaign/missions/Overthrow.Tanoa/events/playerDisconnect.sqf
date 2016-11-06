_me = _this select 0;
_uid = _this select 2;

missionNamespace setVariable [_uid,nil,true];

_data = [];

{
	if(_x != "ot_loaded" and _x != "owner" and _x != "morale" and _x != "player_uid" and _x != "sa_tow_actions_loaded" and _x != "hiding" and _x != "randomValue" and _x != "saved3deninventory" and (_x select [0,4]) != "ace_" and (_x select [0,4]) != "cba_" and (_x select [0,4]) != "bis_") then {
		_data pushback [_x,_me getVariable _x];
	};
}foreach(allVariables _me);

server setVariable [_uid,_data,false];

server setVariable [format["loadout%1",_uid],getUnitLoadout _me,false];