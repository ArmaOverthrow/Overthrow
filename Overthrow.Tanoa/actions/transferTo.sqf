_veh = vehicle player;

if(_veh == player) exitWith {};

_objects = [];
{
	if(_x != _veh) then {_objects pushback _x};
}foreach(player nearEntities [["LandVehicle",AIT_item_Storage],20]);

if(count _objects == 0) exitWith {
	"Cannot find any containers or other vehicles within 20m of this vehicle" call notify_minor;
};
_sorted = [_objects,[],{_x distance player},"ASCEND"] call BIS_fnc_SortBy;
_target = _sorted select 0;

"Transferring cargo to container" call notify_minor;
[5,false] call progressBar;	
sleep 5;
{
	_count = 0;
	_cls = _x select 0;
	while {_count < (_x select 1)} do {	
		_count = _count + 1;
		call {
			if(_cls in AIT_allWeapons) exitWith {
				_target addWeaponCargoGlobal [_cls,1];
			};
			if(_cls in AIT_allMagazines) exitWith {
				_target addMagazineCargoGlobal [_cls,1];
			};
			if(_cls in AIT_allBackpacks) exitWith {
				_target addBackpackCargoGlobal [_cls,1];
			};
			_target addItemCargoGlobal [_cls,1];
		};		
	};
}foreach(_veh call unitStock);
clearMagazineCargoGlobal _veh;
clearWeaponCargoGlobal _veh;
clearItemCargoGlobal _veh;
clearBackpackCargoGlobal _veh;

"Cargo Transfer done" call notify_minor;