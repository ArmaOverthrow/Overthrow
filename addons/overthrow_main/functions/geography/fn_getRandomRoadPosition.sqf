private _msize = 150;
private _test = _this;

if(_test isEqualType "") then {
    if ((_test in OT_capitals) || (_test in OT_sprawling)) then {
        _msize = 500;
    };
    _test = server getvariable _test;
};

private _pos = [_test,[random 100,_msize]] call SHK_pos_fnc_pos;
private _roads = _pos nearRoads 100;
if(count _roads > 0) exitWith {
    getPosATL (_roads select 0)
};
_pos
