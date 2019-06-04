params ["_unit",["_linkedItems",false]];

if(binocular _unit != "") then {
	[binocular _unit,1] call OT_fnc_addToWarehouse;
	_unit removeWeapon binocular _unit;
};

if(hmd _unit != "") then {
	[hmd _unit,1] call OT_fnc_addToWarehouse;
	_unit unlinkItem hmd _unit;
};

{
	_count = 0;
	_cls = _x select 0;
	while {_count < (_x select 1)} do {
		[_cls] call {
			params ["_cls"];
			if(_cls isKindOf ["Rifle",configFile >> "CfgWeapons"]) exitWith {
				_unit removeWeapon _cls;
			};
			if(_cls isKindOf ["Launcher",configFile >> "CfgWeapons"]) exitWith {
				_unit removeWeapon _cls;
			};
			if(_cls isKindOf ["Pistol",configFile >> "CfgWeapons"]) exitWith {
				_unit removeWeapon _cls;
			};
			if(_cls isKindOf ["Binocular",configFile >> "CfgWeapons"]) exitWith {
				_unit removeItem _cls;
			};
			if(_cls isKindOf ["Default",configFile >> "CfgMagazines"]) exitWith {
				_unit removeMagazine _cls;
			};
			_unit removeItem _cls;
		};
		[_cls,1] call OT_fnc_addToWarehouse;
		_count = _count + 1;
	};
}foreach(_unit call OT_fnc_unitStock);

if(headgear _unit != "") then {
	[headgear _unit,1] call OT_fnc_addToWarehouse;
	removeHeadgear _unit;
};

if(backpack _unit != "") then {
	[backpack _unit,1] call OT_fnc_addToWarehouse;
	removeBackpack _unit;
};

if(vest _unit != "") then {
	[vest _unit,1] call OT_fnc_addToWarehouse;
	removeVest _unit;
};

if(goggles _unit != "") then {
	[goggles _unit,1] call OT_fnc_addToWarehouse;
	removeGoggles _unit;
};

if(primaryWeapon _unit != "") then {
	{
		[_x,1] call OT_fnc_addToWarehouse;
	}foreach(primaryWeaponItems _unit);
	removeAllPrimaryWeaponItems _unit;
	[(primaryWeapon _unit) call BIS_fnc_baseWeapon,1] call OT_fnc_addToWarehouse;
	_unit removeWeapon primaryWeapon _unit;
};

if(secondaryWeapon _unit != "") then {
	[secondaryWeapon _unit,1] call OT_fnc_addToWarehouse;
	_unit removeWeapon secondaryWeapon _unit;
};


if(handgunWeapon _unit != "") then {
	{
		[_x,1] call OT_fnc_addToWarehouse;
	}foreach(handgunItems _unit);
	removeAllHandgunItems _unit;
	[handgunWeapon _unit,1] call OT_fnc_addToWarehouse;
	_unit removeWeapon handgunWeapon _unit;
};

if(_linkedItems) then {
	{
		if !(_x isEqualTo "ItemMap") then {
			if (([(configFile >> "CfgWeapons" >> _x),"useAsBinocular",0] call BIS_fnc_returnConfigEntry) > 0) then {
				_unit unassignItem _x;
				_unit removeWeapon _x;
			}else{
				_unit unlinkItem _x;
			};
			[_x,1] call OT_fnc_addToWarehouse;
		};
	}foreach(assignedItems _unit);
};

true
