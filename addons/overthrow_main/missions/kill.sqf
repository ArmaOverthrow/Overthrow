//This code is called by the gun dealer or faction rep to retrieve the description and parameters of the mission
private _description = "";
private _numtokill = round(random 3)+2;
private _title = "Kill NATO";
//This next number multiplies the reward
private _difficulty = 0.7 + (_numtokill/5);

//Build a mission description
_description = format["Nothing spurs on the resistance more than just killing some blues. Kill any %1 NATO anywhere without dying.",_numtokill];
_params = [0,_numtokill];

//The data below is what is returned to the gun dealer/faction rep, _markerPos is where to put the mission marker, the code in {} brackets is the actual mission code, only run if the player accepts
[[_title,_description],position player,{
    params ["_p","_faction","_factionName"];
    _p set [0,player getVariable ["BLUkills",0]];
},{
    //Fail check...
    //If player is dead or unconscious
    !(alive player) or (player getvariable ["ace_isunconscious",false])
},{
    //Success Check
    params ["_p","_faction","_factionName"];
    _p params ["_start","_target"];
    _numkills = (player getVariable ["BLUkills",0]) - _start;
    hintSilent format["Kills: %1/%2",_numkills,_target];
    (_numkills >= _target)
},{
    //No cleanup required
},_params,_difficulty];
