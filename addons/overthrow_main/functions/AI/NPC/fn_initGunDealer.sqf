private ["_unit","_group"];

_unit = _this select 0;

(group _unit) setVariable ["VCM_Disable",true];

private _firstname = OT_firstNames_local call BIS_fnc_selectRandom;
private _lastname = OT_lastNames_local call BIS_fnc_selectRandom;
private _fullname = [format["%1 %2",_firstname,_lastname],_firstname,_lastname];
[_unit,_fullname] remoteExecCall ["setName",0,_unit];

[_unit, (OT_faces_local call BIS_fnc_selectRandom)] remoteExecCall ["setFace", 0, _unit];
[_unit, "NoVoice"] remoteExecCall ["setSpeaker", 0, _unit];

removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeGoggles _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeVest _unit;

_unit setVariable ["NOAI",true,false];

_unit forceAddUniform (OT_clothes_guerilla call BIS_fnc_selectRandom);
_unit addGoggles (selectRandom OT_allGlasses);

_group = group _unit;

_group setBehaviour "CARELESS";
[_unit,"self"] call OT_fnc_setOwner;
(group _unit) allowFleeing 0;
