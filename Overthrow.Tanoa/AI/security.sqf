private ["_town","_unit","_numweap","_skill","_unit","_magazine","_weapon","_onCivKilled","_onCivFiredNear","_handleDmg"];

_unit = _this select 0;

_building = _this select 1;

[_unit, (AIT_faces_local call BIS_fnc_selectRandom)] remoteExec ["setFace", 0, _unit];
[_unit, (AIT_voices_local call BIS_fnc_selectRandom)] remoteExec ["setSpeaker", 0, _unit];

removeAllAssignedItems _unit;

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemRadio";

if(AIT_hasAce) then {
	_unit addItemToVest "ACE_fieldDressing";
	_unit addItemToVest "ACE_fieldDressing";
}else{
	_unit addItemToVest "FirstAidKit";
};