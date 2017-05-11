private _pos = _this;
([server getVariable ["bases",[[[0,0,0]]]],[],{(_x select 0) distance _pos},"ASCEND"] call BIS_fnc_SortBy) select 0
