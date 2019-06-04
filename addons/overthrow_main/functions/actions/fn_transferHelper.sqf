_this spawn {
	params ["_source", "_dest"];

	private _supplycache = _source getVariable ["NATOsupply",false];
	if(_supplycache isEqualType "") then {
		private _me = driver _dest;
		if (_me call OT_fnc_unitSeenNATO) then {
			_me setCaptive false;
			[_me] call OT_fnc_revealToNATO;
		};
		//Make sure box doesnt spawn at this base again (this session)
		spawner setVariable [format["NATOsupply%1",_supplycache],false,true];
	};

	private _veh = _dest;
	private _toname = (typeof _veh) call OT_fnc_vehicleGetName;
	private _iswarehouse = false;
	if((typeof _veh) == OT_warehouse) then {
		_toname = "Warehouse";
		_iswarehouse = true;
	};

	private _target = _source;
	if(_target isEqualTo player) then {
		_target = OT_warehouseTarget;
	};

	disableUserInput true;
	[] spawn {
		sleep 10;
		disableUserInput false;
		//Fail safe for user input disabled.
	};
	format["Transferring inventory to %1...",_toname] call OT_fnc_notifyMinor;
	[5,false] call OT_fnc_progressBar;
	private _end = time + 5;

	// Dummy CBA remove calls to strip weapons and replace with non-preset types
	[_target, "Bag_Base"] call CBA_fnc_removeBackpackCargo;
	[_target, "FakeWeapon"] call CBA_fnc_removeWeaponCargo;

	// Strip out preloaded missile dummies from inventory.
	// Only way to really clear them is a full magazine clear.
	private _mags = magazineCargo _target;
	_mags = _mags - OT_noCopyMags;
	clearMagazineCargoGlobal _target;
	{
		_target addMagazineCargoGlobal[_x, 1];
	}foreach(_mags);

	if(_iswarehouse) then {
		{
			_x params ["_cls", "_num"];
			_d = warehouse getVariable [format["item_%1",_cls],[_cls,0]];
			if(_d isEqualType []) then {
				_d params ["_wCls",["_in",0]];
				_in =  _d select 1;
				warehouse setVariable[format["item_%1",_cls],[_cls,_in + _num],true];
			};
		}foreach(_target call OT_fnc_unitStock);
		clearMagazineCargoGlobal _target;
		clearWeaponCargoGlobal _target;
		clearBackpackCargoGlobal _target;
		clearItemCargoGlobal _target;
	}else{
		{
			_x params [["_cls",""], ["_max",0]];
			private _count = 0;
			private _full = false;
			private _istruck = (_veh isKindOf "Truck_F" || _veh isKindOf "ReammoBox_F");

			while {_count < _max} do {
				if(!(_veh canAdd [_cls,1]) && !_istruck) exitWith {_full = true};
				_count = _count + 1;
				call {
					if(_cls isKindOf "Bag_Base") exitWith {
						_cls = _cls call BIS_fnc_basicBackpack;
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
					if(_cls isKindOf ["Default",configFile >> "CfgMagazines"]) exitWith {
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
				if(_cls isKindOf ["Pistol",configFile >> "CfgWeapons"]) exitWith {
					[_target, _cls, _count] call CBA_fnc_removeWeaponCargo;
				};
				if(_cls isKindOf ["Default",configFile >> "CfgMagazines"]) exitWith {
					[_target, _cls, _count] call CBA_fnc_removeMagazineCargo;
				};
				[_target, _cls, _count] call CBA_fnc_removeItemCargo;
			};
			if(_full) exitWith {hint "The vehicle is full, use a truck or ammobox for more storage"};
		}foreach(_target call OT_fnc_unitStock);
	};

	waitUntil {time > _end};
	disableUserInput false;
	"Inventory Transfer done" call OT_fnc_notifyMinor;
};
