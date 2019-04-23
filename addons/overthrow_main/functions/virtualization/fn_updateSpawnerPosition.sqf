_changeid = _this select 0;
_start = _this select 1;
_end = _this select 2;

{
    _id = _x select 0;
    if(_id isEqualTo _changeid) exitWith{
        _x set[1,_start];
        _x set[2,_end];
    };
}foreach(OT_allspawners);
