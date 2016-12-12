private ["_m","_v","_i","_result","_row"];

_m = _this select 0;
_v = _this select 1;

// Create our empty result vector
_result = [0,0,0,1];

//add in a zero translation to convert to 4x4 matrix
for "_i" from 0 to 2 do {
	_row = _m select _i;
	_row pushBack 0;
};
_m pushBack [0,0,0,1];

for "_i" from 0 to 3 do {
	_result set [_i,(_v select 0) * ((_m select 0) select _i) + (_v select 1) * ((_m select 1) select _i) + (_v select 2) * ((_m select 2) select _i) + ((_m select 3) select _i)];
};
_result set [0,(_result select 0) / (_result select 3)];
_result set [1,(_result select 1) / (_result select 3)];
_result set [2,(_result select 2) / (_result select 3)];

[_result select 0,_result select 1,_result select 2]
