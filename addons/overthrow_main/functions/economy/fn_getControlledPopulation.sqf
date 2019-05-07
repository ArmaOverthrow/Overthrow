private _totalpop = 0;
private _abandoned = server getVariable ["NATOabandoned",[]];
{
    if (_x in _abandoned) then {
        _totalpop = _totalpop + (server getVariable [format["population%1",_x],0]);
    };
}foreach(OT_allTowns);
_totalpop
