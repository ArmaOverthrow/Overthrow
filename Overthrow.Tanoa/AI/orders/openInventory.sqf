_sorted = [];
_unit = (groupSelectedUnits player) select 0;

if((vehicle _unit) != _unit) then {
	_sorted = [vehicle _unit];
}else{
	_objects = _unit nearEntities [["LandVehicle",AIT_item_Storage],20];
	if(count _objects == 0) exitWith {
		"Cannot find any containers or vehicles within 20m of first selected unit" call notify_minor;
	};
	_sorted = [_objects,[],{_x distance _unit},"ASCEND"] call BIS_fnc_SortBy;
};

if(count _sorted == 0) exitWith {};

_target = _sorted select 0;

_unit groupChat format["Opening %1",(typeof _target) call ISSE_Cfg_Vehicle_GetName];
if(((vehicle _unit) != _unit) and (vehicle _unit) != _target) then {
	doGetOut _unit;
};
if(vehicle _unit != _target) then {
	_unit doMove getpos _target;
	waitUntil {sleep 1;!alive _unit or unitReady _unit};
};

if(alive _unit) then {
	_unit action ["Gear",_target];
};