closeDialog 0;
params ["_unit","_ammobox","_name"];

private _loadout = profileNamespace getVariable format["OT_loadout_%1",_name];
_loadout params ["_primary","_secondary","_tertiary","_uniform","_vest","_backpack","_headgear","_goggles","_optic","_assigned"];

[_unit,_ammobox] call OT_fnc_dumpStuff;

if(count _primary > 0) then {
	private _pWpn = _primary select 0;
	private _pItems = [_primary select 1,_primary select 2,_primary select 3];
	private _pAmmo = (_primary select 4) select 0;

	if([_ammobox,_pWpn,1] call CBA_fnc_removeWeaponCargo) then {
		_unit addWeaponGlobal _pWpn;
		if(!isNil "_pAmmo") then {
			if([_ammobox,_pAmmo,1] call CBA_fnc_removeMagazineCargo) then {
				_unit addMagazine _pAmmo;
			};
		};
		{
			if([_ammobox,_x,1] call CBA_fnc_removeItemCargo) then {
				_unit addPrimaryWeaponItem _x;
			};
		}foreach(_pItems);
	};
};

if(count _secondary > 0) then {
	private _sWpn = _secondary select 0;
	private _sItems = [_secondary select 1,_secondary select 2,_secondary select 3];
	private _sAmmo = (_secondary select 4) select 0;

	if([_ammobox,_sWpn,1] call CBA_fnc_removeWeaponCargo) then {
		_unit addWeaponGlobal _sWpn;
		if(!isNil "_sAmmo") then {
			if([_ammobox,_sAmmo,1] call CBA_fnc_removeMagazineCargo) then {
				_unit addMagazine _sAmmo;
			};
		};
		{
			if([_ammobox,_x,1] call CBA_fnc_removeItemCargo) then {
				_unit addSecondaryWeaponItem _x;
			};
		}foreach(_sItems);
	};
};

if(count _tertiary > 0) then {
	private _tWpn = _tertiary select 0;
	private _tItems = [_tertiary select 1,_tertiary select 2,_tertiary select 3];
	private _tAmmo = (_tertiary select 4) select 0;

	if([_ammobox,_tWpn,1] call CBA_fnc_removeWeaponCargo) then {
		_unit addWeaponGlobal _tWpn;
		if(!isNil "_tAmmo") then {
			if([_ammobox,_tAmmo,1] call CBA_fnc_removeMagazineCargo) then {
				_unit addMagazine _tAmmo;
			};
		};
	};
};

if (count _uniform > 0) then {
	private _uniformCls = _uniform select 0;
	private _uniformItems = _uniform select 1;
};

if(count _vest > 0) then {
	private _vestCls = _vest select 0;
	private _vestItems = _vest select 1;

	if([_ammobox,_vestCls,1] call CBA_fnc_removeItemCargo) then {
		_unit addVest _vestCls;
		{
			_x params ["_cc", "_num"];
			if(_cc isEqualType []) then {_cc = _cc select 0};
			private _count = 0;

			private _func = CBA_fnc_removeWeaponCargo;
			[_cc] call {
				params ["_cc"];
				if(_cc isKindOf ["ItemCore",configFile >> "CfgWeapons"]) exitWith {
					_func = CBA_fnc_removeItemCargo;
				};
				if(_cc isKindOf ["Default",configFile >> "CfgMagazines"]) exitWith {
					_func = CBA_fnc_removeMagazineCargo;
				};
			};
			while {_count < _num} do {
				if([_ammobox,_cc,1] call _func) then {
					_unit addItemToVest _cc;
				};
				_count = _count + 1;
			};

		}foreach(_vestItems);
	};
};

if(count _backpack > 0) then {
	private _bpCls = _backpack select 0;
	private _bpItems = _backpack select 1;

	if([_ammobox,_bpCls,1] call CBA_fnc_removeBackpackCargo) then {
		_unit addBackpack _bpCls;
		{
			params ["_cc","_num"];
			if(_cc isEqualType []) then {_cc = _cc select 0;};
			private _count = 0;

			private _func = CBA_fnc_removeWeaponCargo;
			[_cc] call {
				params ["_cc"];
				if(_cc isKindOf ["ItemCore",configFile >> "CfgWeapons"]) exitWith {
					_func = CBA_fnc_removeItemCargo;
				};
				if(_cc isKindOf ["Default",configFile >> "CfgMagazines"]) exitWith {
					_func = CBA_fnc_removeMagazineCargo;
				};
			};
			while {_count < _num} do {
				if([_ammobox,_cc,1] call _func) then {
					_unit addItemToBackpack _cc;
				};
				_count = _count + 1;
			};

		}foreach(_bpItems);
	};
};

if(count _optic > 0) then {
	private _opticCls = _optic select 0;
	if([_ammobox,_opticCls,1] call CBA_fnc_removeWeaponCargo) then {
		_unit addWeaponGlobal _opticCls;
		_unit assignItem _opticCls;
	};
};

if (count _uniform > 0) then {
	_unit forceAddUniform _uniformCls;
};

{
	params ["_cc", "_num"];
	if(_cc isEqualType []) then {_cc = _cc select 0};
	private _count = 0;

	private _func = CBA_fnc_removeWeaponCargo;
	[_cc] call {
		params ["_cc"];
		if(_cc isKindOf ["ItemCore",configFile >> "CfgWeapons"]) exitWith {
			_func = CBA_fnc_removeItemCargo;
		};
		if(_cc isKindOf ["Default",configFile >> "CfgMagazines"]) exitWith {
			_func = CBA_fnc_removeMagazineCargo;
		};
	};
	while {_count < _num} do {
		if([_ammobox,_cc,1] call _func) then {
			_unit addItemToUniform _cc;
		};
		_count = _count + 1;
	};

}foreach(_uniformItems);

if([_ammobox,_headgear,1] call CBA_fnc_removeItemCargo) then {
	_unit addHeadgear _headgear;
};

if([_ammobox,_goggles,1] call CBA_fnc_removeItemCargo) then {
	_unit addGoggles _goggles;
};

{
	if([_ammobox,_x,1] call CBA_fnc_removeItemCargo) then {
		_unit linkItem _x;
	};
}foreach(_assigned);
