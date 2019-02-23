params ["_qty"];

private _queue = server getVariable ["factoryQueue",[]];
private _idx = lbCurSel 1500;
if(_idx isEqualTo -1) exitWith {};
    
_queue deleteAt _idx;
server setVariable ["factoryQueue",_queue,true];

[] call OT_fnc_factoryRefresh;
