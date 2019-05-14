params ["_jobid","_jobparams"];
_jobparams params ["_town"];

private _markerPos = server getVariable [_town,[]];

private _effect = "Stability in the town will drop 10%, Reward: $500 Resistance funds";

//Build a mission description and title
private _description = format["It's time to tell NATO what we think of them and get the public behind the resistance in %1. Do 5 tags in the town. Spraypaint can be purchased from General stores marked with a ($) icon and used on walls with the ACE self-interact key (Ctrl + Windows key by default)<br/><br/>%2",_town,_effect];
private _title = format["Graffiti in %1",_town];
private _startValue = server getVariable [format["tagsin%1",_town],0];
private _params = [_town,_startValue];

//The data below is what is returned to the gun dealer/faction rep, _markerPos is where to put the mission marker, the code in {} brackets is the actual mission code, only run if the player accepts
[
    [_title,_description],
    _markerPos,
    {
        //No setup required for this mission
    },
    {
        //Fail check...
        false
    },
    {
        //Success Check
        params ["_town","_startValue"];

        (server getVariable [format["tagsin%1",_town],0]) == _startValue + 5;
    },
    {
        params ["_town","_startValue","_wassuccess"];

        //If mission was a success
        if(_wassuccess) then {
            [500] call OT_fnc_resistanceFunds;
        };
    },
    _params
];
