civ_loop_lasthr = date select 3;

["faction_civ_loop","_counter%1 isEqualTo 0","
private _hr = (date select 3);
if (_hr != civ_loop_lasthr && {_hr > 8} && {_hr < 18}) then {
    civ_loop_lasthr = _hr;
    {
        _pop = server getVariable [format[""population%1"",_x],0];
        _stability = server getVariable [format[""stability%1"",_x],0];
        _wages = [_x,""WAGE"",0] call OT_fnc_getPrice;
        _idents = OT_civilians getVariable [format[""civs%1"",_x],[]];
        _baseexpense = ([_x,""ACE_banana"",0] call OT_fnc_getPrice) * 2;
        _town = _x;
        {
            _civ = OT_civilians getVariable [format[""%1"",_x],[]];
            _civ params [""_identity"",[""_hasjob"",false],[""_cash"",0]];

            if(_stability > 50 && {!_hasjob}) then {
                _hasjob = true;
                _civ set [1,true];
            };

            if(_hasjob) then {
                _cash = _cash + _wages;
            };
            _cash = _cash - (_baseexpense + round random 3);
            if(_cash < 0) then {
                _cash = 0;
            };
            _civ set [2,_cash];
            if(_stability < 50 && {(random 1000) > 998}) then {
                _civ set [1,false];
            };
        }foreach(_idents);
    }foreach(OT_allTowns);
};
"] call OT_fnc_addActionLoop;
