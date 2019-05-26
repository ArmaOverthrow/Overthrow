private ["_unit","_numslots","_weapon","_magazine","_base","_config"];
_unit = _this;

_unit setVariable ["mobster",true,false];

private _firstname = OT_firstNames_local call BIS_fnc_selectRandom;
private _lastname = OT_lastNames_local call BIS_fnc_selectRandom;
private _fullname = [format["%1 %2",_firstname,_lastname],_firstname,_lastname];
[_unit,_fullname] remoteExecCall ["setName",0,_unit];

_unit addEventHandler ["HandleDamage", {
	_me = _this select 0;
	_src = _this select 3;
	if(captive _src) then {
		if((vehicle _src) != _src || (_src call OT_fnc_unitSeenCRIM)) then {
			_src setCaptive false;
		};
	};
}];

[_unit, (OT_faces_local call BIS_fnc_selectRandom)] remoteExecCall ["setFace", 0, _unit];
[_unit, (OT_voices_local call BIS_fnc_selectRandom)] remoteExecCall ["setSpeaker", 0, _unit];
_unit forceAddUniform OT_clothes_mob;

removeAllItems _unit;
removeHeadgear _unit;
removeAllWeapons _unit;
removeVest _unit;
removeAllAssignedItems _unit;

_unit addWeaponGlobal "Laserdesignator_02_ghex_F";
_unit addGoggles "G_Bandanna_beast";
_unit addHeadgear "H_Booniehat_khk";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit addVest (OT_allProtectiveVests call BIS_fnc_selectRandom);
if(OT_hasTFAR) then {
	_unit linkItem "tf_fadak";
}else{
	_unit linkItem "ItemRadio";
};
_hour = date select 3;
if(_hour < 8 || _hour > 15) then {
	_unit linkItem "O_NVGoggles_ghex_F";
};

_unit linkItem "ACE_Altimeter";


if((random 100) < 15) then {
	_unit addItem "OT_Ganja";
	_unit addItem "OT_Ganja";
};

_weapon = (OT_CRIM_Weapons) call BIS_fnc_selectRandom;

_unit addWeaponGlobal _weapon;

[_unit] call {
	params ["_unit"];
	if((random 100) > 98) exitWith {
		//This guy has a launcher
		_unit addBackpack (OT_allBackpacks call BIS_fnc_selectRandom);
		_launcher = OT_CRIM_Launchers select 0;
		_base = [_launcher] call BIS_fnc_baseWeapon;
		_magazine = (getArray (configFile / "CfgWeapons" / _base / "magazines")) call BIS_fnc_SelectRandom;
		_unit addMagazine _magazine;
		_unit addMagazine _magazine;
		_unit addMagazine _magazine;
		_unit addWeaponGlobal _launcher;
	};
	if((random 100) > 85) exitWith {
		//This is a medic
		_unit addBackpack (OT_allBackpacks call BIS_fnc_selectRandom);

		for "_i" from 1 to 10 do {_unit addItemToBackpack "ACE_fieldDressing";};
		for "_i" from 1 to 3 do {_unit addItemToBackpack "ACE_morphine";};
		_unit addItemToBackpack "ACE_bloodIV";
		_unit addItemToBackpack "ACE_epinephrine";
	};
	if((random 100) > 95) exitWith {
		//This is an engineer
		_unit addBackpack (OT_allBackpacks call BIS_fnc_selectRandom);
		for "_i" from 1 to 2 do {_unit addItemToBackpack "DemoCharge_Remote_Mag";};
		_unit addItemToBackpack "APERSBoundingMine_Range_Mag";
		_unit addItemToBackpack "ClaymoreDirectionalMine_Remote_Mag";
		_unit addItemToBackpack "IEDUrbanSmall_Remote_Mag";

		_unit addItemToBackpack "ACE_DefusalKit";
		_unit addItemToBackpack "ACE_M26_Clacker";
		_unit addItemToBackpack "ACE_Clacker";
		_unit addItemToBackpack "ACE_DeadManSwitch";

		_unit addItemToBackpack "Toolkit";
	};
	if((random 100) > 97) exitWith {
		//This guy just has a shitload of weed
		_unit addBackpack (OT_allBackpacks call BIS_fnc_selectRandom);
		for "_i" from 1 to round(random 30) do {_unit addItemToBackpack "OT_Ganja";};
	};
};

_base = [_weapon] call BIS_fnc_baseWeapon;
_magazine = (getArray (configFile / "CfgWeapons" / _base / "magazines")) call BIS_fnc_SelectRandom;
_unit addMagazine _magazine;
_unit addMagazine _magazine;
_unit addMagazine _magazine;
_unit addMagazine _magazine;
_unit addMagazine _magazine;

if((random 100) > 80) then {
	_unit addItem "SmokeShell";
};

if((random 100) > 50) then {
	_unit addItem "HandGrenade";
}else{
	_unit addItem "MiniGrenade";
};

if((random 100) > 90) then {
	_unit addItem "ACE_M84";
};

_config = configfile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo";
_numslots = count(_config);
for "_i" from 0 to (_numslots-1) do {
	if (isClass (_config select _i)) then {
		_slot = configName(_config select _i);
		_com = _config >> _slot >> "compatibleItems";
		_items = [];
		if (isClass (_com)) then {
			for "_t" from 0 to (count(_com)-1) do {
				_items pushback (configName(_com select _t));
			};
		}else{
			_items = getArray(_com);
		};
		if(count _items > 0) then {
			_cls = _items call BIS_fnc_selectRandom;
			_unit addPrimaryWeaponItem _cls;
		};
	};
};

_weapon = OT_allHandguns call BIS_fnc_selectRandom;
_unit addWeaponGlobal _weapon;
_base = [_weapon] call BIS_fnc_baseWeapon;
_magazine = (getArray (configFile / "CfgWeapons" / _base / "magazines")) select 0;
if !(isNil "_magazine") then {
	_unit addItem _magazine;
};
