private ["_unit"];

_unit = _this select 0;

removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeGoggles _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeVest _unit;

_unit setFace (AIT_faces_local call BIS_fnc_selectRandom);
_unit setSpeaker (AIT_voices_local call BIS_fnc_selectRandom);

_unit forceAddUniform (AIT_clothes_carDealers call BIS_fnc_selectRandom);

_unit setvariable ["owner","self"];

_unit addEventHandler ["FiredNear", {
	_u = _this select 0;	
	_u setUnitPos "DOWN";
}];