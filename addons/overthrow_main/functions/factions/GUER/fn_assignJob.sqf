params ["_id","_jobdef","_params"];

_jobdef params ["_name","_target","_condition","_code","_repeat"];

systemChat format["Assigning job: %1",_name];

_active = spawner getVariable ["OT_activeJobs",[]];
_job = [_id,_params] call _code;
_j = [_id,_job,_repeat];
_active pushback _j;

spawner setVariable ["OT_activeJobs",_active,true];

_j spawn {
	params ["_id","_job","_repeat"];
	_job params ["_info","_markerPos","_setup","_fail","_success","_end","_jobparams"];
	_jobparams spawn _setup;
	[{
		params ["_id","_job","_repeat","_info","_markerPos","_setup","_fail","_success","_end","_jobparams"];

		private _done = false;
		[{
			(_this select 0) params ["_done","_id","_job","_repeat","_info","_markerPos","_setup","_fail","_success","_end","_jobparams"];			
			if (!_done) then {
				if(_jobparams call _success) exitWith {
					_jobparams pushback true;
					_jobparams call _end;
				};
				if(_jobparams call _fail) exitWith {
					_jobparams pushback false;
					_jobparams call _end;
				};
				_active = spawner getVariable ["OT_activeJobs",[]];
				_active deleteAt (_active find _this);
				spawner setVariable ["OT_activeJobs",_active,true];

				_active = server getVariable ["OT_activeJobIds",[]];
				_active deleteAt (_active find _id);

				if(_repeat < 1) then {
					_completed = server getVariable ["OT_completedJobIds",[]];
					_completed pushback _id;
				};
			};
		}, 1, [_done,_id,_job,_repeat,_info,_markerPos,_setup,_fail,_success,_end,_jobparams]] call CBA_fnc_addPerFrameHandler;
	}, [_id,_job,_repeat,_info,_markerPos,_setup,_fail,_success,_end,_jobparams], 5] call CBA_fnc_waitAndExecute;

};
