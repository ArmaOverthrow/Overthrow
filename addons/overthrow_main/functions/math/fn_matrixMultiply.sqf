private['_A', '_B', '_m', '_n1', '_n2', '_p', '_result', '_sum', '_i', '_mi', '_ni', '_pi'];
/*
	Author: Kyle Kotowick

	Description:
	Multiplies two matricies together
*/

_A = [_this,0] call BIS_fnc_param;
_B = [_this,1] call BIS_fnc_param;

_m = count _A;
_n1 = count (_A select 0);
_n2 = count _B;
_p = count (_B select 0);

// check if the matricies are appropriate dimensions
if(_n1 != _n2) exitWith {false};

// Create our empty result matrix
_result = [];
for "_i" from 0 to (_m - 1) do {
	_result pushBack [];
};

for "_mi" from 0 to (_m - 1) do {
	for "_pi" from 0 to (_p - 1) do {
		_sum = 0;
		for "_ni" from 0 to (_n1 - 1) do {
			_sum = _sum + (((_A select _mi) select _ni) * ((_B select _ni) select _pi));
		};
		(_result select _mi) set [_pi, _sum];
	};
};

_result
