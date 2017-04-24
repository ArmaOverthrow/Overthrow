_veh = vehicle player;

if(_veh == player) exitWith {};

format["Taking legal inventory from vehicle"] call notify_minor;

[5,false] call progressBar;
sleep 5;

{
	_count = 0;
	_cls = _x select 0;
	_added = 0;
	if(_cls in (OT_allItems - OT_consumableItems)) then {
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

"Inventory Transfer done" call notify_minor;
