private ["_unit","_numslots","_weapon","_magazine","_base","_config"];
_unit = _this select 0;
_town = _this select 1;

private _firstname = OT_firstNames_local call BIS_fnc_selectRandom;
private _lastname = OT_lastNames_local call BIS_fnc_selectRandom;
private _fullname = [format["%1 %2",_firstname,_lastname],_firstname,_lastname];
[_unit,_fullname] remoteExecCall ["setName",0,_unit];

_unit setVariable ["criminal",true,false];

_unit addEventHandler ["HandleDamage", {
	_me = _this select 0;
	_src = _this select 3;
	if(captive _src) then {
		if((vehicle _src) != _src or (_src call OT_fnc_unitSeenCRIM)) then {
			_src setCaptive false;
		};
	};
}];

[_unit, (OT_faces_local call BIS_fnc_selectRandom)] remoteExecCall ["setFace", 0, _unit];
[_unit, (OT_voices_local call BIS_fnc_selectRandom)] remoteExecCall ["setSpeaker", 0, _unit];
_unit forceAddUniform (OT_CRIM_Clothes call BIS_fnc_selectRandom);

removeAllItems _unit;
removeHeadgear _unit;
removeAllWeapons _unit;
removeVest _unit;
removeAllAssignedItems _unit;

if((random 100) > 50) then {
	_unit addHeadgear "H_Bandanna_khk";
};

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit addVest (OT_allProtectiveVests call BIS_fnc_selectRandom);
if(OT_hasTFAR) then {
	_unit linkItem "tf_fadak";
}else{
	_unit linkItem "ItemRadio";
};
_hour = date select 3;
if(_hour < 8 or _hour > 15) then {
	_unit linkItem "NVGoggles_OPFOR";
};
_unit linkItem "ItemWatch";

_weapon = (OT_allHandguns) call BIS_fnc_selectRandom;
if(random 100 > 60) then {
	_weapon = (OT_CRIM_Weapons + OT_allCheapRifles) call BIS_fnc_selectRandom;
};
_base = [_weapon] call BIS_fnc_baseWeapon;
_magazine = (getArray (configFile / "CfgWeapons" / _base / "magazines")) select 0;
if (isNil "_magazine") then {_weapon = (OT_allHandguns) call BIS_fnc_selectRandom;_base = [_weapon] call BIS_fnc_baseWeapon;_magazine = (getArray (configFile / "CfgWeapons" / _base / "magazines")) select 0;};

if !(isNil "_magazine") then {
	_unit addMagazine _magazine;
	_unit addMagazine _magazine;
	_unit addMagazine _magazine;
	_unit addMagazine _magazine;
	_unit addMagazine _magazine;
};

_unit addWeapon _weapon;

if((random 100) < 15) then {
	_unit addItem "OT_Ganja";
};

call {
	if((random 100) > 80) exitWith {
		//This is a medic
		_unit addBackpack (OT_allBackpacks call BIS_fnc_selectRandom);
		if(OT_hasACE) then {
			for "_i" from 1 to 10 do {_unit addItemToBackpack "ACE_fieldDressing";};
			for "_i" from 1 to 3 do {_unit addItemToBackpack "ACE_morphine";};
			_unit addItemToBackpack "ACE_bloodIV";
			_unit addItemToBackpack "ACE_epinephrine";
		}else{
			_unit addItemToBackpack "Medikit";
		};
	};
	if((random 100) > 90) exitWith {
		//This is an engineer
		_unit addBackpack (OT_allBackpacks call BIS_fnc_selectRandom);
		for "_i" from 1 to 2 do {_unit addItemToBackpack "DemoCharge_Remote_Mag";};
		_unit addItemToBackpack "APERSBoundingMine_Range_Mag";
		_unit addItemToBackpack "ClaymoreDirectionalMine_Remote_Mag";
		_unit addItemToBackpack "IEDUrbanSmall_Remote_Mag";

		if(OT_hasACE) then {
			_unit addItemToBackpack "ACE_DefusalKit";
			_unit addItemToBackpack "ACE_M26_Clacker";
			_unit addItemToBackpack "ACE_Clacker";
			_unit addItemToBackpack "ACE_DeadManSwitch";
		};
		_unit addItemToBackpack "Toolkit";
	};
	if((random 100) > 97) exitWith {
		//This guy just has a bit of weed
		_unit addBackpack (OT_allBackpacks call BIS_fnc_selectRandom);
		for "_i" from 1 to round(random 15) do {_unit addItemToBackpack "OT_Ganja";};
	};
};



if((random 100) > 80) then {
	_unit addItem "SmokeShell";
};

if((random 100) > 50) then {
	_unit addItem "HandGrenade";
}else{
	_unit addItem "MiniGrenade";
};

if(OT_hasACE and ((random 100) > 90)) then {
	_unit addItem "ACE_M84";
};

_unit addGoggles (OT_CRIM_Goggles call BIS_fnc_selectRandom);
