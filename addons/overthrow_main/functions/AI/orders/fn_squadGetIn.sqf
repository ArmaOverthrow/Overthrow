{
    private _veh = _x getVariable ["OT_assigned",objNull];
    (units _x) allowGetIn true;
    if !(isNull _veh) then {
        _x addVehicle _veh;
        (units _x) orderGetIn true;
    };
    player hcSelectGroup [_x,false];
}foreach(hcSelected player);
