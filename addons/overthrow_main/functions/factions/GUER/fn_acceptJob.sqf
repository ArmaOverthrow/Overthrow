closeDialog 0;
private _id = OT_jobShowingID;
private _job = OT_jobShowing;
private _expiry = OT_jobShowingExpiry;

if(_expiry isEqualTo 0) then {
    spawner setVariable [format["OT_jobNoExpire%1",_id],false,true];
};

private _activeJobIds = spawner getVariable ["OT_activeJobIds",[]];
_activeJobIds pushback _id;
spawner setVariable ["OT_activeJobIds",_activeJobIds,false];

_active = spawner getVariable ["OT_activeJobs",[]];
_j = [_id,_job,1,_expiry];
_active pushback _j;
spawner setVariable ["OT_activeJobs",_active,true];
"Job accepted, you can find it in the 'Jobs' screen" call OT_fnc_notifyMinor;
_j spawn OT_fnc_startJob;

_job params ["_info","_markerPos"];
[player,_markerPos,_info select 0] call OT_fnc_givePlayerWaypoint;
