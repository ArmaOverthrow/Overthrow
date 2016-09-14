private ["_unit","_t"];

_unit = _this select 0;
_t = _this select 1;

if(headgear _unit != "") then {
	_t addHeadgear headgear _unit;
	removeHeadgear _unit;
};
if(vest _unit != "") then {
	_t addVest vest _unit;
};
if(backpack _unit != "") then {
	_t addBackpack backpack _unit;
};

{
	_count = 0;
	_cls = _x select 0;
	while {_count < (_x select 1)} do {	
		if(_cls in AIT_allMagazines) then {
			_t addMagazine _cls;
			_unit removeMagazine _cls;
		}else{
			_t addItem _cls;
			_unit removeItem _cls;
		};		
		_count = _count + 1;
	};
}foreach(_unit call unitStock);

if(vest _unit != "") then {
	removeVest _unit;
};

if(backpack _unit != "") then {
	removeBackpack _unit;
};

if(goggles _unit != "") then {
	_t addGoggles goggles _unit;
	removeGoggles _unit;
};
if(handgunWeapon _unit != "") then {
	_t addWeapon handgunWeapon _unit;
	{
		_t addItem _x;
		_unit removeHandgunItem _x;
	}foreach(handgunItems _unit);		
	_unit removeWeapon handgunWeapon _unit;
};
{
	if (([(configFile >> "CfgWeapons" >> _x),"optics",0] call BIS_fnc_returnConfigEntry) > 0) then {
		_t addWeapon _x;
		_t assignItem _x; 
		_unit unassignItem _x;
		_unit removeWeapon _x;
	}else{
		_unit unlinkItem _x;
		_t linkItem _x;
	};	
}foreach(assignedItems _unit);