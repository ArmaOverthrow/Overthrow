params ["_me","","_uid"];

if(_me getVariable ["ACE_isUnconscious",false]) then {
	removeAllWeapons _me;
	removeAllItems _me;
	removeAllAssignedItems _me;
	removeBackpack _me;
	removeVest _me;
	removeGoggles _me;
	removeHeadgear _me;

	_me addItem "ItemMap";
};

[_me] call OT_fnc_savePlayerData;
