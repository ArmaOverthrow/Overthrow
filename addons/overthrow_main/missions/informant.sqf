params ["_jobid","_jobparams"];

//Here is where we might randomize the parameters a bit
private _abandoned = server getVariable ["NATOabandoned",[]];
private _outofspawndistance = [];
{
    if !((server getVariable _x) call OT_fnc_inSpawnDistance) then {
        private _stability = server getVariable [format["stability%1"],100];
        if !(_x in _abandoned || _stability < 50) then {
            _outofspawndistance pushback _x;
        };
    };
}foreach(OT_allTowns);
private _destinationName = selectRandom _outofspawndistance;
private _posTown = server getVariable [_destinationName,[]];

private _building = [_posTown,OT_allHouses] call OT_fnc_getRandomBuilding;
private _destination = (_building call BIS_fnc_buildingPositions) call BIS_fnc_selectRandom;
if(_destination isEqualTo [0,0,0]) then {
    _destination = [_posTown,[random 100,600]] call SHK_pos_fnc_pos;
};
private _params = [_destination,_destinationName,_jobid];
private _markerPos = _destination; //randomize the marker position a bit

//Build a mission description and title
private _description = format["A defector from the resistance is hiding in %1 under NATO protection and giving them sensitive information. He needs to be silenced. <br/><br/>Reward: $1500",_destinationName];
private _title = format["NATO informant in %1",_destinationName];

//This next number multiplies the reward
private _difficulty = 1.8;

//The data below is what is returned to the gun dealer/faction rep, _markerPos is where to put the mission marker, the code in {} brackets is the actual mission code, only run if the player accepts
[
    [_title,_description],
    _markerPos,
    {
        //Spawn a dude and some protection
        params ["_destination","_destinationName","_jobid"];

        //Spawn the dude
        private _group = creategroup [blufor, true];
        private _civ = _group createUnit [OT_civType_gunDealer, _destination, [],0, "NONE"];
        _civ setVariable ["notalk",true,true]; //Tells Overthrow this guy cannot be recruited etc

        //Set face,voice and uniform
        [_civ, (OT_faces_western call BIS_fnc_selectRandom)] remoteExecCall ["setFace", 0, _civ];
        [_civ, (OT_voices_western call BIS_fnc_selectRandom)] remoteExecCall ["setSpeaker", 0, _civ];
        _civ forceAddUniform (OT_clothes_guerilla call BIS_fnc_selectRandom);

        //Make sure hes in the group
        [_civ] joinSilent nil;
        [_civ] joinSilent _group;
        _civ setVariable ["NOAI",true,false];

        //reward to killer
        _civ setVariable ["OT_bounty",1500,true];

        //Save him for access later
        spawner setVariable [format["informant%1",_jobid],_civ,false];

        //Goons
        private _numGoons = 1+round(random 4);
        private _count = 0;
        private _bgroup = creategroup [blufor, true];
        while {(_count < _numGoons)} do {
            private _start = [[[_destination,5]]] call BIS_fnc_randomPos;

            _civ = _bgroup createUnit [selectRandom OT_NATO_Units_LevelOne, _start, [],0, "NONE"];
            [_civ] joinSilent nil;
            [_civ] joinSilent _bgroup;
            _civ setRank "SERGEANT";
            _civ setBehaviour "SAFE";
            _civ setVariable ["VCOM_NOPATHING_Unit",true,false];

            _count = _count + 1;
        };

        private _wp = _bgroup addWaypoint [_destination,0];
        _wp setWaypointType "GUARD";
    },
    {
        //Fail check...
        //no fail, just set anyone too close wanted
        params ["_destination","_destinationName","_jobid"];

        private _civ = spawner getVariable [format["informant%1",_jobid],objNull];
        private _alreadyAlerted = _civ getVariable ["OT_informantAlerted",false];
        private _alerted = false;
        {
            if((side _x isEqualTo resistance || captive _x) && (_x call OT_fnc_unitSeenNATO)) then {
                _x setCaptive false;
                _alerted = true;
            };
        }foreach(_destination nearEntities ["CAManBase",15]);

        if(_alerted && !_alreadyAlerted) then {
            format ["NATO Informant has been alerted."] remoteExec ["OT_fnc_notifyMinor",0,false];
            private _wp = (group _civ) addWaypoint [[[[_destination,500]]] call BIS_fnc_randomPos,0];
            _wp setWaypointSpeed "FULL";
            _wp setWaypointCombatMode "COMBAT";
            _civ setVariable ["OT_informantAlerted",true,false];
        };
    },
    {
        //Success.. easy.. if target is dedded
        !alive (spawner getVariable [format["informant%1",_this select 2],objNull]);
    },
    {
        params ["_destination","_destinationName","_jobid","_wassuccess"];

        //If mission was a success
        if (_wassuccess) then {
            [{format ["NATO Informant in %1 has been taken care of",_destination call OT_fnc_nearestTown] remoteExec ["OT_fnc_notifyMinor",0,false]},0,2] call CBA_fnc_waitAndExecute;
        };
        //Clean up
        spawner setVariable [format["informant%1",_jobid],nil,false];
    },
    _params
];
