private ["_town","_unit","_numweap","_skill","_unit","_magazine","_weapon","_stability","_idx"];

private _unit = _this select 0;
private _town = _this select 1;

private _firstname = OT_firstNames_local call BIS_fnc_selectRandom;
private _lastname = OT_lastNames_local call BIS_fnc_selectRandom;
private _fullname = [format["%1 %2",_firstname,_lastname],_firstname,_lastname];
[_unit,_fullname] remoteExecCall ["setName",0,_unit];

_unit forceAddUniform (OT_clothes_police call BIS_fnc_selectRandom);
_unit addVest OT_vest_police;
_unit addHeadgear OT_hat_police;

[_unit, (OT_faces_local call BIS_fnc_selectRandom)] remoteExecCall ["setFace", 0, _unit];
[_unit, (OT_voices_local call BIS_fnc_selectRandom)] remoteExecCall ["setSpeaker", 0, _unit];

_unit setVariable ["polgarrison",_town,false];

_stability = server getVariable format["stability%1",_town];

_unit addEventHandler ["HandleDamage", {
	_me = _this select 0;
	_src = _this select 3;
	if(captive _src) then {
		if((vehicle _src) != _src || (_src call OT_fnc_unitSeenNATO)) then {
			_src setCaptive false;
		};
	};
}];

removeAllWeapons _unit;

private _cost = 0;
private _wpn = ["AssaultRifle"] call OT_fnc_findWeaponInWarehouse;
if(_wpn isEqualTo "") then {
	_possible = [];
	{
		_weapon = [_x] call BIS_fnc_itemType;
		if((_weapon select 1) isEqualTo "SubmachineGun") then {_possible pushback _x};
	}foreach(OT_allWeapons);
	_sorted = [_possible,[],{(cost getvariable [_x,[200]]) select 0},"ASCEND"] call BIS_fnc_SortBy;
	_wpn = _sorted select 0;
}else{
	_warehouseWpn = true;
};
_unit addWeapon _wpn;

_hour = date select 3;

_unit addPrimaryWeaponItem "acc_flashlight";
_unit addGoggles (selectRandom OT_allGlasses);
_unit addItem "ACE_morphine";
_unit addItem "ACE_epinephrine";
_unit addItem "ACE_fieldDressing";
_unit addItem "ACE_fieldDressing";
if((random 100) > 95) exitWith {
	_unit addPrimaryWeaponItem "optic_Aco_smg"
};

_base = [_wpn] call BIS_fnc_baseWeapon;
_magazine = (getArray (configFile / "CfgWeapons" / _base / "magazines")) select 0;
_unit addMagazineGlobal _magazine;
_unit addMagazineGlobal _magazine;
_unit addMagazineGlobal _magazine;
_unit addMagazineGlobal _magazine;
_unit addMagazineGlobal _magazine;

_weapon = OT_NATO_weapons_Pistols call BIS_fnc_selectRandom;
_base = [_weapon] call BIS_fnc_baseWeapon;
_magazine = (getArray (configFile / "CfgWeapons" / _base / "magazines")) select 0;
_unit addMagazineGlobal _magazine;
_unit addMagazineGlobal _magazine;
_unit addWeapon _weapon;
