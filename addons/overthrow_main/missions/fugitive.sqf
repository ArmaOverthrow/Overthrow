params ["_jobid","_jobparams"];
_jobparams params ["_faction"];

private _factionName = server getvariable format["factionname%1",_faction];

//Here is where we might randomize the parameters a bit
private _reppos = server getVariable [format["factionrep%1",_faction],getpos player];
private _currentTown = _reppos call OT_fnc_nearestTown;
private _abandoned = server getVariable ["NATOabandoned",[]];
private _outofspawndistance = [];
{
    if !((server getVariable _x) call OT_fnc_inSpawnDistance) then {
        private _stability = server getVariable [format["stability%1"],100];
        if !(_x in _abandoned || _x == _currentTown || _stability < 50) then {
            _outofspawndistance pushback _x;
        };
    };
}foreach(OT_allTowns);
private _destinationName = selectRandom _outofspawndistance;
private _posTown = server getVariable [_destinationName,[]];

private _building = [_posTown,OT_allHouses] call OT_fnc_getRandomBuilding;
private _destination = selectRandom (_building buildingPos -1);
if(isNil "_destination") exitWith {};
if(_destination isEqualTo [0,0,0]) then {_destination = [_posTown,[random 100,600]] call SHK_pos_fnc_pos};
private _params = [_faction,_destination,_destinationName,_jobid];
private _markerPos = _destination; //randomize the marker position a bit

//Build a mission description and title
private _description = format["A traitor of %1 has fled here and is hiding in %2 under NATO protection. %1 will pay handsomely and be very grateful if you could just.. make them disappear. <br/><br/>Reward: +20 (%1), $2500",_factionName,_destinationName];
private _title = format["%1 Traitor in %2",_factionName,_destinationName];

//This next number multiplies the reward
private _difficulty = 1.8;

//The data below is what is returned to the gun dealer/faction rep, _markerPos is where to put the mission marker, the code in {} brackets is the actual mission code, only run if the player accepts
[
    [_title,_description],
    _markerPos,
    {
        //Spawn a dude and some protection
        params ["_faction","_destination","_destinationName","_jobid"];

        //Spawn the dude
        private _group = creategroup blufor;
        _group deleteGroupWhenEmpty true;
        private _civ = _group createUnit [OT_civType_gunDealer, _destination, [],0, "NONE"];
        _civ setVariable ["notalk",true,true]; //Tells Overthrow this guy cannot be recruited etc

        _civ disableAI "MOVE";

        //Set face,voice and uniform
        [_civ, (OT_faces_western call BIS_fnc_selectRandom)] remoteExecCall ["setFace", 0, _civ];
        [_civ, (OT_voices_western call BIS_fnc_selectRandom)] remoteExecCall ["setSpeaker", 0, _civ];
        _civ forceAddUniform (OT_clothes_guerilla call BIS_fnc_selectRandom);

        //Make sure hes in the group
        [_civ] joinSilent nil;
        [_civ] joinSilent _group;
        _civ setVariable ["NOAI",true,false];
        _group setVariable ["Vcm_Disable",true,true];

        //reward to killer
        _civ setVariable ["OT_bounty",2500,true];

        //Save him for access later
        spawner setVariable [format["fugitive%1",_jobid],_civ,false];

        //Goons
        private _numGoons = 1+round(random 4);
        private _count = 0;
        private _bgroup = creategroup [blufor,true];
        _bgroup setVariable ["VCM_TOUGHSQUAD",true,true];
        _bgroup setVariable ["VCM_NORESCUE",true,true];
        while {(_count < _numGoons)} do {
            private _start = [[[_destination,5]]] call BIS_fnc_randomPos;

            _civ = _bgroup createUnit [selectRandom OT_NATO_Units_LevelOne, _start, [],0, "NONE"];
            [_civ] joinSilent nil;
            [_civ] joinSilent _bgroup;
            _civ setRank "SERGEANT";
            _civ setBehaviour "SAFE";
            _civ setVariable ["VCOM_NOPATHING_Unit",true,false];
            [_civ,"HQ"] call OT_fnc_initMilitary;
            _civ disableAI "PATH";
            _civ addEventHandler ["FiredNear", {params ["_unit"];_unit enableAI "PATH"}];

            _count = _count + 1;
        };

        _wp = _bgroup addWaypoint [_destination,0];
        _wp setWaypointType "GUARD";
        _wp = _bgroup addWaypoint [_destination,0];
        _wp setWaypointType "CYCLE";
        true
    },
    {
        //Fail check...
        //no fail, just set anyone too close wanted
        params ["_faction","_destination","_destinationName","_jobid"];

        private _civ = spawner getVariable [format["fugitive%1",_jobid],objNull];
        private _alreadyAlerted = _civ getVariable ["OT_fugitiveAlerted",false];
        private _alerted = false;
        {
            if((side _x == resistance || captive _x) && (_x call OT_fnc_unitSeenNATO)) then {
                _x setCaptive false;
                _alerted = true;
            };
        }foreach(_destination nearEntities ["CAManBase",15]);

        if(_alerted and !_alreadyAlerted) then {
            _civ enableAI "MOVE";
            private _factionName = server getvariable format["factionname%1",_faction];
            format ["Incoming message from %1: Traitor has been alerted.",_factionName] remoteExec ["OT_fnc_notifyMinor",0,false];
            private _wp = group _civ addWaypoint [[[[_destination,500]]] call BIS_fnc_randomPos,0];
            _wp setWaypointSpeed "FULL";
            _wp setWaypointCombatMode "COMBAT";
            _civ setVariable ["OT_fugitiveAlerted",true,false];
        };
    },
    {
        //Success.. easy.. if target is dedded
        !alive (spawner getVariable [format["fugitive%1",_this select 3],objNull]);
    },
    {
        params ["_faction","_destination","_destinationName","_jobid","_wassuccess"];

        //If mission was a success
        if (_wassuccess) then {
            [
                {
                    params ["_faction"];
					
					[2500] call OT_fnc_resistanceFunds;
					
                    private _factionName = server getvariable format["factionname%1",_faction];
                    format ["Incoming message from %1: Traitor neutralized. Sending our regards and $2500 to the resistance. (+20 %1)",_factionName] remoteExec ["OT_fnc_notifyMinor",0,false];
                    server setVariable [format["standing%1",_faction],(server getVariable [format["standing%1",_faction],0]) + 20,true];
                },
                [_faction],
                2
            ] call CBA_fnc_waitAndExecute;

        };
        //Clean up
        private _civ = spawner getVariable [format["fugitive%1",_jobid],objNull];
        [group _civ] call OT_fnc_cleanup;
        spawner setVariable [format["fugitive%1",_jobid],nil,false];
    },
    _params
];
