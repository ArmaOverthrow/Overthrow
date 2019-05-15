params ["_cls","_num"];
private _d = warehouse getVariable [format["item_%1",_cls],[_cls,0,[0]]];
if(_d isEqualType []) then {
	_d params ["","_in"];
	private _newnum = _in + _num;
	warehouse setVariable [format["item_%1",_cls],[_cls,_newnum],true];
};
