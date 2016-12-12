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
		if((vehicle _src) != _src or (_src call unitSeenNATO)) then {
			_src setCaptive false;				
		};		
	};	
}];

removeAllWeapons _unit;

_numweap = (count OT_NATO_weapons_Police)-1;
_idx = _numweap - 4;

if(_stability > 85) then {
	_idx = _numweap;
};
_hour = date select 3;
if(_stability > 80) then {
	if(_hour > 17 or _hour < 6) then {
		_unit linkItem "NVGoggles_OPFOR";
	};
	_unit addGoggles "G_Bandanna_aviator";
	_unit addWeapon "Rangefinder";
	_idx = _numweap - 1;
	if(OT_hasAce) then {
		_unit addItemToUniform "ACE_rangeCard";
		_unit addItem "ACE_morphine";
	};
}else{	
	if(_stability > 70) then {
		_idx = _numweap - 2;
	}else{
		if(_stability > 60) then {
			_idx = _numweap - 3;
			_unit linkItem "ItemGPS";
		};
	};
};

if(OT_hasACE) then {
	_unit addItem "ACE_fieldDressing";
	_unit addItem "ACE_fieldDressing";
};

_weapon = OT_NATO_weapons_Police select round(random(_idx));
_base = [_weapon] call BIS_fnc_baseWeapon;
_magazine = (getArray (configFile / "CfgWeapons" / _base / "magazines")) select 0;
_unit addMagazine _magazine;
_unit addMagazine _magazine;
_unit addMagazine _magazine;
_unit addMagazine _magazine;
_unit addMagazine _magazine;
_unit addWeapon _weapon;

if(_hour > 17 or _hour < 6) then {
	_unit addPrimaryWeaponItem "acc_flashlight";
};

_weapon = OT_NATO_weapons_Pistols call BIS_fnc_selectRandom;
_base = [_weapon] call BIS_fnc_baseWeapon;
_magazine = (getArray (configFile / "CfgWeapons" / _base / "magazines")) select 0;
_unit addMagazine _magazine;
_unit addMagazine _magazine;
_unit addWeapon _weapon;

if(_stability > 80) then {
	_unit addPrimaryWeaponItem "optic_Holosight_blk_F";
}else{	
	_unit addPrimaryWeaponItem "optic_Aco";
};
