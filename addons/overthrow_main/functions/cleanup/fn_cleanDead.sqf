{
    {
        if (!alive _x) then {
            _x remoteExecCall ["deleteVehicle", _x];
        };
    } foreach crew _x;
    if (!alive _x) then {
        _x remoteExecCall ["deleteVehicle", _x];
    };
} foreach vehicles;
{
    _x remoteExecCall ["deleteVehicle", _x];
} foreach allDeadMen;
