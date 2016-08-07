private ["_town","_unit","_numweap","_skill","_unit","_magazine","_weapon","_onCivKilled","_onCivFiredNear","_handleDmg"];

_unit = _this select 0;

_building = _this select 1;


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