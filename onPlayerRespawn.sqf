if (isDedicated) exitWith {};
_new = _this select 0;
_old = _this select 1;

if(isNull(_old)) exitWith {};

titleText ["", "BLACK FADED", 0];

waitUntil {alive player};
player setCaptive true;
player allowDamage false;

removeHeadgear player;
removeAllWeapons player;
removeAllAssignedItems player;
removeGoggles player;
removeBackpack player;
removeVest player;

player addWeapon "ItemMap";

sleep 2;

_house = _old getVariable "home";
_town = (getpos _house) call nearestTown;
_housepos = getpos _house;

player setVariable ["home",_house,true];

player setPos _housepos;

titleText ["", "BLACK IN", 5];

[] execVM "setupPlayer.sqf";

sleep 5;
player allowDamage true;

