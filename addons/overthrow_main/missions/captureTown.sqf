params ["_jobid","_jobparams"];
_jobparams params ["_faction"];

private _factionPos = server getVariable [format["factionrep%1",_faction],[]];
private _destinationName = _factionPos call OT_fnc_nearestTown;
private _params = [_destinationName,_faction];
private _markerPos = server getVariable [_destinationName,[]];
private _factionName = server getvariable format["factionname%1",_faction];

private _effect = format["The town will get a small boost in stability as %1 helps quell the populace.<br/><t size='0.9'>Reward: $10,000 resistance funds, +10 (%1)</t>",_factionName];

//Build a mission description and title
private _description = format["%1 would prefer if %2 was controlled by the resistance. Drop stability in that town by killing Gendarmerie or doing other jobs until it reaches 0%. <br/>%3",_factionName,_destinationName,_effect];
private _title = format["Capture %1 for %2",_destinationName,_factionName];

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
        params ["_destinationName"];

        _destinationName in (server getVariable ["NATOabandoned",[]])
    },
    {
        params ["_destinationName","_faction","_wassuccess"];

        //If mission was a success
        if(_wassuccess) then {
            [_destinationName,10] call OT_fnc_stability;
            [10000] call OT_fnc_resistanceFunds;
            server setVariable [format["standing%1",_faction],(server getVariable [format["standing%1",_faction],0]) + 10,true];
        };
    },
    _params
];
