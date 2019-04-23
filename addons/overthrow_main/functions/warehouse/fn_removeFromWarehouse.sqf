
params ["_cls","_num"];
private _d = warehouse getVariable [_cls,[_cls,0]];
if(typename _d isEqualTo "ARRAY") then {
	_d params ["","_in"];

	if(_num > _in || _num isEqualTo -1) then {
		_num = _in;
	};

	private _newnum = _in - _num;
	if(_newnum > 0) then {
		warehouse setVariable [_cls,[_cls,_newnum],true];
	}else{
		warehouse setVariable [_cls,nil,true];
	};
}else{
	warehouse setVariable [_cls,nil,true];
};
