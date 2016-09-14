_pos = _this;

_sorted = [AIT_NATO_control,[],{(getMarkerPos _x) distance _pos},"ASCEND"] call BIS_fnc_SortBy;

_sorted select 0;