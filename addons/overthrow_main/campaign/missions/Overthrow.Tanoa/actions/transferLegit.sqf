_veh = vehicle player;

if(_veh == player) exitWith {};

_objects = [];
{
	if(_x != _veh) then {_objects pushback _x};
}foreach(player nearEntities [["LandVehicle",OT_item_Storage,OT_items_distroStorage select 0],20]);

if(count _objects == 0) exitWith {
	"Cannot find any containers or other vehicles within 20m of this vehicle" call notify_minor;
};
_sorted = [_objects,[],{_x distance player},"ASCEND"] call BIS_fnc_SortBy;
_target = _sorted select 0;

"Transferring legit cargo from container" call notify_minor;
[5,false] call progressBar;	
sleep 5;
_putback = [];
{
	_count = 0;
	_cls = _x select 0;
	if(_cls in (OT_allItems - OT_consumableItems)) then {
		while {_count < (_x select 1)} do {			
			_veh addItemCargoGlobal [_cls,1];		
			_count = _count + 1;
		};
	}else{
		_putback pushback _x;
	};
}foreach(_target call unitStock);
clearItemCargoGlobal _target;
clearMagazineCargoGlobal _target;
clearWeaponCargoGlobal _target;

{
	_count = 0;
	_cls = _x select 0;	
	while {_count < (_x select 1)} do {		
		_count = _count + 1;
		call {
			if(_cls in OT_allWeapons) exitWith {
				_target addWeaponCargoGlobal [_cls,1];
			};
			if(_cls in OT_allMagazines) exitWith {
				_target addMagazineCargoGlobal [_cls,1];
			};
			if(_cls in OT_allBackpacks or _cls in OT_allStaticBackpacks) exitWith {
				_target addBackpackCargoGlobal [_cls,1];
			};
			_target addItemCargoGlobal [_cls,1];
		};	
	};	
}foreach(_putback);

"Cargo Transfer done" call notify_minor;