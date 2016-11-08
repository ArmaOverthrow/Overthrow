/*
[target,position,text,description,onFinish,condition] spawn assignMission

*/
private _target = _this select 0;
private _pos = _this select 1;
private _text = _this select 2;
private _desc = _this select 3;
private _onFinish = {};
private _condition = {(_target distance _pos) < 4};
private _targets = [];
private _string = "";
private _reward = 0;
private _infreward = 0;

if((count _this) > 4) then {
	_onFinish = _this select 4;
};
if((count _this) > 5) then {
	_condition = _this select 5;
};
if((count _this) > 6) then {
	_reward = _this select 6;
};
if((count _this) > 7) then {
	_infreward = _this select 7;
};

if(typename _condition == "ARRAY") then {
	//array of targets that need to be deaded
	{
		_targets pushback _x;
	}foreach(_condition);
	_condition = {{alive _x} count(_targets) == 0};
};

if(typename _condition == "STRING") then {
	_string = _condition;
	_condition = {typename(server getvariable [_string,false]) != "ARRAY"};
};

_name = format["%1%2%3",_pos,_text,_desc];
[_target,_name,[_desc,_text,_name],_pos,0,1,true,"move",true] call BIS_fnc_taskCreate;

waitUntil {sleep 1;[] call _condition};

if(_reward > 0) then {
	_reward remoteExec ["money",_target];
};

if(_infreward > 0) then {
	_infreward remoteExec ["influence",_target];
};

[_name, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;

[_target,_pos] spawn _onFinish;