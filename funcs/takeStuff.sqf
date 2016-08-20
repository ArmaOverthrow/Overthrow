private ["_unit","_t"];

_unit = _this select 0;
_t = _this select 1;

{
	_count = 0;
	_cls = _x select 0;
	_full = false;
	while {_count < (_x select 1)} do {
		if !([_unit,_cls] call canFit) exitWith {
			_full = true;
		};
		
		if(_cls in AIT_allMagazines) then {
			hint _cls;
			_unit addMagazineCargo [_cls,1];
		}else{
			_unit addItemCargo [_cls,1];
		};		
		_count = _count + 1;
	};
	if(_full) exitWith {};
}foreach(_unit call unitStock);

if(headgear _unit != "") then {
	_t addHeadgear headgear _unit;
	removeHeadgear _unit;
};
if(vest _unit != "") then {
	_t addVest vest _unit;
	removeVest _unit;
};
if(goggles _unit != "") then {
	_t addGoggles goggles _unit;
	removeGoggles _unit;
};
if(primaryWeapon _unit != "") then {
	_t addWeapon primaryWeapon _unit;
	{
		_t addPrimaryWeaponItem _x;
		_unit removePrimaryWeaponItem _x;
	}foreach(primaryWeaponItems _unit);	
	_unit removeWeapon primaryWeapon _unit;
};
if(secondaryWeapon _unit != "") then {
	_t addWeapon secondaryWeapon _unit;
	{
		_t addSecondaryWeaponItem _x;
		_unit removeSecondaryWeaponItem _x;
	}foreach(secondaryWeaponItems _unit);		
	
	_t addWeaponCargo [secondaryWeapon _unit,1];
	_unit removeWeapon secondaryWeapon _unit;
};
if(handgunWeapon _unit != "") then {
	_t addWeapon handgunWeapon _unit;
	{
		_t addHandgunItem _x;
		_unit removeHandgunItem _x;
	}foreach(handgunItems _unit);		
	_unit removeWeapon handgunWeapon _unit;
};
{
	_unit unlinkItem _x;
	_t linkItem _x;
}foreach(assignedItems _unit);