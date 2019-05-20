
private _ret = 0;
private _d = warehouse getVariable [format["item_%1",_this],[_this,0,[0]]];
if(_d isEqualType []) then {
	_d params ["","_in"];
	_ret = _in;
};
_ret
