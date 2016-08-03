private ['_A', '_m', '_n', '_At', '_tmp'];
/*
	Author: Kyle Kotowick

	Description:
	Transposes a matrix
*/

_A = [_this,0] call BIS_fnc_param;

_m = count _A;
_n = count (_A select 0);

_At = [];
for "_n" from 0 to (_n - 1) do {
	_tmp = [];
	for "_m" from 0 to (_m - 1) do {
		_tmp pushBack ((_A select _m) select _n);
	};
	_At pushBack _tmp;
};

_At