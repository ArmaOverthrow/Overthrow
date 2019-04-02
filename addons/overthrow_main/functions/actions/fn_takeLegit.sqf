_veh = vehicle player;

if(_veh isEqualTo player) exitWith {};

format["Taking legal inventory from vehicle"] call OT_fnc_notifyMinor;

[5,false] call OT_fnc_progressBar;
sleep 5;

{
	_count = 0;
	_cls = _x select 0;
	_added = 0;
	if(_cls in OT_allItems) then {
		while {_count < (_x select 1)} do {
			if (player canAdd _cls) then {
				player addItem _cls;
				_added = _added + 1;
			};
			_count = _count + 1;
		};
	};
	if !([_veh, _cls, _added] call CBA_fnc_removeItemCargo) then {
		[_veh, _cls, _added] call CBA_fnc_removeWeaponCargo;
	};
}foreach(_veh call OT_fnc_unitStock);

"Inventory Transfer done" call OT_fnc_notifyMinor;
