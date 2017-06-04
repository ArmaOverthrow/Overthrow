private _msize = 150;
private _test = _this;
if(typename _test == "STRING") then {
    if((_test in OT_capitals) or (_test in OT_sprawling)) then {_msize = 500};
    _test = server getvariable _test;
};
_pos = [_test,[random 100,_msize]] call SHK_pos;
_roads = _pos nearRoads 100;
if(count _roads > 0) then {_pos = position (_roads select 0)};

_pos
