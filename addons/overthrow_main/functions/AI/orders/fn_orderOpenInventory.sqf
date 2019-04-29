private _sorted = [];
private _unit = (groupSelectedUnits player) select 0;

{
    player groupSelectUnit [_x, false];
} forEach (groupSelectedUnits player);

if((vehicle _unit) != _unit) then {
	_sorted = [vehicle _unit];
}else{
	private _objects = _unit nearEntities [["LandVehicle",OT_item_Storage],20];
	if(count _objects isEqualTo 0) exitWith {
		"Cannot find any containers or vehicles within 20m of first selected unit" call OT_fnc_notifyMinor;
	};
	_sorted = [_objects,[],{_x distance _unit},"ASCEND"] call BIS_fnc_SortBy;
};

if(_sorted isEqualTo []) exitWith {};

private _target = _sorted select 0;

_unit globalchat format["Opening %1",(typeof _target) call OT_fnc_vehicleGetName];
if(((vehicle _unit) != _unit) && (vehicle _unit) != _target) then {
	doGetOut _unit;
};
if(vehicle _unit != _target && (_unit distance _target) > 10) then {
	_unit doMove position _target;
	waitUntil {sleep 1;!alive _unit || (_unit distance _target < 10)};
};

if(alive _unit) then {
	_unit action ["Gear",_target];
};
