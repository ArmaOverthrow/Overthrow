/*
[target,position,text,description,onFinish,condition] spawn OT_fnc_assignMission

*/
private _target = _this select 0;
private _pos = _this select 1;
private _text = _this select 2;
private _desc = _this select 3;
private _onFinish = {};
private _condition = {(_target distance _pos) < 4};
private _start = date;
private _fail = {time > (_start + 7200)};
private _targets = [];
private _string = "";
private _reward = 0;
private _infreward = 0;
private _params = [];

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
if((count _this) > 8) then {
	_fail = _this select 8;
};
if((count _this) > 9) then {
	_params = _this select 9;
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

private _start = time;

_name = format["%1%2%3",_pos,_text,time];//unique task id
[_target,_name,[_desc,_text,_name],_pos,0,1,true,"move"] call BIS_fnc_taskCreate;

_missions = _target getVariable ["mytasks",[]];
_missions pushback _name;
_target setVariable ["mytasks",_missions,true];

waitUntil {sleep 1;!(_name in (_target getvariable ["mytasks",[]])) or ((time - _start) > 7200) or (_params call _condition) or (_params call _fail)};
_success = false;
if(((time - _start) > 7200) or (_params call _fail) or !(_name in (_target getvariable ["mytasks",[]]))) then {
	[_name, "FAILED",true] spawn BIS_fnc_taskSetState;
}else{
	if(_reward > 0) then {
		[_reward] remoteExec ["OT_fnc_money",_target];
	};

	if(_infreward > 0) then {
		_infreward remoteExec ["OT_fnc_influence",_target,false];
	};
	_success = true;
	[_name, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;

};

[_target,_pos,_params,_success] spawn _onFinish;
