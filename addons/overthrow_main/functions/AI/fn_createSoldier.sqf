params ["_soldier","_pos","_group"];
_soldier params ["_cost","_cls","_wpn","_warehouseWpn","_pwpn","_warehousePistol","_tertiary","_warehouseTertiary","_scope","_warehouseScope","_uniform","_bino"];

//Take from warehouse
if(_warehouseWpn) then {
	[_wpn,1] call OT_fnc_removeFromWarehouse;
};
if(_warehouseScope) then {
	[_scope,1] call OT_fnc_removeFromWarehouse;
};
if(_warehousePistol) then {
	[_pwpn,1] call OT_fnc_removeFromWarehouse;
};
if(_warehouseTertiary) then {
	[_tertiary,1] call OT_fnc_removeFromWarehouse;
};



private _start = [[[_pos,30]]] call BIS_fnc_randomPos;
private _civ = _group createUnit [_cls, _start, [],0, "NONE"];

private _firstname = OT_firstNames_local call BIS_fnc_selectRandom;
private _lastname = OT_lastNames_local call BIS_fnc_selectRandom;
private _fullname = [format["%1 %2",_firstname,_lastname],_firstname,_lastname];
[_civ,_fullname] remoteExec ["setCivName",0,false];
_civ setRank "LIEUTENANT";
_civ setSkill 0.5 + (random 0.4);

[_civ, (OT_faces_local call BIS_fnc_selectRandom)] remoteExecCall ["setFace", 0, _civ];

if(_uniform != "") then {
	_civ forceAddUniform _uniform;
}else{
	_clothes = (OT_clothes_guerilla call BIS_fnc_selectRandom);
	_civ forceAddUniform _clothes;
};
_civ unlinkItem "NVGoggles_INDEP";

removeAllWeapons _civ;
removeHeadgear _civ;
removeVest _civ;

private _helmet = [] call OT_fnc_findHelmetInWarehouse;
if(_helmet != "") then {
	_civ addHeadgear _helmet;
	[_helmet,1] call OT_fnc_removeFromWarehouse;
};

private _vest = [] call OT_fnc_findVestInWarehouse;
if(_vest != "") then {
	_civ addVest _vest;
	[_vest,1] call OT_fnc_removeFromWarehouse;
};

if(_wpn != "") then {
	_civ addWeaponGlobal _wpn;
	_base = [_wpn] call BIS_fnc_baseWeapon;
	_magazine = (getArray (configFile / "CfgWeapons" / _base / "magazines")) select 0;
	_civ addMagazineGlobal _magazine;
	_civ addMagazineGlobal _magazine;
	_civ addMagazineGlobal _magazine;
	_civ addMagazineGlobal _magazine;
	_civ addMagazineGlobal _magazine;
};

if(_pwpn != "") then {
	_civ addWeaponGlobal _pwpn;
	_base = [_pwpn] call BIS_fnc_baseWeapon;
	_magazine = (getArray (configFile / "CfgWeapons" / _base / "magazines")) select 0;
	_civ addMagazineGlobal _magazine;
};

if(_tertiary != "") then {
	clearBackpackCargoGlobal _civ;
	_civ addWeaponGlobal _tertiary;
	_base = [_tertiary] call BIS_fnc_baseWeapon;
	_magazine = (getArray (configFile / "CfgWeapons" / _base / "magazines")) select 0;
	_civ addMagazineGlobal _magazine;
	_civ addMagazineGlobal _magazine;
};

if(_cls == "I_Medic_F") then {
	clearBackpackCargoGlobal _civ;
	if(OT_hasACE) then {
		for "_i" from 1 to 10 do {_civ addItemToBackpack "ACE_fieldDressing";};
		for "_i" from 1 to 3 do {_civ addItemToBackpack "ACE_morphine";};
		_civ addItemToBackpack "ACE_bloodIV";
		_civ addItemToBackpack "ACE_epinephrine";
		_civ addItemToBackpack "ACE_epinephrine";
	}else{
		_civ addItemToBackpack "Medikit";
	};
};

if((_cls find "_AA_") > -1 or (_cls find "_AAA_") > -1) then {
	clearBackpackCargoGlobal _civ;
	for "_i" from 1 to 3 do {_civ addItemToBackpack "Titan_AA";};
};

if((_cls find "_AT_") > -1 or (_cls find "_AAT_") > -1) then {
	clearBackpackCargoGlobal _civ;
	for "_i" from 1 to 3 do {_civ addItemToBackpack "Titan_AT";};
};

if(_scope != "") then {
	_civ addPrimaryWeaponItem _scope;
};

_civ
