private _totalrep = abs(_this getVariable ["rep",0]) * 0.5;
private _skill = _this getVariable ["OT_stealth",0];
if (_skill isEqualTo 5) exitWith {false};
private _replim = _skill call {
	if(_this isEqualTo 1) exitWith {75};
	if(_this isEqualTo 2) exitWith {100};
	if(_this isEqualTo 3) exitWith {150};
	if(_this isEqualTo 4) exitWith {200};
	50
};
(_totalrep > _replim && random 1000 < _totalrep)