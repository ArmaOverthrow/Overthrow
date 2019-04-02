params ["_civ"];

removeAllActions _civ;
_civ removeAllEventHandlers "FiredNear";

[_civ, selectRandom OT_voices_local] remoteExecCall ["setSpeaker", 0, _civ];

_civ setSkill 0.1 + (random 0.3);
_civ setRank "PRIVATE";
_civ setVariable ["NOAI",true,true];

_civ call OT_fnc_wantedSystem;

private _recruits = server getVariable ["recruits",[]];
private _nameparts = [name _civ];
_nameparts append (name _civ splitString " ");

_recruits pushback [getplayeruid player,_nameparts,_civ,"PRIVATE",[],typeof _civ];
server setVariable ["recruits",_recruits,true];
