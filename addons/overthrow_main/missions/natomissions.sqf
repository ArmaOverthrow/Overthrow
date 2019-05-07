params ["_jobid","_jobparams"];
_jobparams params ["_missiondef"];

private _params = [_missiondef];
_missiondef params ["_missionid","_missiontype","_p1","_p2","_hour"];

//Build a mission description and title
private _description = "";
private _title = "";

if(_missiontype == "CONVOY") then {
    _description = format["We have received intel that NATO will be running a convoy from %1 to %2 at approximately %3:00 today.",_p1 select 1,_p2 select 1,_hour];
    _title = format["NATO Convoy from %1 to %2",_p1 select 1,_p2 select 1];
    //notify the players
    _description remoteExec ["OT_fnc_notifyMinor",0,false];
};

private _markerPos = _p2 select 0;

//The data below is what is returned to the gun dealer/faction rep, _markerPos is where to put the mission marker, the code in {} brackets is the actual mission code, only run if the player accepts
[
    [_title,_description],
    _markerPos,
    {
        //No setup required
    },
    {
        //Fail check...
        false
    },
    {
        //Just remove this job when its an hour past the scheduled time
        params ["_missiondef"];
        _missiondef params ["_id","_ty","_p1","_p2","_hour"];
        (date select 3) > (_hour + 1)
    },
    {
        //we dont need to do anything
    },
    _params
];
