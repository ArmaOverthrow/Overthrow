//This code is called by the gun dealer or faction rep to retrieve the description and parameters of the mission
params ["_jobid","_jobparams"];
_jobparams params ["_faction"];

private _factionName = server getvariable format["factionname%1",_faction];
private _pickupTown = "";
private _startpos = getpos player;
private _pickup = [];
private _destinationTown = "";
private _type = "";
private _destination = [];
private _abandoned = server getVariable ["NATOabandoned",[]];

//Here is where we might randomize the parameters a bit
//Find a pickup town
{
    private _town = _x;
    private _posTown = server getVariable _town;
    if([_posTown,_startpos] call OT_fnc_regionIsConnected) exitWith {
        _pickupTown = _town;
        _building = [_posTown,OT_allHouses] call OT_fnc_getRandomBuilding;
        _pickup = selectRandom (_building call BIS_fnc_buildingPositions);
        if(isNil "_pickup") then {
            _pickup = _posTown findEmptyPosition [5,100,OT_civType_local];
        };
    };
}foreach([OT_allTowns,[],{random 100},"ASCEND"] call BIS_fnc_SortBy);

//Find a destination town
{
    private _town = _x;
    private _posTown = server getVariable _town;
    if([_posTown,_pickup] call OT_fnc_regionIsConnected) exitWith {
        _destinationTown = _town;
        _building = [_posTown,OT_allHouses] call OT_fnc_getRandomBuilding;
        _destination = getPos _building;
        if(isNil "_destination") then {
            _destination = _posTown findEmptyPosition [5,100,OT_civType_local];
        };
    };
}foreach([OT_allTowns,[],{random 100},"ASCEND"] call BIS_fnc_SortBy);


//Give our VIP a name
private _firstname = OT_firstNames_local call BIS_fnc_selectRandom;
private _lastname = OT_lastNames_local call BIS_fnc_selectRandom;
private _fullname = [format["%1 %2",_firstname,_lastname],_firstname,_lastname];

private _params = [_faction,_pickup,_destination,_fullname];
private _markerPos = _destination;

//Build a mission description and title
private _description = format["Our intelligence operative %1 is in need of transport from %2 to %3. He is of local descent so you should have no problems passing through NATO checkpoints unnoticed. Please take care of it within 12 hrs.<br/><br/>Reward: +5 (%4), $250",_fullname select 0,_pickupTown,_destinationTown,_factionName];
private _title = format["Operative transport for %1",_factionName];

//The data below is what is returned to the gun dealer/faction rep, _markerPos is where to put the mission marker, the code in {} brackets is the actual mission code, only run if the player accepts
[
    [_title,_description],
    _markerPos,
    {
        params ["_faction","_pickup","_destination","_fullname"];

        //Spawn the dude
        private _civ = (group player) createUnit [OT_civType_gunDealer, _pickup, [],0, "NONE"];
        _civ setVariable ["notalk",true,true]; //Tells Overthrow this guy cannot be recruited etc
        _civ setName _fullname;

        //Set face,voice and uniform
        [_civ, (OT_faces_local call BIS_fnc_selectRandom)] remoteExecCall ["setFace", 0, _civ];
        [_civ, (OT_voices_local call BIS_fnc_selectRandom)] remoteExecCall ["setSpeaker", 0, _civ];
        _civ forceAddUniform (OT_clothes_locals call BIS_fnc_selectRandom);

        //Make sure hes in our group
        [_civ] joinSilent nil;
        [_civ] joinSilent (group player);
        commandStop _civ;

        //And not wanted
        _civ setCaptive true;
        _civ addItem "ItemRadio";

        //Save him for access later
        _this pushback _civ;
        true
    },
    {
        //Fail check...
        //If target is dead
        params ["","","","","_civ"];
        !alive _civ;
    },
    {
        //Success Check
        params ["","","_destination","","_civ"];
        //near the destination and not in a vehicle
        ((_civ distance _destination) < 50) && (vehicle _civ) == _civ
    },
    {
        //Cleanup
        params ["_faction","_pickup","_destination","_fullname","_civ","_wassuccess"];

        _group = createGroup civilian;
        [_civ] joinSilent nil;
        [_civ] joinSilent _group;
        [_group] call OT_fnc_cleanup;

        if(_wassuccess) then {
            [
                {
                    params ["_faction"];
                    private _factionName = server getvariable format["factionname%1",_faction];
                    format ["Incoming message from %1: Thank you for delivering our operative. (+5 %1)",_factionName] remoteExec ["OT_fnc_notifyMinor",0,false];
                    server setVariable [format["standing%1",_faction],(server getVariable [format["standing%1",_faction],0]) + 5,true];
                    [250] call OT_fnc_money;
                },
                [_faction],
                2
            ] call CBA_fnc_waitAndExecute;
        }else{
            private _factionName = server getvariable format["factionname%1",_faction];
            format ["Incoming message from %1: What happened?!? (-10 %1)",_factionName] remoteExec ["OT_fnc_notifyMinor",0,false];
            server setVariable [format["standing%1",_faction],(server getVariable [format["standing%1",_faction],0]) - 10,true];
        };
    },
    _params
];
