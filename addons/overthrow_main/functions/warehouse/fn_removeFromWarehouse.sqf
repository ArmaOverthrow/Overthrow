
private _cls = _this select 0;
private _num = _this select 1;
private _d = warehouse getVariable [_cls,[_cls,0]];
if(typename _d == "ARRAY") then {
	_in = _d select 1;

	if(_num > _in or _num == -1) then {
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
