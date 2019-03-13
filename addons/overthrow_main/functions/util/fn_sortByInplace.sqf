/*
	BIS_fnc_sortBy just less shitty and in place (changing the array instead of a copy)
*/

params [
	["_inputArray", []],
	["_inputParams", []],
	["_algorithmFnc", {}],
	["_sortDirection", "ASCEND"],
	["_filterFnc", {false}],
	["_out", []]
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
_inputArray resize 0;

{
	_inputArray pushBack (_x select 2);
} forEach _out;

_inputArray