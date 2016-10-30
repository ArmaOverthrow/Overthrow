_veh = vehicle player;

if(_veh == player) exitWith {};

_objects = [];
{
	if(_x != _veh) then {_objects pushback _x};
}foreach(player nearEntities [["LandVehicle",OT_item_Storage],20]);

if(count _objects == 0) exitWith {
	"Cannot find any containers or other vehicles within 20m of this vehicle" call notify_minor;
};
_sorted = [_objects,[],{_x distance player},"ASCEND"] call BIS_fnc_SortBy;
_target = _sorted select 0;

"Transferring cargo from container" call notify_minor;
[5,false] call progressBar;				
sleep 5;
{
	_count = 0;
	_cls = _x select 0;
	while {_count < (_x select 1)} do {	
		_count = _count + 1;
		call {
			if(_cls in OT_allWeapons) exitWith {
				_veh addWeaponCargoGlobal [_cls,1];
			};
			if(_cls in OT_allMagazines) exitWith {
				_veh addMagazineCargoGlobal [_cls,1];
			};
			if(_cls in OT_allBackpacks or _cls in OT_allStaticBackpacks) exitWith {
				_veh addBackpackCargoGlobal [_cls,1];
			};
			_veh addItemCargoGlobal [_cls,1];
		};		
	};
}foreach(_target call unitStock);
clearItemCargoGlobal _target;
clearMagazineCargoGlobal _target;
clearWeaponCargoGlobal _target;
clearBackpackCargoGlobal _target;

"Cargo Transfer done" call notify_minor;