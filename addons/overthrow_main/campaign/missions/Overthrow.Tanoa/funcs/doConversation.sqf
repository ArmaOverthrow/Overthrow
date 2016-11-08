private _personOne = _this select 0;
private _personTwo = _this select 1;
private _lines = _this select 2;

private _onFinish = {};

if((count _this) > 3) then {
	_onFinish = _this select 3;
};

private _person = _personOne;
{
	_person setRandomLip true;
	_person globalChat _x;	
	sleep ceil ((count _x) * 0.1)+1;	
	_person setRandomLip false;
	if(_person isEqualTo _personOne) then {
		_person = _personTwo;
	}else{
		_person = _personOne;
	};
	
}forEach(_lines);

[] call _onFinish;
