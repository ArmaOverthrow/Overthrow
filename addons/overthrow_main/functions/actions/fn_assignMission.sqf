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

private _endCode = {
	params ["_thisCode","_endCode","_params","_name","_target","_start","_condition","_fail","_reward","_infreward","_pos","_onFinish","_failed"];
	if(_failed) then {
		[_name, "FAILED",true] call BIS_fnc_taskSetState;
	}else{
		if(_reward > 0) then {
			[_reward] remoteExec ["OT_fnc_money",_target];
		};

		if(_infreward > 0) then {
			_infreward remoteExec ["OT_fnc_influence",_target,false];
		};
		[_name, "SUCCEEDED",true] call BIS_fnc_taskSetState;
	};
	[_target,_pos,_params,!_failed] call _onFinish;
};

private _thisCode = {
	params ["_thisCode","_endCode","_params","_name","_target","_start","_condition","_fail"];
	private _failed = !(_name in (_target getvariable ["mytasks",[]]))
	||
	((time - _start) > 7200)
	||
	(_params call _fail);
	if (_failed || (_params call _condition)) then {
		_this pushBack _failed;
		_this call _endCode;
	} else {
		[
			_thisCode,
			_this,
			1
		] call CBA_fnc_waitAndExecute;
	};
};

[
	_thisCode,
	[_thisCode,_endCode,_params,_name,_target,_start,_condition,_fail,_reward,_infreward,_pos,_onFinish],
	1
] call CBA_fnc_waitAndExecute;
