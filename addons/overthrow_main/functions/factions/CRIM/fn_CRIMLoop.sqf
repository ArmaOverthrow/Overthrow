crim_counter = crim_counter + 1;
if !(crim_counter < 12) then {
    crim_counter = 0;
    {
        _pop = server getVariable [format["population%1",_x],0];
        _stability = server getVariable [format["stability%1",_x],0];
        _gangs = OT_civilians getVariable [format["gangs%1",_x],[]];
        _garrison = (server getVariable [format["police%1",_x],0]) + (server getVariable [format["garrison%1",_x],0]);
        _town = _x;

        //calculate the chance of a gang forming or increasing in size
        if(_stability < 50) then {
            _chance = (50 - _stability);
            if(_garrison < 4) then {_chance = _chance + 25};
            if((random 200) < _chance) then {
                [_town] call OT_fnc_formOrJoinGang;
            }
        };
    }foreach(OT_allTowns);
};
