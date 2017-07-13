_veh = vehicle player;

if(_veh == player) exitWith {};

_objects = [];
{
	if(_x != _veh) then {_objects pushback _x};
}foreach(player nearEntities [["Car","ReammoBox_F","Air","Ship"],20]);

if(count _objects == 0) exitWith {
	"Cannot find any containers or other vehicles within 20m of this vehicle" call OT_fnc_notifyMinor;
};
_sorted = [_objects,[],{_x distance player},"ASCEND"] call BIS_fnc_SortBy;
_target = _sorted select 0;

if(_veh call OT_fnc_unitSeen) then {
	if(typename (_target getVariable ["stockof",""]) == "SCALAR") then {
		{
			_x setCaptive false;
		}foreach(crew _veh);
		_veh spawn OT_fnc_revealToNATO;
		hint "You were caught stealing!";
	};
};

_doTransfer = {
	private _target = _this;
	private _veh = vehicle player;
	disableUserInput true;

	format["Transferring inventory from %1",(typeof _target) call OT_fnc_vehicleGetName] call OT_fnc_notifyMinor;
	[5,false] call OT_fnc_progressBar;
	_end = time + 5;
	[_target, "FakeWeapon"] call CBA_fnc_removeWeaponCargo;
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
					_cls = _cls call BIS_fnc_basicBackpack;
					_veh addBackpackCargoGlobal [_cls,1];
				};
				_veh addItemCargoGlobal [_cls,1];
			};
		};

		call {
			if(_cls isKindOf ["Rifle",configFile >> "CfgWeapons"]) exitWith {
				[_target, _cls, _count] call CBA_fnc_removeWeaponCargo;
			};
			if(_cls isKindOf ["Launcher",configFile >> "CfgWeapons"]) exitWith {
				[_target, _cls, _count] call CBA_fnc_removeWeaponCargo;
			};
			if(_cls isKindOf ["CA_Magazine",configFile >> "CfgMagazines"]) exitWith {
				[_target, _cls, _count] call CBA_fnc_removeMagazineCargo;
			};
			if(_cls isKindOf "Bag_Base") exitWith {
				[_target, _cls, _count] call CBA_fnc_removeBackpackCargo;
			};
			if !([_target, _cls, _count] call CBA_fnc_removeItemCargo) then {
				[_target, _cls, _count] call CBA_fnc_removeWeaponCargo;
			};
		};
		if(_full) exitWith {hint "This vehicle is full, use a truck for more storage"};
	}foreach(_target call OT_fnc_unitStock);
	waitUntil {time > _end};
	"Inventory Transfer done" call OT_fnc_notifyMinor;

	disableUserInput false;
};

if(count _objects == 1) then {
	(_objects select 0) call _doTransfer;
}else{
	private _options = [];
	{
		_options pushback [format["%1 (%2m)",(typeof _x) call OT_fnc_vehicleGetName,round (_x distance player)],_doTransfer,_x];
	}foreach(_objects);
	"Transfer from which container?" call OT_fnc_notifyBig;
	_options spawn OT_fnc_playerDecision;
};
