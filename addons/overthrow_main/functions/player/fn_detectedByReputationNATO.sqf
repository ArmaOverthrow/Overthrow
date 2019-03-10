private _skill = _this getVariable ["OT_stealth",0];
if (_skill isEqualTo 5) exitWith {false};
private _town = getPosATL _this call OT_fnc_nearestTown; // @todo try to fetch townChangeVar
private _totalrep = ((_this getVariable ["rep",0]) * -0.25) + ((_this getVariable [format["rep%1",_town],0]) * -1);
private _replim = _skill call {
	if(_this isEqualTo 1) exitWith {75};
	if(_this isEqualTo 2) exitWith {100};
	if(_this isEqualTo 3) exitWith {150};
	if(_this isEqualTo 4) exitWith {200};
	50
};
(_totalrep > _replim && random 1000 < _totalrep)