private ["_unit","_numslots","_weapon","_magazine","_base","_config"];
_unit = _this select 0;
_town = _this select 1;

_unit setVariable ["criminal",true,false];

_unit addEventHandler ["HandleDamage", {
	_me = _this select 0;
	_src = _this select 3;
	if(captive _src) then {
		if((vehicle _src) != _src or (_src call unitSeenCRIM)) then {
			_src setCaptive false;				
		};		
	};	
}];

_unit setFace (AIT_faces_local call BIS_fnc_selectRandom);
_unit setSpeaker (AIT_voices_local call BIS_fnc_selectRandom);
_unit forceAddUniform (AIT_CRIM_Clothes call BIS_fnc_selectRandom);

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
_unit addVest (AIT_allProtectiveVests call BIS_fnc_selectRandom);
_unit linkItem "ItemRadio";
_hour = date select 3;
if(_hour < 8 or _hour > 15) then {
	_unit linkItem "NVGoggles_OPFOR";
};
_unit linkItem "ItemWatch";

_weapon = (AIT_allAssaultRifles + AIT_allMachineGuns) call BIS_fnc_selectRandom;
_unit addWeapon _weapon;

call {
	if((random 100) > 70) exitWith {
		//This guy has a launcher
		_unit addBackpack (AIT_allBackpacks call BIS_fnc_selectRandom);	
		_launcher = (AIT_allRocketLaunchers + AIT_allMissileLaunchers) call BIS_fnc_SelectRandom;
		_base = [_launcher] call BIS_fnc_baseWeapon;
		_magazine = (getArray (configFile / "CfgWeapons" / _base / "magazines")) call BIS_fnc_SelectRandom;
		_unit addMagazine _magazine;
		_unit addMagazine _magazine;
		_unit addMagazine _magazine;	
		_unit addWeapon _launcher;
	};
	if((random 100) > 80) exitWith {
		//This is a medic
		_unit addBackpack (AIT_allBackpacks call BIS_fnc_selectRandom);	
		if(AIT_hasACE) then {
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
		_unit addBackpack (AIT_allBackpacks call BIS_fnc_selectRandom);	
		for "_i" from 1 to 2 do {_unit addItemToBackpack "DemoCharge_Remote_Mag";};
		_unit addItemToBackpack "APERSBoundingMine_Range_Mag";
		_unit addItemToBackpack "ClaymoreDirectionalMine_Remote_Mag";
		_unit addItemToBackpack "IEDUrbanSmall_Remote_Mag";
		
		if(AIT_hasACE) then {
			_unit addItemToBackpack "ACE_DefusalKit";
			_unit addItemToBackpack "ACE_M26_Clacker";
			_unit addItemToBackpack "ACE_Clacker";
			_unit addItemToBackpack "ACE_DeadManSwitch";
		};
		_unit addItemToBackpack "Toolkit";
	};
};

_base = [_weapon] call BIS_fnc_baseWeapon;
_magazine = (getArray (configFile / "CfgWeapons" / _base / "magazines")) select 0;
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

if(AIT_hasACE and ((random 100) > 90)) then {
	_unit addItem "ACE_M84";
};

_config = configfile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo";
_numslots = count(_config);
for "_i" from 0 to (_numslots-1) do {
	if (isClass (_config select _i)) then {		
		_slot = configName(_config select _i);
		if(_slot != "MuzzleSlot") then {
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
};

_weapon = AIT_allHandguns call BIS_fnc_selectRandom;
_unit addWeapon _weapon;
_base = [_weapon] call BIS_fnc_baseWeapon;
_magazine = (getArray (configFile / "CfgWeapons" / _base / "magazines")) select 0;
if !(isNil "_magazine") then {
	_unit addItem _magazine;
};

_unit addGoggles (AIT_CRIM_Goggles call BIS_fnc_selectRandom);	
