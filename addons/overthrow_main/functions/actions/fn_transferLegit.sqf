private _veh = vehicle player;

if(_veh isEqualTo player) exitWith {};

private _objects = [];

private _b = player call OT_fnc_nearestRealEstate;
private _iswarehouse = false;
if(typename _b isEqualTo "ARRAY") then {
	private _building = _b select 0;
	if((typeof _building) isEqualTo OT_warehouse && _building call OT_fnc_hasOwner) then {
		_iswarehouse = true;
		_objects pushback _building;
	};
};

{
	if!(_x isEqualTo _veh) then {_objects pushback _x};
}foreach(player nearEntities [["Car","ReammoBox_F","Air","Ship"],20]);

if(_objects isEqualTo []) exitWith {
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

	_full = false;
	if(_iswarehouse) then {
		{
			private _count = 0;
			_d = warehouse getVariable [_x,false];
			if(_d isEqualType []) then {
				params ["_cls",["_num",0,[0]]];
				if(_num > 0) then {
					if(_cls in OT_allItems) then {
						while {_count < _num} do {
							if(!(_veh canAdd [_cls,_count+1])) exitWith {_full = true};
							_count = _count + 1;
						};
						if (_count > 0) then {
							_veh addItemCargoGlobal [_cls,_count];
							if (_count isEqualTo _num) then {
								warehouse setVariable [_x,nil,true];
							} else {
								warehouse setVariable [_x,[_cls,_num - _count],true];
							};
						};
					};
				};
			};
			if(_full) exitWith {};
		}foreach((allVariables warehouse) select {((toLower _x select [0,5]) isEqualTo "item_")});
	}else{
		{
			private _count = 0;
			_x params ["_cls","_num"];
			if(_cls in OT_allItems) then {
				while {_count < _num} do {
					if(!(_veh canAdd [_cls,_count+1])) exitWith {_full = true;};
					_count = _count + 1;
				};

				if (_count > 0) then {
					_veh addItemCargoGlobal [_cls,_count];
					if !([_target, _cls, _count] call CBA_fnc_removeItemCargo) then {
						[_target, _cls, _count] call CBA_fnc_removeWeaponCargo;
					};
				};
			};
			if(_full) exitWith {};
		}foreach(_target call OT_fnc_unitStock);
	};
	if(_full) then {hint "This vehicle is full, use a truck for more storage"};
	"Inventory Transfer done" call OT_fnc_notifyMinor;
};

if(count _objects isEqualTo 1) then {
	(_objects select 0) call _doTransfer;
}else{
	private _options = [];
	{
		_options pushback [format["%1 (%2m)",(typeof _x) call OT_fnc_vehicleGetName,round (_x distance player)],_doTransfer,_x];
	}foreach(_objects);
	"Transfer legal items from which container?" call OT_fnc_notifyBig;
	_options call OT_fnc_playerDecision;
};
