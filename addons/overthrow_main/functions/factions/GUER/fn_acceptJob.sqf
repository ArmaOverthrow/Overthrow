closeDialog 0;
private _id = OT_jobShowingID;
private _job = OT_jobShowing;

spawner setVariable [format["OT_jobNoExpire%1",_id],false,true];

private _activeJobIds = spawner getVariable ["OT_activeJobIds",[]];
_activeJobIds pushback _id;
spawner setVariable ["OT_activeJobIds",_activeJobIds,false];

_active = spawner getVariable ["OT_activeJobs",[]];
_j = [_id,_job,true,0];
_active pushback _j;
spawner setVariable ["OT_activeJobs",_active,true];
"Job accepted, you can find it in the 'Jobs' screen" call OT_fnc_notifyMinor;
_j spawn OT_fnc_startJob;
