params ["_jobid","_jobparams"];
_jobparams params ["_base","_id"];

private _params = [_base,_id];

//Build a mission description and title
private _description = format["We have received intel that a NATO officer is currently stationed at %1.<br/><br/>If this officer is killed, NATO's resources will be low for some time, reducing the severity of any QRF deployments.",_base];
private _title = format["NATO Officer at %1",_base];
private _markerPos = server getVariable _base;

//The data below is what is returned to the gun dealer/faction rep, _markerPos is where to put the mission marker, the code in {} brackets is the actual mission code, only run if the player accepts
[
    [_title,_description],
    _markerPos,
    {
        //No setup required
        true
    },
    {
        //Fail check...
        //no fail
        false
    },
    {
        //Success.. easy.. if target is dedded
        params ["_base","_id"];
        _found = false;
        {
			if((_x select 0) isEqualTo _id) exitWith {_found = true};
		}foreach(OT_NATOhvts);

        !_found
    },
    {
        //we dont need to do anything
    },
    _params
];
