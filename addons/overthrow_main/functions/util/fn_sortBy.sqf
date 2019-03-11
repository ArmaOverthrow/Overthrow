/*
	BIS_fnc_sortBy just less shitty
*/

params [
	["_inputArray", []],
	["_inputParams", []],
	["_algorithmFnc", {}],
	["_sortDirection", "ASCEND"],
	["_filterFnc", {}],
	["_out",[]]
];

// filter is specified
if !(_filterFnc isEqualTo {}) then  {
	_out = _inputArray select _filterFnc;
} else {
	_out = +_inputArray;
};

// alternative sorting algorithm is specified
if !(_algorithmFnc isEqualTo {}) exitWith {
	private _cnt = 0;
	_out = _out apply {
		_cnt = _cnt + 1;
		[_inputParams call _algorithmFnc, _cnt, _x]
	};

	_out sort (_sortDirection == "ASCEND");
	_out apply {_x select 2}
};

_out sort (_sortDirection == "ASCEND");
_out