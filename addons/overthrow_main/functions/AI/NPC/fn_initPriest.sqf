private ["_unit"];

_unit = _this select 0;
_unit setskill ["courage",1];
private _firstname = selectRandom OT_firstNames_local;
private _lastname = selectRandom OT_lastNames_local;
private _fullname = [format["%1 %2",_firstname,_lastname],_firstname,_lastname];
[_unit,_fullname] remoteExecCall ["setName",0,_unit];

removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeGoggles _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeVest _unit;

[_unit,"self"] call OT_fnc_setOwner;

[_unit, (selectRandom OT_faces_local)] remoteExecCall ["setFace", 0, _unit];
[_unit, "NoVoice"] remoteExecCall ["setSpeaker", 0, _unit];

_unit forceAddUniform OT_clothes_priest;
_unit disableAI "FSM";

_unit addEventHandler ["FiredNear", {
	_u = _this select 0;
	if !(_u getVariable ["fleeing",false]) then {
		_u setVariable ["fleeing",true,false];
		_u setBehaviour "COMBAT";
		_by = _this select 1;
		_u allowFleeing 1;
		_u setskill ["courage",0];
	};
}];
