private ["_town","_unit","_numweap","_skill","_unit","_magazine","_weapon","_stability","_idx"];

_unit = _this select 0;

[_unit, (OT_faces_local call BIS_fnc_selectRandom)] remoteExecCall ["setFace", 0, _unit];
[_unit, (OT_voices_local call BIS_fnc_selectRandom)] remoteExecCall ["setSpeaker", 0, _unit];

_town = _this select 1;

_unit setVariable ["garrison",_town,false];

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

_skill = 0.5;
if(_stability < 60) then {
	_skill = 0.6;
};
if(_stability < 50) then {
	_skill = 0.7;
};
if(_stability < 40) then {
	_skill = 0.8;
};
if(_stability < 30) then {
	_skill = 0.9;
};

removeAllWeapons _unit;

_hour = date select 3;
if(_skill > 0.8) then {
	if(_hour > 17 || _hour < 6) then {
		_unit linkItem "NVGoggles_OPFOR";
	};
	_unit addGoggles "G_Bandanna_aviator";
};

if(OT_hasACE) then {
	_unit addItem "ACE_fieldDressing";
	_unit addItem "ACE_fieldDressing";
	_unit addItem "ACE_morphine";
};

private _weapons = OT_allSubMachineGuns;
if(count OT_NATO_weapons_Police > 0) then {
	_weapons = OT_NATO_weapons_Police;
};

_weapon = selectRandom _weapons;
_base = [_weapon] call BIS_fnc_baseWeapon;
_magazine = (getArray (configFile / "CfgWeapons" / _base / "magazines")) select 0;
_unit addMagazineGlobal _magazine;
_unit addMagazineGlobal _magazine;
_unit addMagazineGlobal _magazine;
_unit addWeaponGlobal _weapon;

if(_hour > 17 || _hour < 6) then {
	_unit addPrimaryWeaponItem "acc_flashlight";
};

if((random 100) > 80) exitWith {
	_unit addPrimaryWeaponItem "optic_Aco_smg"
};

_weapon = OT_NATO_weapons_Pistols call BIS_fnc_selectRandom;
_base = [_weapon] call BIS_fnc_baseWeapon;
_magazine = (getArray (configFile / "CfgWeapons" / _base / "magazines")) select 0;
_unit addMagazineGlobal _magazine;
_unit addMagazineGlobal _magazine;
_unit addWeaponGlobal _weapon;
