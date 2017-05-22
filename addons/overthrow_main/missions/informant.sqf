
private _description = "";
private _destination = [];
private _destinationName = "";
private _title = "";

//Here is where we might randomize the parameters a bit
private _abandoned = server getVariable ["NATOabandoned",[]];
_destinationName = selectRandom (OT_allTowns - _abandoned - [player call OT_fnc_nearestTown]);
private _posTown = server getVariable [_destinationName,[]];

_building = [_posTown,OT_allHouses] call OT_fnc_getRandomBuilding;
_destination = (_building call BIS_fnc_buildingPositions) call BIS_fnc_selectRandom;
if((_destination select 0) == 0) then {_destination = [_posTown,[random 100,600]] call SHK_pos};
private _params = [_destination,_destinationName];
private _markerPos = [[[_destination,50]]] call BIS_fnc_randomPos; //randomize the marker position a bit

//Build a mission description and title
_description = format["Intelligence reports that a member of the resistance is providing NATO with classified information. He must be stopped immediately. He was last seen in %1.",_destinationName];
_title = format["NATO Informant in %1",_destinationName];

//This next number multiplies the reward
_difficulty = 2 + random(0.5);
if(random(100)>99) then {_difficulty = _difficulty + 1}; //random chance of a bigger payout

//The data below is what is returned to the gun dealer/faction rep, _markerPos is where to put the mission marker, the code in {} brackets is the actual mission code, only run if the player accepts
[[_title,_description],_markerPos,{
    //Spawn a dude and some protection
    params ["_p","_faction","_factionName"];
    _p params ["_destination","_destinationName"];

    //Spawn the dude
    _group = creategroup blufor;
    _start = [[[_destination,5]]] call BIS_fnc_randomPos;
    _civ = _group createUnit [OT_civType_gunDealer, _start, [],0, "NONE"];
    _civ setVariable ["notalk",true,true]; //Tells Overthrow this guy cannot be recruited etc

    _dest = getpos(nearestbuilding _start);

    _wp = _group addWaypoint [_dest,10];
    _wp setWaypointType "GUARD";
    _wp setWaypointBehaviour "SAFE";
    _wp setWaypointSpeed "LIMITED";

    //Set face,voice and uniform
    [_civ, (OT_faces_local call BIS_fnc_selectRandom)] remoteExecCall ["setFace", 0, _civ];
    [_civ, (OT_voices_local call BIS_fnc_selectRandom)] remoteExecCall ["setSpeaker", 0, _civ];
    _civ forceAddUniform (OT_clothes_guerilla call BIS_fnc_selectRandom);

    //Make sure hes in the group
    [_civ] joinSilent grpNull;
    [_civ] joinSilent _group;

    //Save him for access later
    player setVariable [format["informant%1",_faction],_civ,false];

    //Goons
    _numGoons = round(random 4) + 2;
    _count = 0;
    _bgroup = creategroup blufor;
    while {(_count < _numGoons)} do {
		_start = [[[_destination,40]]] call BIS_fnc_randomPos;

        _civ = _bgroup createUnit [OT_NATO_Units_LevelOne call BIS_fnc_selectRandom, _start, [],0, "NONE"];
		_civ setVariable ["garrison","HQ",false];
		_civ setRank "LIEUTENANT";
		_civ setBehaviour "SAFE";

		_count = _count + 1;
	};
    _wp = _bgroup addWaypoint [_dest,10];
    _wp setWaypointType "GUARD";
    _wp setWaypointBehaviour "SAFE";
    _wp setWaypointSpeed "LIMITED";
},{
    //Fail check...
    false; //"He must be stopped"
},{
    //Success.. easy.. if target is dedded
    !alive (player getVariable [format["informant%1",_this select 1],objNull]);
},{
    //Player can deal with this mess
},_params,_difficulty];
