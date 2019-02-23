/*
[target,position,text,description,onFinish,condition] spawn OT_fnc_assignMission

*/
params [
	"_target",
	"_pos",
	"_text",
	"_desc",
	["_onFinish",{}],
	["_condition", {(_target distance _pos) < 4}],
	["_reward", 0],
	["_infreward", 0],
	["_fail", {time > (_start + 7200)}],
	["_params"]
];
private _start = date;
private _targets = [];
private _string = "";

if(_condition isEqualType []) then {
	//array of targets that need to be deaded
	{
		_targets pushback _x;
	}foreach(_condition);
	_condition = {{alive _x} count(_targets) == 0};
};

if(_condition isEqualType "") then {
	_string = _condition;
	_condition = {!((server getvariable [_string,false]) isEqualType [])};
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
