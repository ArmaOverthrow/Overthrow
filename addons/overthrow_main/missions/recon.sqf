//This code is called by the gun dealer or faction rep to retrieve the description and parameters of the mission


private _description = "";
private _destination = [];
private _destinationName = "";
private _title = "";
//This next number multiplies the reward
private _difficulty = 1;

//Here is where we might randomize the parameters a bit
private _nearestOb = (getpos player) call OT_fnc_nearestObjective;
_destinationName = _nearestOb select 1;
private _known = 0;
{
    if(side _x == west) then {
        if(_x getVariable ["garrison",""] == _destinationName) then {
            if((resistance knowsAbout _x) > 0) then {
                _known = _known + 1;
            };
        };
    };
}foreach(allunits);

if(_known > 0 or (_destinationName in (server getVariable ["NATOabandoned",[]])) or (random 100) > 90) then {
    _destinationName = selectRandom OT_allObjectives;
    _difficulty = 1;
}else{
    _destination = _nearestOb select 0;
};

private _params = [_destination,_destinationName,0,false];
private _markerPos = _destination;

//Build a mission description and title
_description = format["The resistance could use some information on the military presence at %1. Go and check it out, but keep your distance and try not to alert them. A pair of binoculars would be useful, we will notify as you spot personnel.",_destinationName];
_title = format["%1 Recon",_destinationName];


//The data below is what is returned to the gun dealer/faction rep, _markerPos is where to put the mission marker, the code in {} brackets is the actual mission code, only run if the player accepts
[[_title,_description],_markerPos,{
    //No setup required for this mission
},{
    //Fail check...
    //If player is wanted
    !(captive player);
},{
    //Success Check
    params ["_p","_faction","_factionName"];
    _p params ["_destination","_destinationName","_lastKnown","_active"];
    if !(_active) then {
        if((player distance _destination) < OT_spawnDistance) then {_p set [3,true];}
    }else{
        if((player distance _destination) > OT_spawnDistance) then {_p set [3,false];_active = false;}
    };
    _count = 0;
    _known = 0;
    if(_active) exitWith {
        {
            if(side _x == west) then {
                if(_x getVariable ["garrison",""] == _destinationName) then {
                    _count = _count + 1;
                    if((resistance knowsAbout _x) > 0) then {
                        _known = _known + 1;
                    };
                };
            };
        }foreach(allunits);
        _need = round(_count * 0.5);
        hintSilent format["Military spotted: %1",_known];
        (_known >= _need) or _need <= 0
    };
    false
},{
    //No cleanup required
},_params,_difficulty];
