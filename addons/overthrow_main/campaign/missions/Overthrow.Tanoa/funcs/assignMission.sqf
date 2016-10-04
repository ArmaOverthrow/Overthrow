/*
[target,position,text,description,onFinish,condition] spawn assignMission

*/
private _target = _this select 0;
private _pos = _this select 1;
private _text = _this select 2;
private _desc = _this select 3;
private _onFinish = {};
private _condition = {(_target distance _pos) < 4};

if((count _this) > 4) then {
	_onFinish = _this select 4;
};
if((count _this) > 5) then {
	_condition = _this select 5;
};

_name = format["%1%2%3",_pos,_text,_desc];
[_target,_name,[_desc,_text,_name],_pos,0,1,true,"move",true] call BIS_fnc_taskCreate;

waitUntil {sleep 1;[] call _condition};

[_name, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;

[_target,_pos] spawn _onFinish;