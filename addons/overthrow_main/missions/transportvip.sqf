//This code is called by the gun dealer or faction rep to retrieve the description and parameters of the mission


private _description = "";
private _pickupTown = "";
private _pickup = [];
private _destination = [];
private _destinationTown = "";
private _type = "";
private _title = "";
private _abandoned = server getVariable ["NATOabandoned",[]];

//Here is where we might randomize the parameters a bit
//Is this an insertion or an extraction?
if((random 100) > 50) then { // 50/50 chance of either
    //Insertion
    //Pickup will be a random port, somewhere within 80m that he can stand, hopefully not inside a rock
    _pickup = [[[getMarkerPos format["port_%1", ceil(random 2)],80]]] call BIS_fnc_randomPos;
    _pickupTown = _pickup call OT_fnc_nearestTown;

    //Destination is a random town
    _destinationTown = selectRandom (OT_allTowns - _abandoned - [player call OT_fnc_nearestTown]);
    _posTown = server getVariable _destinationTown;

    //Pick a random building as the dropoff
    _building = [_posTown,OT_allHouses] call OT_fnc_getRandomBuilding;
	_destination = position _building;
    if((_destination select 0) == 0) then {_destination = [_posTown,[random 100,600]] call SHK_pos};
    _type = "insertion";
}else{
    //Extraction
    //Pickup will be a random town
    _pickupTown = selectRandom (OT_allTowns - _abandoned - [player call OT_fnc_nearestTown]);
    _posTown = server getVariable _pickupTown;
    _pickup = [[[_posTown,200]]] call BIS_fnc_randomPos;

    //Destination is a random port
    _destination = getMarkerPos format["port_%1", ceil(random 2)];
    _destinationTown = _destination call OT_fnc_nearestTown;
    _type = "extraction";
};

//Give our VIP a name
private _firstname = OT_firstNames_local call BIS_fnc_selectRandom;
private _lastname = OT_lastNames_local call BIS_fnc_selectRandom;
private _fullname = [format["%1 %2",_firstname,_lastname],_firstname,_lastname];

private _params = [_pickup,_destination,_fullname];
private _markerPos = _destination;

//Build a mission description and title
_description = format["Our intelligence operative %1 is in need of transport from %2 to %3. He is of local descent so you should have no problems passing through NATO checkpoints unnoticed.",_fullname select 0,_pickupTown,_destinationTown];
_title = format["Operative %1",_type];

//This next number multiplies the reward
_difficulty = 1.5;

//The data below is what is returned to the gun dealer/faction rep, _markerPos is where to put the mission marker, the code in {} brackets is the actual mission code, only run if the player accepts
[[_title,_description],_markerPos,{
    params ["_p","_faction","_factionName"];
    _p params ["_pickup","_destination","_fullname"];

    //Spawn the dude
    _civ = (group player) createUnit [OT_civType_gunDealer, _pickup, [],0, "NONE"];
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
    player setVariable [format["vip%1",_faction],_civ,false];
},{
    //Fail check...
    //If target is dead
    !alive (player getVariable [format["vip%1",_this select 1],objNull]);
},{
    //Success Check
    params ["_p","_faction","_factionName"];
    _p params ["_pickup","_destination"];

    _civ = player getVariable [format["vip%1",_faction],objNull];
    //near the destination and not in a vehicle
    ((_civ distance _destination) < 50) and (vehicle _civ) == _civ
},{
    //Cleanup
    _civ = player getVariable [format["vip%1",_this select 1],objNull];
    player setVariable [format["vip%1",_faction],nil,false];
    _group = createGroup civilian;
    [_group] spawn OT_fnc_cleanup;
    [_civ] joinSilent nil;
    [_civ] joinSilent _group;

},_params,_difficulty];
