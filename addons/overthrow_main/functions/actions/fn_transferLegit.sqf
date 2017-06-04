_veh = vehicle player;

if(_veh == player) exitWith {};

private _objects = [];

private _b = player call OT_fnc_nearestRealEstate;
private _iswarehouse = false;
if(typename _b == "ARRAY") then {
	_building = _b select 0;
	if((typeof _building) == OT_warehouse and _building call OT_fnc_hasOwner) then {
		_iswarehouse = true;
		_objects pushback _building;
	};
};

{
	if(_x != _veh) then {_objects pushback _x};
}foreach(player nearEntities [["Car","ReammoBox_F","Air","Ship"],20]);

if(count _objects == 0) exitWith {
	"Cannot find any containers or other vehicles within 20m of this vehicle" call OT_fnc_notifyMinor;
};
_sorted = [_objects,[],{_x distance player},"ASCEND"] call BIS_fnc_SortBy;
_target = _sorted select 0;

_doTransfer = {
	private _veh = vehicle player;
	private _target = _this;
	private _toname = (typeof _target) call OT_fnc_vehicleGetName;
	private _iswarehouse = (_target isKindOf OT_warehouse);
	if(_iswarehouse) then {_toname = "Warehouse"};
	format["Transferring legal inventory from %1",_toname] call OT_fnc_notifyMinor;


	[5,false] call OT_fnc_progressBar;
	sleep 5;
	_full = false;
	if(_iswarehouse) then {
		{
			_count = 0;
			_d = warehouse getVariable [_x,[_x,0]];
			if(typename _d == "ARRAY") then {
				_cls = _d select 0;
				_num = _d select 1;
				if(_num > 0) then {
					if(_cls in OT_allItems) then {
						while {_count < _num} do {
							if !(_veh canAdd _cls) exitWith {_full = true;warehouse setVariable [_cls,_num - _count,true]};
							_veh addItemCargoGlobal [_cls,1];
							_count = _count + 1;
						};
						if !(_full) then {
							warehouse setVariable [_cls,nil,true];
						};
					};
				};
			};
			if(_full) exitWith {};
		}foreach(allvariables warehouse);
	}else{
		{
			_count = 0;
			_cls = _x select 0;
			if(_cls in OT_allItems) then {
				while {_count < (_x select 1)} do {
					if !(_veh canAdd _cls) exitWith {_full = true};
					_veh addItemCargoGlobal [_cls,1];
					_count = _count + 1;
				};
			};
			if !([_target, _cls, _count] call CBA_fnc_removeItemCargo) then {
				[_target, _cls, _count] call CBA_fnc_removeWeaponCargo;
			};
			if(_full) exitWith {};
		}foreach(_target call OT_fnc_unitStock);
	};
	if(_full) then {hint "This vehicle is full, use a truck for more storage"};
	"Inventory Transfer done" call OT_fnc_notifyMinor;
};

if(count _objects == 1) then {
	(_objects select 0) call _doTransfer;
}else{
	private _options = [];
	{
		_options pushback [format["%1 (%2m)",(typeof _x) call OT_fnc_vehicleGetName,round (_x distance player)],_doTransfer,_x];
	}foreach(_objects);
	"Transfer legal items from which container?" call OT_fnc_notifyBig;
	_options spawn OT_fnc_playerDecision;
};
