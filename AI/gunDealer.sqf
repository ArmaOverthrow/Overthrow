private ["_unit","_group"];

_unit = _this select 0;

removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeGoggles _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeVest _unit;

_unit setVariable ["NOAI",true,false];

_unit forceAddUniform (AIT_clothes_guerilla call BIS_fnc_selectRandom);

_group = group _unit;

_group setBehaviour "CARELESS";
_unit setvariable ["owner","self"];
(group _unit) allowFleeing 0;