private ["_unit","_t"];

_unit = _this select 0;
_t = _this select 1;

if(headgear _unit != "") then {
	_t addItemCargo [headgear _unit,1];
	removeHeadgear _unit;
};
if(vest _unit != "") then {
	_t addItemCargo [vest _unit,1];
	removeVest _unit;
};
if(goggles _unit != "") then {
	_t addItemCargo [goggles _unit,1];
	removeGoggles _unit;
};
if(primaryWeapon _unit != "") then {
	{
		_t addItemCargo [_x,1];
		_unit removePrimaryWeaponItem _x;
	}foreach(primaryWeaponItems _unit);
	
	_t addWeaponCargo [primaryWeapon _unit,1];
	_unit removeWeapon primaryWeapon _unit;
};
if(secondaryWeapon _unit != "") then {
	{
		_t addItemCargo [_x,1];
		_unit removeSecondaryWeaponItem _x;
	}foreach(secondaryWeaponItems _unit);		
	
	_t addWeaponCargo [secondaryWeapon _unit,1];
	_unit removeWeapon secondaryWeapon _unit;
};
if(handgunWeapon _unit != "") then {
	{
		_t addItemCargo [_x,1];
		_unit removeHandgunItem _x;
	}foreach(handgunItems _unit);		
	
	_t addWeaponCargo [handgunWeapon _unit,1];
	_unit removeWeapon handgunWeapon _unit;
};
{
	_unit unlinkItem _x;
	_t addItemCargo[_x,1];
}foreach(assignedItems _unit);