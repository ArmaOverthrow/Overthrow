private ["_unit","_group","_home"];

_unit = _this select 0;

removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeGoggles _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeVest _unit;

_unit setFace (AIT_faces_local call BIS_fnc_selectRandom);
_unit setSpeaker (AIT_voices_local call BIS_fnc_selectRandom);

_unit setVariable ["NOAI",true,false];

(group _unit) allowFleeing 0;

_unit forceAddUniform (AIT_clothes_carDealers call BIS_fnc_selectRandom);

_group = group _unit;
_home = nearestBuilding _unit;
_group setBehaviour "CARELESS";

_unit setvariable ["owner","self"];