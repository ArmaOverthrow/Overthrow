private ["_unit","_t"];

_unit = _this select 0;
_t = _this select 1;

_full = false;
_istruck = true;
if(count _this == 2) then {
	_istruck = (_t isKindOf "Truck_F") or (_t isKindOf "ReammoBox_F");
};

{
	_count = 0;
	_cls = _x select 0;
	while {_count < (_x select 1)} do {
		if !(_t canAdd _cls) exitWith {
			_full = true;
		};
		if(_cls isKindOf ["CA_Magazine",configFile >> "CfgMagazines"]) then {
			_t addMagazineCargoGlobal [_cls,1];
			_unit removeMagazine _cls;
		}else{
			_t addItemCargoGlobal [_cls,1];
			_unit removeItem _cls;
		};
		_count = _count + 1;
	};
}foreach(_unit call OT_fnc_unitStock);

if(_full and !_istruck) exitWith {false};

if(headgear _unit != "") then {
	if !(_t canAdd headgear _unit) exitWith {
		_full = true;
	};
	_t addItemCargoGlobal [headgear _unit,1];
	removeHeadgear _unit;
};
if(_full and !_istruck) exitWith {false};

if(backpack _unit != "") then {
	_cls = (backpack _unit) call BIS_fnc_basicBackpack;
	if !(_t canAdd _cls) exitWith {
		_full = true;
	};
	_t addBackpackCargoGlobal [_cls,1];
	removeBackpack _unit;
};
if(_full and !_istruck) exitWith {false};

if(vest _unit != "") then {
	if !(_t canAdd vest _unit) exitWith {
		_full = true;
	};
	_t addItemCargoGlobal [vest _unit,1];
	removeVest _unit;
};
if(_full and !_istruck) exitWith {false};

if(goggles _unit != "") then {
	if !(_t canAdd goggles _unit) exitWith {
		_full = true;
	};
	_t addItemCargoGlobal [goggles _unit,1];
	removeGoggles _unit;
};
if(_full and !_istruck) exitWith {false};

if(primaryWeapon _unit != "") then {
	if !(_t canAdd primaryWeapon _unit) exitWith {
		_full = true;
	};
	{
		_t addItemCargoGlobal [_x,1];
	}foreach(primaryWeaponItems _unit);
	removeAllPrimaryWeaponItems _unit;
	_t addWeaponCargoGlobal [(primaryWeapon _unit) call BIS_fnc_baseWeapon,1];
	_unit removeWeapon primaryWeapon _unit;
};
if(_full and !_istruck) exitWith {false};

if(secondaryWeapon _unit != "") then {
	if !(_t canAdd secondaryWeapon _unit) exitWith {
		_full = true;
	};
	_t addWeaponCargoGlobal [secondaryWeapon _unit,1];
	_unit removeWeapon secondaryWeapon _unit;
};
if(_full and !_istruck) exitWith {false};


if(handgunWeapon _unit != "") then {
	if !(_t canAdd handgunWeapon _unit) exitWith {
		_full = true;
	};
	{
		_t addItemCargoGlobal [_x,1];
	}foreach(handgunItems _unit);
	removeAllHandgunItems _unit;
	_t addWeaponCargoGlobal [handgunWeapon _unit,1];
	_unit removeWeapon handgunWeapon _unit;
};
if(_full and !_istruck) exitWith {false};

if(!isplayer _unit) then {
	{
		if !(_t canAdd _x) exitWith {
			_full = true;
		};
		if (([(configFile >> "CfgWeapons" >> _x),"useAsBinocular",0] call BIS_fnc_returnConfigEntry) > 0) then {
			_unit unassignItem _x;
			_unit removeWeapon _x;
		}else{
			_unit unlinkItem _x;
		};
		_t addItemCargoGlobal [_x,1];
	}foreach(assignedItems _unit);
};

if(_full and !_istruck) exitWith {false};

true
