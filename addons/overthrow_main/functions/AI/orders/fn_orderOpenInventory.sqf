private _sorted = [];
private _unit = (groupSelectedUnits player) select 0;

{
    player groupSelectUnit [_x, false];
} forEach (groupSelectedUnits player);

if((vehicle _unit) != _unit) then {
	_sorted = [vehicle _unit];
}else{
    private _objects = [];
    {
    	if!(_x isEqualTo _unit) then {_objects pushback _x};
    }foreach(_unit nearEntities [["Car","ReammoBox_F","Air","Ship"],5]);
	if(count _objects isEqualTo 0) exitWith {
		_unit action ["Gear",objNull];
	};
	_sorted = [_objects,[],{_x distance _unit},"ASCEND"] call BIS_fnc_SortBy;
};

if((count _sorted) isEqualTo 0) exitWith {
    _unit action ["Gear",objNull];
};

private _target = _sorted select 0;

_unit globalchat format["Opening %1",(typeof _target) call OT_fnc_vehicleGetName];

if(alive _unit) then {
	_unit action ["Gear",_target];
};
