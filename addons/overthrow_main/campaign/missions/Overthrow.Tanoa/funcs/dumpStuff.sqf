private ["_unit","_t"];

_unit = _this select 0;
_t = _this select 1;

{
	_count = 0;
	_cls = _x select 0;
	while {_count < (_x select 1)} do {		
		if(_cls isKindOf ["CA_Magazine",configFile >> "CfgMagazines"]) then {
			_t addMagazineCargoGlobal [_cls,1];
			_unit removeMagazine _cls;
		}else{
			_t addItemCargoGlobal [_cls,1];
			_unit removeItem _cls;
		};		
		_count = _count + 1;
	};
}foreach(_unit call unitStock);

if(headgear _unit != "") then {
	_t addItemCargoGlobal [headgear _unit,1];
	removeHeadgear _unit;
};
if(backpack _unit != "") then {
	_t addBackpackCargoGlobal [backpack _unit,1];
	removeBackpack _unit;
};
if(vest _unit != "") then {
	_t addItemCargoGlobal [vest _unit,1];
	removeVest _unit;
};
if(goggles _unit != "") then {
	_t addItemCargoGlobal [goggles _unit,1];
	removeGoggles _unit;
};
if(primaryWeapon _unit != "") then {
	{
		_t addItemCargoGlobal [_x,1];
	}foreach(primaryWeaponItems _unit);
	removeAllPrimaryWeaponItems _unit;
	_t addWeaponCargoGlobal [primaryWeapon _unit,1];
	_unit removeWeapon primaryWeapon _unit;
};
if(secondaryWeapon _unit != "") then {
	_t addWeaponCargoGlobal [secondaryWeapon _unit,1];
	_unit removeWeapon secondaryWeapon _unit;
};
if(handgunWeapon _unit != "") then {
	{
		_t addItemCargoGlobal [_x,1];
	}foreach(handgunItems _unit);		
	removeAllHandgunItems _unit;
	_t addWeaponCargoGlobal [handgunWeapon _unit,1];
	_unit removeWeapon handgunWeapon _unit;
};
{
	if (([(configFile >> "CfgWeapons" >> _x),"optics",0] call BIS_fnc_returnConfigEntry) > 0) then {
		_unit unassignItem _x;
		_unit removeWeapon _x;
	}else{
		_unit unlinkItem _x;
	};
	_t addItemCargoGlobal[_x,1];
}foreach(assignedItems _unit);