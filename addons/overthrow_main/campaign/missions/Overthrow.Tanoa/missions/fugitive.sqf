
private _description = "";
private _destination = [];
private _destinationName = "";
private _title = "";

//Here is where we might randomize the parameters a bit
private _abandoned = server getVariable ["NATOabandoned",[]];
_destinationName = selectRandom (OT_allTowns - _abandoned - [player call OT_fnc_nearestTown]);
private _posTown = server getVariable [_destinationName,[]];

_building = [_posTown,OT_gunDealerHouses] call OT_fnc_getRandomBuilding;
_destination = (_building call BIS_fnc_buildingPositions) call BIS_fnc_selectRandom;
private _params = [_destination,_destinationName];
private _markerPos = [[[_destination,50]]] call BIS_fnc_randomPos; //randomize the marker position a bit

//Build a mission description and title
_description = format["A traitor from our country has fled here and is hiding in %1. We will pay handsomely and be very grateful if you could just.. make him disappear.",_destinationName];
_title = format["Traitor in %1",_destinationName];

//This next number multiplies the reward
_difficulty = 1.8;

//The data below is what is returned to the gun dealer/faction rep, _markerPos is where to put the mission marker, the code in {} brackets is the actual mission code, only run if the player accepts
[[_title,_description],_markerPos,{
    //Spawn a dude and some protection
    params ["_p","_faction","_factionName"];
    _p params ["_destination","_destinationName"];

    //Spawn the dude
    _group = creategroup opfor;
    _start = [[[_destination,40]]] call BIS_fnc_randomPos;
    _civ = _group createUnit [OT_civType_gunDealer, _start, [],0, "NONE"];
    _civ setVariable ["notalk",true,true]; //Tells Overthrow this guy cannot be recruited etc

    //Set face,voice and uniform
    [_civ, (OT_faces_western call BIS_fnc_selectRandom)] remoteExecCall ["setFace", 0, _civ];
    [_civ, (OT_voices_western call BIS_fnc_selectRandom)] remoteExecCall ["setSpeaker", 0, _civ];
    _civ forceAddUniform (OT_clothes_guerilla call BIS_fnc_selectRandom);

    //Make sure hes in the group
    [_civ] joinSilent grpNull;
    [_civ] joinSilent _group;

    //And not wanted
    _civ setCaptive true;

    //Save him for access later
    player setVariable [format["fugitive%1",_faction],_civ,false];

    //Goons
    _numGoons = round(random 4);
    _count = 0;
    _bgroup = creategroup opfor;
    while {(_count < _numGoons)} do {
		_start = [[[_destination,5]]] call BIS_fnc_randomPos;

		_civ = _bgroup createUnit [OT_CRIM_Unit, _start, [],0, "NONE"];
		[_civ] joinSilent nil;
		[_civ] joinSilent _bgroup;
		_civ setRank "PRIVATE";
		_civ call OT_fnc_initMobster;
		_civ setBehaviour "SAFE";

		_count = _count + 1;
	};
},{
    //Fail check...
    //If player is known by the target
    ((player getVariable [format["fugitive%1",_this select 1],objNull]) knowsAbout player) > 1
},{
    //Success.. easy.. if target is dedded
    !alive (player getVariable [format["fugitive%1",_this select 1],objNull]);
},{
    params ["_target","_pos","_p","_wassuccess"];
    _p params ["_missionParams","_faction","_factionName","_finish","_rewards"];

    //If mission was not a success
    if !(_wassuccess) then {
        format ["Incoming message from %1: 'Abort mission. You have been spotted.'",_factionName] call OT_fnc_notifyMinor;

        //Get outta here
        _group = group (player getVariable [format["fugitive%1",_faction],objNull]);
        _wp = _group addWaypoint [[[[_missionParams select 0,1000]]] call BIS_fnc_randomPos,0];
		_wp setWaypointType "MOVE";
		_wp setWaypointSpeed "FULL";

        [_group] call OT_fnc_cleanup;
    };
},_params,_difficulty];
