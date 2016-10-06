_pos = _this;

_sorted = [server getVariable ["activemobsters",[]],[],{(_x select 0) distance _pos},"ASCEND"] call BIS_fnc_SortBy;

_sorted select 0;