if (isDedicated) exitWith {};
_new = _this select 0;
_old = _this select 1;

if(isNull(_old)) exitWith {};

titleText ["", "BLACK FADED", 0];

waitUntil {alive player};
player setCaptive true;
player allowDamage false;

_group = creategroup resistance;
[player] joinSilent nil;
[player] joinSilent _group;
_recruits = server getVariable ["recruits",[]];
_newrecruits = [];
{
	_owner = _x select 0;
	_name = _x select 1;
	_civ = _x select 2;
	if(_owner isEqualTo (getplayeruid player)) then {
		if(typename _civ isEqualTo "OBJECT") then {
			if(_civ call OT_fnc_playerIsOwner) then {
				[_civ] joinSilent (group player);
				commandStop _civ;
			};
		};
	};
}foreach (_recruits);

private _money = player getVariable ["money",0];
private _take = floor(_money * 0.05);
if(_take > 0) then {
	[-_take] call OT_fnc_money;
};

removeHeadgear player;
removeAllWeapons player;
removeAllAssignedItems player;
removeGoggles player;
removeBackpack player;
removeVest player;

player setVariable ["ot_isSmoking", false];
player addWeapon "ItemMap";

_housepos = _old getVariable "home";
_town = _housepos call OT_fnc_nearestTown;
player setPos _housepos;
_clothes = uniform _old;
player forceAddUniform _clothes;
[] spawn OT_fnc_setupPlayer;

call {
	disableSerialization;
	_display = uiNameSpace getVariable "OT_statsHUD";
	if(isNil "_display") exitWith{};
	_setText = _display displayCtrl 1001;
	_setText ctrlSetStructuredText (parseText "");
	_setText ctrlCommit 0;
};

titleText ["", "BLACK IN", 5];

[] spawn {
	sleep 5;
	player allowDamage true;
};
