params ["_qty"];

server setVariable ["factoryQueue",[],true];

[] call OT_fnc_factoryRefresh;
