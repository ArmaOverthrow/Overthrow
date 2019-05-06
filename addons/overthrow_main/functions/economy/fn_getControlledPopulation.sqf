private _totalpop = 0;
{
    if (_x in server getVariable ["NATOabandoned",[]]){
        _totalpop = _totalpop + server getVariable [format["population%1",_x],0];
    };
}foreach(OT_allTowns);
_totalpop
