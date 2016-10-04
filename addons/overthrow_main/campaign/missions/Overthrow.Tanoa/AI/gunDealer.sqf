private ["_unit","_group"];

_unit = _this select 0;

[_unit, (OT_faces_local call BIS_fnc_selectRandom)] remoteExec ["setFace", 0, _unit];
[_unit, (OT_voices_local call BIS_fnc_selectRandom)] remoteExec ["setSpeaker", 0, _unit];

removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeGoggles _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeVest _unit;

[_unit, (OT_faces_local call BIS_fnc_selectRandom)] remoteExec ["setFace", 0, _unit];
[_unit, (OT_voices_local call BIS_fnc_selectRandom)] remoteExec ["setSpeaker", 0, _unit];

_unit setVariable ["NOAI",true,false];

_unit forceAddUniform (OT_clothes_guerilla call BIS_fnc_selectRandom);

_group = group _unit;

_group setBehaviour "CARELESS";
_unit setvariable ["owner","self",true];
(group _unit) allowFleeing 0;