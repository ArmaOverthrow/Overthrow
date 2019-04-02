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

_out resize count _inputArray;
private _cnt = -1; // sort stable

_out = _out apply {
	_cnt = _cnt + 1;
	if (_inputParams call _filterFnc) then {
		[_inputParams call _algorithmFnc, _cnt, _x];
	} else {
		nil
	}
};
_out = _out - [nil];
_out sort (_sortDirection == "ASCEND");
_out
