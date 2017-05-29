private _lasthr = date select 3;

while {sleep 1; true} do {
    private _hr = (date select 3);
    if (_hr != _lasthr and _hr > 8 and _hr < 18) then {
        _lasthr = _hr;
        {
            _pop = server getVariable [format["population%1",_x],0];
            _stability = server getVariable [format["stability%1",_x],0];
            _wages = [_x,"WAGE",0] call OT_fnc_getPrice;
            _idents = OT_civilians getVariable [format["civs%1",_x],[]];
            _baseexpense = ([_x,"ACE_banana",0] call OT_fnc_getPrice) * 2; //Gotta buy some food, fam
            _town = _x;
            {
                _civ = OT_civilians getVariable [format["%1",_x],[]];
                _civ params ["_identity","_hasjob","_cash"];

                if(_stability > 50 and !_hasjob) then {
                    _hasjob = true;
                    _civ set [1,true];
                };

                if(_hasjob) then {
                    _cash = _cash + _wages;
                };
                //living expenses
                _cash = _cash - (_baseexpense + round random 3);
                if(_cash < 0) then {
                    _cash = 0;
                };
                _civ set [2,_cash];
                if(_stability < 50 and (random 1000) > 998) then {
                    //Civ lost his job
                    _civ set [1,false];
                };
            }foreach(_idents);
        }foreach(OT_allTowns);
    };
};
