private ["_unit"];

_unit = _this select 0;
_unit setskill ["courage",1];
private _firstname = AIT_firstNames_local call BIS_fnc_selectRandom;
private _lastname = AIT_lastNames_local call BIS_fnc_selectRandom;
_unit setName [format["%1 %2",_firstname,_lastname],_firstname,_lastname];

removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeGoggles _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeVest _unit;

[_unit, (AIT_faces_local call BIS_fnc_selectRandom)] remoteExec ["setFace", 0, _unit];
[_unit, (AIT_voices_local call BIS_fnc_selectRandom)] remoteExec ["setSpeaker", 0, _unit];

_unit forceAddUniform (AIT_clothes_locals call BIS_fnc_selectRandom);

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