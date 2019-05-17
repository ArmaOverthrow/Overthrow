_unit = _this select 0;

_type = typeof _unit;

//Re-Equip this soldier
_items = primaryWeaponItems _unit;
if !(_items#0 isEqualTo "") then {
	if((random 100) < 99) then {
		//Make silencers rare
		_unit removePrimaryWeaponItem (_items#0);
	}
};
//Primary Weapon
_accessories = _unit weaponAccessories primaryWeapon _unit;
_base = [primaryWeapon _unit] call BIS_fnc_baseWeapon;
_unit removeWeapon (primaryWeapon _unit);
_magazines = getArray (configFile / "CfgWeapons" / _base / "magazines");
_stock = _unit call OT_fnc_unitStock;
{
	_x params ["_cls","_num"];
	if(_cls in _magazines) then {
		private _count = 0;
		while {_count < _num} do {
			_unit removeMagazineGlobal _cls;
			_count = _count + 1;
		};
	};
}foreach(_stock);


_wpn = _base call {
	if(_this in OT_allBLUGLRifles) exitWith {selectRandom OT_allBLUGLRifles};
	if(_this in OT_allBLUSniperRifles) exitWith {_unit addItemToUniform "ACE_rangeCard";selectRandom OT_allBLUSniperRifles};
	if(_this in OT_allBLUMachineGuns) exitWith {selectRandom OT_allBLUMachineGuns};
	selectRandom OT_allBLURifles;
};

_unit addWeapon _wpn;
//put accessories back (where possible)
{
	_unit addWeaponItem [_wpn, _x];
}foreach(_accessories);

_magazines = getArray (configFile / "CfgWeapons" / _wpn / "magazines");

_mag = selectRandom _magazines;
_unit addWeaponItem [_wpn, _mag];
_unit addMagazineGlobal _mag;
_unit addMagazineGlobal _mag;
_unit addMagazineGlobal _mag;
_unit addMagazineGlobal _mag;
_unit addMagazineGlobal _mag;
_unit addMagazineGlobal _mag;

_secondmags = [];
{
	if !(_x isEqualTo "this") then {
		_secondmags = _secondmags + getArray (configFile / "CfgWeapons" / _wpn / _x / "magazines")
	};
}foreach(getArray (configFile / "CfgWeapons" / _wpn / "muzzles"));
if((count _secondmags) > 0) then {
	_mag = _secondmags select 0;
	_unit addWeaponItem [_wpn, _mag];
	_unit addMagazineGlobal _mag;
	_unit addMagazineGlobal _mag;
	_unit addMagazineGlobal _mag;
	_unit addMagazineGlobal _mag;
	_unit addMagazineGlobal _mag;
	_unit addMagazineGlobal _mag;
};

//Secondary Weapon
if !((_type find "_AA_") > -1) then {
	if !(secondaryWeapon _unit isEqualTo "") then {
		_base = [secondaryWeapon _unit] call BIS_fnc_baseWeapon;
		_unit removeWeapon (secondaryWeapon _unit);
		_magazines = getArray (configFile / "CfgWeapons" / _base / "magazines");
		{
			_x params ["_cls","_num"];
			if(_cls in _magazines) then {
				private _count = 0;
				while {_count < _num} do {
					_unit removeMagazineGlobal _cls;
					_count = _count + 1;
				};
			};
		}foreach(_stock);
		_wpn = selectRandom OT_allBLULaunchers;
		_unit addWeapon _wpn;
		_magazines = getArray (configFile / "CfgWeapons" / _wpn / "magazines");

		_mag = selectRandom _magazines;
		if !(_mag isEqualTo "ACE_PreloadedMissileDummy") then {
			_unit addWeaponItem [_wpn, _mag];
			_unit addMagazineGlobal _mag;
			_unit addMagazineGlobal _mag;
		}else{
			removeBackpack _unit;
		};
	};
};

//Pistol
_base = [handgunWeapon _unit] call BIS_fnc_baseWeapon;
_unit removeWeapon (handgunWeapon _unit);
_magazines = getArray (configFile / "CfgWeapons" / _base / "magazines");
{
	_x params ["_cls","_num"];
	if(_cls in _magazines) then {
		private _count = 0;
		while {_count < _num} do {
			_unit removeMagazineGlobal _cls;
			_count = _count + 1;
		};
	};
}foreach(_stock);

_wpn = selectRandom OT_allBLUPistols;
_unit addWeapon _wpn;
_magazines = getArray (configFile / "CfgWeapons" / _wpn / "magazines");

_mag = selectRandom _magazines;
_unit addWeaponItem [_wpn, _mag];
_unit addMagazineGlobal _mag;
_unit addMagazineGlobal _mag;

_unit selectWeapon (primaryWeapon _unit);

_unit addEventHandler ["HandleDamage", {
	_me = _this select 0;
	_src = _this select 3;
	if(captive _src) then {
		if((vehicle _src) != _src || (_src call OT_fnc_unitSeenNATO)) then {
			_src setCaptive false;
		};
	};
}];
