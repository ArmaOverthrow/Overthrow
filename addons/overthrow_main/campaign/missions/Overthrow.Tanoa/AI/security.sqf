private ["_town","_unit","_numweap","_skill","_unit","_magazine","_weapon","_onCivKilled","_onCivFiredNear","_handleDmg"];

_unit = _this select 0;

_building = _this select 1;

[_unit, (OT_faces_local call BIS_fnc_selectRandom)] remoteExec ["setAIFace", 0, _unit];
[_unit, (OT_voices_local call BIS_fnc_selectRandom)] remoteExec ["setAISpeaker", 0, _unit];

removeAllAssignedItems _unit;

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
if(OT_hasTFAR) then {
	_unit linkItem "tf_anprc152";
}else{
	_unit linkItem "ItemRadio";
};

if(OT_hasAce) then {
	_unit addItemToVest "ACE_fieldDressing";
	_unit addItemToVest "ACE_fieldDressing";
}else{
	_unit addItemToVest "FirstAidKit";
};