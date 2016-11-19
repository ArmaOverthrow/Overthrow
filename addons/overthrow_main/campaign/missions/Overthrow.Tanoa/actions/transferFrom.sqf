_veh = vehicle player;

if(_veh == player) exitWith {};

_objects = [];
{
	if(_x != _veh) then {_objects pushback _x};
}foreach(player nearEntities [["LandVehicle","ReammoBox_F"],20]);

if(count _objects == 0) exitWith {
	"Cannot find any containers or other vehicles within 20m of this vehicle" call notify_minor;
};
_sorted = [_objects,[],{_x distance player},"ASCEND"] call BIS_fnc_SortBy;
_target = _sorted select 0;

if(_veh call unitSeen) then {
	if(typename (_target getVariable ["stockof",""]) == "SCALAR") then {
		{
			_x setCaptive false;
		}foreach(units _veh);
		_veh spawn revealToNATO;
		hint "You were caught stealing!";
	};
};

disableUserInput true;

format["Transferring inventory from %1",(typeof _target) call ISSE_Cfg_Vehicle_GetName] call notify_minor;
[5,false] call progressBar;				
_end = time + 5;
{
	_count = 0;
	_cls = _x select 0;
	
	_full = false;
	while {_count < (_x select 1)} do {		
		if(!(_veh isKindOf "Truck_F" or _veh isKindOf "ReammoBox_F") and !(_veh canAdd _cls)) exitWith {
			_full = true;
		};
		_count = _count + 1;
		call {
			if(_cls isKindOf ["Rifle",configFile >> "CfgWeapons"]) exitWith {
				_veh addWeaponCargoGlobal [_cls,1];
			};
			if(_cls isKindOf ["Launcher",configFile >> "CfgWeapons"]) exitWith {
				_veh addWeaponCargoGlobal [_cls,1];
			};
			if(_cls isKindOf ["Pistol",configFile >> "CfgWeapons"]) exitWith {
				_veh addWeaponCargoGlobal [_cls,1];
			};
			if(_cls isKindOf ["CA_Magazine",configFile >> "CfgMagazines"]) exitWith {
				_veh addMagazineCargoGlobal [_cls,1];
			};
			if(_cls isKindOf "Bag_Base") exitWith {
				_veh addBackpackCargoGlobal [_cls,1];
			};
			_veh addItemCargoGlobal [_cls,1];
		};		
	};
	
	call {
		if(_cls isKindOf ["Rifle",configFile >> "CfgWeapons"]) exitWith {
			[_target, _cls, _count] call CBA_fnc_removeWeaponCargoGlobal;
		};
		if(_cls isKindOf ["Launcher",configFile >> "CfgWeapons"]) exitWith {
			[_target, _cls, _count] call CBA_fnc_removeWeaponCargoGlobal;
		};
		if(_cls isKindOf ["CA_Magazine",configFile >> "CfgMagazines"]) exitWith {
			[_target, _cls, _count] call CBA_fnc_removeMagazineCargoGlobal;
		};
		if(_cls isKindOf "Bag_Base") exitWith {
			[_target, _cls, _count] call CBA_fnc_removeBackpackCargoGlobal;
		};
		if !([_target, _cls, _count] call CBA_fnc_removeItemCargoGlobal) then {
			[_target, _cls, _count] call CBA_fnc_removeWeaponCargoGlobal;
		};
	};
	if(_full) exitWith {hint "This vehicle is full, use a truck for more storage"};
}foreach(_target call unitStock);
waitUntil {time > _end};
"Inventory Transfer done" call notify_minor;

disableUserInput false;