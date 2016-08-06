private ["_unit","_group","_hour","_home","_onCivKilled","_onCivFiredNear","_hometown"];

_unit = _this select 0;

removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeGoggles _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeVest _unit;

_unit setVariable ["NOAI",1,false];

_unit forceAddUniform (AIT_clothes_guerilla call BIS_fnc_selectRandom);

_group = group _unit;
_hour = date select 3;
_home = nearestBuilding _unit;
_hometown = (getpos _unit) call nearestTown;

_group setBehaviour "CARELESS";

_unit setvariable ["owner","self"];

(group _unit) allowFleeing 0;