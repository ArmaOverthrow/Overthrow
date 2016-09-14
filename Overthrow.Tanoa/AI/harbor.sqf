private ["_unit"];

_unit = _this select 0;

[_unit, (AIT_faces_local call BIS_fnc_selectRandom)] remoteExec ["setFace", 0, _unit];
[_unit, (AIT_voices_local call BIS_fnc_selectRandom)] remoteExec ["setSpeaker", 0, _unit];

removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeGoggles _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeVest _unit;

[_unit, (AIT_faces_local call BIS_fnc_selectRandom)] remoteExec ["setFace", 0, _unit];
[_unit, (AIT_voices_local call BIS_fnc_selectRandom)] remoteExec ["setSpeaker", 0, _unit];

_unit forceAddUniform (AIT_clothes_harbor call BIS_fnc_selectRandom);

_unit setvariable ["owner","self"];

_unit addEventHandler ["FiredNear", {
	_u = _this select 0;	
	_u setUnitPos "DOWN";
}];
