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

_housepos = _old getVariable "home";
_town = _housepos call nearestTown;
player setPos _housepos;
[] execVM "setupPlayer.sqf";

call {	
	disableSerialization;
	_display = uiNameSpace getVariable "OT_statsHUD";
	if(isNil "_display") exitWith{};
	_setText = _display displayCtrl 1001;
	_setText ctrlSetStructuredText (parseText "");
	_setText ctrlCommit 0;
};

titleText ["", "BLACK IN", 5];



sleep 5;
player allowDamage true;

