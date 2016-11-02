private ["_unit"];

_unit = _this select 0;
_unit setskill ["courage",1];
private _firstname = OT_firstNames_local call BIS_fnc_selectRandom;
private _lastname = OT_lastNames_local call BIS_fnc_selectRandom;
private _fullname = [format["%1 %2",_firstname,_lastname],_firstname,_lastname];
[_unit,_fullname] remoteExec ["setCivName",0,false];

removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeGoggles _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeVest _unit;

_unit setVariable ["NOAI",true,false];

[_unit, (OT_faces_local call BIS_fnc_selectRandom)] remoteExec ["setFace", 0, _unit];
[_unit, "NoVoice"] remoteExec ["setSpeaker", 0, _unit];

_unit forceAddUniform (OT_clothes_locals call BIS_fnc_selectRandom);

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