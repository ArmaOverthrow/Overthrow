//This code is called by the gun dealer or faction rep to retrieve the description and parameters of the mission
private _numtokill = round(random 3)+2;
private _title = "Kill NATO";
private _found = false;

private _groups = [allGroups,[],{(leader _x) distance2D player},"ASCEND",{(side leader _x) isEqualTo west && (count units _x) > 0 && ((leader _x) distance2D player) < 300}] call BIS_fnc_SortBy;
if(count _groups isEqualTo 0) exitWith {[]};

private _group = _groups select 0;
private _numtokill = count units _group;

private _reward = _numtokill * 25;

//Build a mission description
private _description = format["Nothing spurs on the resistance more than just killing some blues. There is a group of %1 NATO within 300m of here, go find them and take care of them.<br/><br/>Reward: $%2",_numtokill,_reward];
private _params = [_group,_reward,_numtokill];

//The data below is what is returned to the gun dealer/faction rep, _markerPos is where to put the mission marker, the code in {} brackets is the actual mission code, only run if the player accepts
[
    [_title,_description],
    position player,
    {
        //No setup
        true
    },
    {
        //No fail
        false
    },
    {
        //Success Check
        params ["_group","","_numtokill"];
        private _numleft = {alive _x} count (units _group);
        hint format["Kills %1/%2",_numtokill - _numleft,_numtokill];
        _numleft isEqualTo 0
    },
    {
        params ["_group","_reward","_numtokill","_wassuccess"];
        if(_wassuccess) then {
            [_reward] call OT_fnc_money;
        };
    },
    _params
];
