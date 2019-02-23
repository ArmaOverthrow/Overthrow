private _ret = "";
private _testpos = _this;
private _sel = 0;
if(typename _this isEqualTo "ARRAY") then {
    if(count _this isEqualTo 2) then {
        _testpos = _this select 0;
        _sel = 1;
    };
};
private _towns = [OT_townData,[],{(_x select 0) distance _testpos},"ASCEND"] call BIS_fnc_SortBy;
(_towns select _sel) select 1
