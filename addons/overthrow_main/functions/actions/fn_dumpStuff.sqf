params ["_unit","_t",["_linkedItems",false]];

_full = false;
_istruck = true;
if(count _this isEqualTo 2) then {
	_istruck = (_t isKindOf "Truck_F") || (_t isKindOf "ReammoBox_F");
};

if(binocular _unit != "") then {
	if (!(_t canAdd binocular _unit) && !_isTruck) exitWith {
		_full = true;
	};
	_t addWeaponCargoGlobal [binocular _unit,1];
	_unit removeWeapon binocular _unit;
};

if(hmd _unit != "") then {
	if (!(_t canAdd hmd _unit) && !_isTruck) exitWith {
		_full = true;
	};
	_t addItemCargoGlobal [hmd _unit,1];
	_unit unlinkItem hmd _unit;
};

if(_full) exitWith {false};

{
	_count = 0;
	_cls = _x select 0;
	while {_count < (_x select 1)} do {
		if (!(_t canAdd _cls) && !_isTruck) exitWith {
			_full = true;
		};
		[_t, _cls] call {
			params ["_veh", "_cls"];
			if(_cls isKindOf ["Rifle",configFile >> "CfgWeapons"]) exitWith {
				_veh addWeaponCargoGlobal [_cls,1];
				_unit removeWeapon _cls;
			};
			if(_cls isKindOf ["Launcher",configFile >> "CfgWeapons"]) exitWith {
				_veh addWeaponCargoGlobal [_cls,1];
				_unit removeWeapon _cls;
			};
			if(_cls isKindOf ["Pistol",configFile >> "CfgWeapons"]) exitWith {
				_veh addWeaponCargoGlobal [_cls,1];
				_unit removeWeapon _cls;
			};
			if(_cls isKindOf ["Binocular",configFile >> "CfgWeapons"]) exitWith {
				_veh addWeaponCargoGlobal [_cls,1];
				_unit removeItem _cls;
			};
			if(_cls isKindOf ["Default",configFile >> "CfgMagazines"]) exitWith {
				_veh addMagazineCargoGlobal [_cls,1];
				_unit removeMagazine _cls;
			};
			_veh addItemCargoGlobal [_cls,1];
			_unit removeItem _cls;
		};
		_count = _count + 1;
	};
}foreach(_unit call OT_fnc_unitStock);

if(_full) exitWith {false};

if(headgear _unit != "") then {
	if (!(_t canAdd headgear _unit) && !_isTruck) exitWith {
		_full = true;
	};
	_t addItemCargoGlobal [headgear _unit,1];
	removeHeadgear _unit;
};
if(_full) exitWith {false};

if(backpack _unit != "") then {
	_cls = (backpack _unit) call BIS_fnc_basicBackpack;
	if (!(_t canAdd _cls) && !_isTruck) exitWith {
		_full = true;
	};
	_t addBackpackCargoGlobal [_cls,1];
	removeBackpack _unit;
};
if(_full) exitWith {false};

if(vest _unit != "") then {
	if (!(_t canAdd vest _unit) && !_isTruck) exitWith {
		_full = true;
	};
	_t addItemCargoGlobal [vest _unit,1];
	removeVest _unit;
};
if(_full) exitWith {false};

if(goggles _unit != "") then {
	if (!(_t canAdd goggles _unit) && !_isTruck) exitWith {
		_full = true;
	};
	_t addItemCargoGlobal [goggles _unit,1];
	removeGoggles _unit;
};
if(_full) exitWith {false};

if(primaryWeapon _unit != "") then {
	if (!(_t canAdd primaryWeapon _unit) && !_isTruck) exitWith {
		_full = true;
	};
	{
		_t addItemCargoGlobal [_x,1];
	}foreach(primaryWeaponItems _unit);
	removeAllPrimaryWeaponItems _unit;
	_t addWeaponCargoGlobal [(primaryWeapon _unit) call BIS_fnc_baseWeapon,1];
	_unit removeWeapon primaryWeapon _unit;
};
if(_full) exitWith {false};

if(secondaryWeapon _unit != "") then {
	if (!(_t canAdd secondaryWeapon _unit) && !_isTruck) exitWith {
		_full = true;
	};
	_t addWeaponCargoGlobal [secondaryWeapon _unit,1];
	_unit removeWeapon secondaryWeapon _unit;
};
if(_full) exitWith {false};


if(handgunWeapon _unit != "") then {
	if (!(_t canAdd handgunWeapon _unit) && !_isTruck) exitWith {
		_full = true;
	};
	{
		_t addItemCargoGlobal [_x,1];
	}foreach(handgunItems _unit);
	removeAllHandgunItems _unit;
	_t addWeaponCargoGlobal [handgunWeapon _unit,1];
	_unit removeWeapon handgunWeapon _unit;
};
if(_full) exitWith {false};

if((!isplayer _unit) || _linkedItems) then {
	{
		if !(_x isEqualTo "ItemMap") then {
			if (!(_t canAdd _x) && !_isTruck) exitWith {
				_full = true;
			};
			if (([(configFile >> "CfgWeapons" >> _x),"useAsBinocular",0] call BIS_fnc_returnConfigEntry) > 0) then {
				_unit unassignItem _x;
				_unit removeWeapon _x;
			}else{
				_unit unlinkItem _x;
			};
			_t addItemCargoGlobal [_x,1];
		};
	}foreach(assignedItems _unit);
};

if(_full) exitWith {false};

true
