private ["_unit"];

_unit = _this select 0;

private _firstname = OT_firstNames_local call BIS_fnc_selectRandom;
private _lastname = OT_lastNames_local call BIS_fnc_selectRandom;
private _fullname = [format["%1 %2",_firstname,_lastname],_firstname,_lastname];
[_unit,_fullname] remoteExec ["setCivName",0,false];

[_unit, (OT_faces_local call BIS_fnc_selectRandom)] remoteExec ["setAIFace", 0, _unit];
[_unit, "NoVoice"] remoteExec ["setAISpeaker", 0, _unit];

removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeGoggles _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeVest _unit;

_unit forceAddUniform (OT_clothes_harbor call BIS_fnc_selectRandom);

_unit setvariable ["owner","self"];

_unit addEventHandler ["FiredNear", {
	_u = _this select 0;	
	_u setUnitPos "DOWN";
}];
