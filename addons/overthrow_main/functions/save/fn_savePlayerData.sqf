params ["_player"];

private _uid = getPlayerUid _player;
private _data = [];

{
	_data pushback [_x,_player getVariable _x];
}foreach(allVariables _player select {
	_x = toLower _x;
	!(_x in ["ot_loaded", "morale", "player_uid", "sa_tow_actions_loaded", "hiding", "randomValue", "saved3deninventory"])
	&& { !((_x select [0,4]) in ["ace_", "cba_", "bis_"]) }
	&& { (_x select [0,11]) != "missiondata" }
	&& { (_x select [0,9]) != "seencache"}
});

players_NS setVariable [_uid,_data,true];
players_NS setVariable [format["loadout%1",_uid],getUnitLoadout _player,true];
