params ["_player"];
if !(_player getVariable ["OT_Loaded",false]) exitWith {};

private _uid = getPlayerUid _player;
private _data = [];

{
	private _v = _player getVariable _x;
	if (!isNil "_v") then {
		if(_x isEqualTo "home" && !(_v isEqualType [])) then {
			_owned = (_player getVariable "owned");
			if(count _owned isEqualTo 0) then {
				diag_log format["Warning: Player %1 owns no buildings to be set as home",name _player];
				//fallback to current pos
				_v = getpos _player;
			}else{
				_buildid = _owned select 0;
				_pos = buildingpositions getVariable [_buildid,[]];
				if(count _pos isEqualTo 0) then {
					//fallback to current pos
					_v = getpos player;
				}else{
					_v = _pos;
				};
			};
		};
		_data pushback [_x,_v];
	};
}foreach(allVariables _player select {
	_x = toLower _x;
	!(_x in ["ot_loaded", "morale", "player_uid", "hiding", "randomValue", "saved3deninventory", "babe_em_vars"])
	&& { !((_x select [0,4]) in ["ace_", "cba_", "bis_", "aur_"]) }
	&& { !((_x select [0,3]) in ["sa_", "ar_"]) }
	&& { (_x select [0,11]) != "missiondata" }
	&& { (_x select [0,9]) != "seencache"}
});

players_NS setVariable [_uid,_data,true];
players_NS setVariable [format["loadout%1",_uid],getUnitLoadout _player,true];
