params ["_id","_jobdef","_params"];

_jobdef params ["_name","_target","_condition","_code","_repeat","_chance","_expires"];

private _active = spawner getVariable ["OT_activeJobs",[]];
private _job = [_id,_params] call _code;
private _j = [_id,_job,_repeat,_expires];
_active pushback _j;

spawner setVariable ["OT_activeJobs",_active,true];

private _activeJobIds = spawner getVariable ["OT_activeJobIds",[]];
_activeJobIds pushback _id;
spawner setVariable ["OT_activeJobIds",_activeJobIds,false];

_j spawn OT_fnc_startJob;
