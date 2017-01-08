_target = vehicle player;

if(_target == player) exitWith {};
private _objects = [];

private _b = player call OT_fnc_nearestRealEstate;
private _iswarehouse = false;
if(typename _b == "ARRAY") then {
	_building = _b select 0;
	if((typeof _building) == OT_warehouse and _building call OT_fnc_hasOwner) then {
		_iswarehouse = true;
		_objects = [_building];
	};
};

if(!_iswarehouse) then {
	{
		if(_x != _target) then {_objects pushback _x};
	}foreach(player nearEntities [["Car","ReammoBox_F","Air","Ship"],20]);
};

if(count _objects == 0) exitWith {
	"Cannot find any containers or other vehicles within 20m of this vehicle" call notify_minor;
};

private _doTransfer = {
	private _veh = _this;
	private _toname = (typeof _veh) call ISSE_Cfg_Vehicle_GetName;
	_iswarehouse = false;
	if((typeof _veh) == OT_warehouse) then {
		_toname = "Warehouse";
		_iswarehouse = true;
	};

	_target = vehicle player;
	format["Transferring inventory to %1",_toname] call notify_minor;
	[5,false] call progressBar;
	sleep 5;
	if(vehicle player != _target) exitWith {"You exited the vehicle" call notify_minor};
	if(_iswarehouse) then {
		{
			_cls = _x select 0;
			_d = warehouse getVariable [(_x select 0),[_cls,0]];
			if(typename _d == "ARRAY") then {
				_num = _x select 1;
				_in =  _d select 1;
				warehouse setVariable[_cls,[_cls,_in + _num],true];
			};
		}foreach(_target call OT_fnc_unitStock);
		clearMagazineCargoGlobal _target;
		clearWeaponCargoGlobal _target;
		clearBackpackCargoGlobal _target;
		clearItemCargoGlobal _target;
	}else{
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
					if(_cls isKindOf "Bag_Base") exitWith {
						_veh addBackpackCargoGlobal [_cls,1];
					};
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
					_veh addItemCargoGlobal [_cls,1];
				};
			};
			call {
				if(_cls isKindOf "Bag_Base") exitWith {
					[_target, _cls, _count] call CBA_fnc_removeBackpackCargo;
				};
				if(_cls isKindOf ["Rifle",configFile >> "CfgWeapons"]) exitWith {
					[_target, _cls, _count] call CBA_fnc_removeWeaponCargo;
				};
				if(_cls isKindOf ["Launcher",configFile >> "CfgWeapons"]) exitWith {
					[_target, _cls, _count] call CBA_fnc_removeWeaponCargo;
				};
				if(_cls isKindOf ["CA_Magazine",configFile >> "CfgMagazines"]) exitWith {
					[_target, _cls, _count] call CBA_fnc_removeMagazineCargo;
				};
				if !([_target, _cls, _count] call CBA_fnc_removeItemCargo) then {
					[_target, _cls, _count] call CBA_fnc_removeWeaponCargo;
				};
			};
			if(_full) exitWith {hint "The vehicle is full, use a truck or ammobox for more storage"};
		}foreach(_target call OT_fnc_unitStock);
	};

	"Inventory Transfer done" call notify_minor;

};



if(count _objects == 1) then {
	(_objects select 0) call _doTransfer;
}else{
	private _options = [];
	{
		_options pushback [format["%1 (%2m)",(typeof _x) call ISSE_Cfg_Vehicle_GetName,round (_x distance player)],_doTransfer,_x];
	}foreach(_objects);
	"Transfer to which container?" call notify_big;
	_options spawn playerDecision;
};
