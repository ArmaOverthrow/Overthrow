private _sorted = [];
private _unit = (groupSelectedUnits player) select 0;

{
    player groupSelectUnit [_x, false];
} forEach (groupSelectedUnits player);


private _objects = [];
{
	if!(_x isEqualTo _unit) then {_objects pushback _x};
}foreach(_unit nearEntities [["ReammoBox_F"],20]);
if(count _objects isEqualTo 0) exitWith {
	"Cannot find any ammoboxes within 20m of first selected unit" call OT_fnc_notifyMinor;
};
_sorted = [_objects,[],{_x distance _unit},"ASCEND"] call BIS_fnc_SortBy;


if(_sorted isEqualTo []) exitWith {};

private _target = _sorted select 0;
private _iswarehouse = (getpos _target) call OT_fnc_positionIsAtWarehouse;

if(!_iswarehouse) then {
    _unit globalchat "Opening Arsenal (Ammobox)";
}else{
    _unit globalchat "Opening Arsenal (Warehouse)";
};

if(vehicle _unit != _target && (_unit distance _target) > 10) then {
	_unit doMove position _target;
	waitUntil {sleep 1;!alive _unit || (_unit distance _target < 10)};
};

if(alive _unit) then {
	if(_iswarehouse) then {
        ["WAREHOUSE",_unit,_target] call OT_fnc_openArsenal;
    }else{
        [_target,_unit] call OT_fnc_openArsenal;
    };
};
