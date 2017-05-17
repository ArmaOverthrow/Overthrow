private _total = 0;
private _inf = 0;
{
    private _town = _x;
    _total = _total + 250;
    if(_town in OT_allAirports) then {
        _total = _total + ((server getVariable [format["stability%1",OT_nation],100]) * 3); //Tourism income
    };
    _inf = _inf + 1;
    if(_town in OT_allTowns) then {
        private _population = server getVariable format["population%1",_town];
        private _stability = server getVariable format["stability%1",_town];
        private _garrison = server getVariable [format['police%1',_town],0];
        private _add = round(_population * 4 * (_stability/100));
        if(_stability > 49) then {
            _add = round(_add * 4);
        };
        _total = _total + _add;
    };
}foreach(server getVariable ["NATOabandoned",[]]);
[_total,_inf];
