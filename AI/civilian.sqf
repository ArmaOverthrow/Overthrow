private ["_unit","_group","_hour","_home","_onCivKilled","_onCivFiredNear","_hometown"];

_unit = _this select 0;

removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeGoggles _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeVest _unit;

(group _unit) allowFleeing 1;

_clothes = AIT_clothes_locals;

if((typeof _unit) in AIT_civTypes_expats) then {
	_clothes = AIT_clothes_expats;
};

_unit forceAddUniform (_clothes call BIS_fnc_selectRandom);