params [
	"_target",
	"_pos",
	"_text",
	"_desc",
	["_onFinish",{}],
	"_condition",
	["_reward", 0],
	["_infreward", 0],
	"_fail",
	["_params", []]
];

if (isNil "_condition") then {
	_condition = {
		params ["_target", "_pos"];
		(_target distance _pos) < 4
	};
};

if (isNil "_fail") then {
	_fail = {
		params ["_start"];
		time > (_start + 7200)
	};
};

private _start = date;
private _targets = [];
private _string = "";

/* Not used
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
*/

private _start = time;
private _name = format["%1%2%3",_pos,_text,time];//unique task id
[_target,_name,[_desc,_text,_name],_pos,0,1,true,"move"] call BIS_fnc_taskCreate;

private _missions = _target getVariable ["mytasks",[]];
_missions pushback _name;
_target setVariable ["mytasks",_missions,true];

waitUntil {
	sleep 1;
	!(_name in (_target getvariable ["mytasks",[]]))
	||
	((time - _start) > 7200)
	||
	(_params call _condition)
	||
	(_params call _fail)
};

private _success = false;
if(
	((time - _start) > 7200)
	||
	(_params call _fail)
	||
	!(_name in (_target getvariable ["mytasks",[]]))
) then {
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
