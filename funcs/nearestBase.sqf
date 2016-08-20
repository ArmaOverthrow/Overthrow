_pos = _this;
_obj = server getVariable ["bases",[]];

_sorted = [_obj,[],{(_x select 0) distance _pos},"ASCEND"] call BIS_fnc_SortBy;

_sorted select 0;