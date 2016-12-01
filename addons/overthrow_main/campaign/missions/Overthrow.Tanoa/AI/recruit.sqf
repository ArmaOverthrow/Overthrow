private ["_civ"];

_civ = _this select 0;

removeAllActions _civ;
_civ removeAllEventHandlers "FiredNear";

[_civ, (OT_voices_local call BIS_fnc_selectRandom)] remoteExecCall ["setSpeaker", 0, _civ];

_civ setSkill 1.0;
_civ setRank "PRIVATE";

_civ spawn wantedSystem;

_recruits = server getVariable ["recruits",[]];
_nameparts = (name _civ) splitString " ";

_recruits pushback [getplayeruid player,[name _civ]+_nameparts,_civ,"PRIVATE",[],typeof _civ];
server setVariable ["recruits",_recruits,true];