{
    private _squad = _x;
    _squad leaveVehicle (vehicle player);
    { unassignVehicle _x; } forEach (units _squad);
    (units _x) orderGetIn false;
    (units _squad) allowGetIn false;
    player hcSelectGroup [_squad,false];
}foreach(hcSelected player);
