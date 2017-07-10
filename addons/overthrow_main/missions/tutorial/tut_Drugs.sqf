//Let's find some civs to sell drugs to

private _done = player getVariable ["OT_tutesDone",[]];
player setVariable ["OT_tutesDone",_done+["Drugs"],true];

private _targets = [];
private _destination = [];
private _thistown = (getpos player) call OT_fnc_nearestTown;

//Is there some already spawned within spawn distance?
{
    if(side _x == civilian and !(captive _x) and count(_x getVariable ["shop",[]]) == 0 and !(_x getVariable ["gundealer",false]) and !(_x call OT_fnc_hasOwner)) then {
        _targets pushback _x;
    };
}foreach(player nearEntities ["CAManBase", OT_spawnDistance]);


//No? well where is the closest town?
if(count _targets == 0) exitWith {
    private _towns = [OT_townData,[],{(_x select 0) distance player},"ASCEND"] call BIS_fnc_SortBy;
    private _town = _towns select 1;
    private _destination = _town select 0;
    _town = _town select 1;

    if(count _destination > 0) then {
        //give waypoint
        [player,_destination,_town] call OT_fnc_givePlayerWaypoint;

        format["There doesnt seem to be any civilians nearby. Head to %1, you should be able to find some there. It's marked on your map",_town] call OT_fnc_notifyMinor;

        waitUntil {player distance _destination < 200};
        sleep 10; //If the player fast travelled, give time to spawn

        //loop and hope we find a target
        [] spawn (OT_tutorialMissions select 2);
    };
};

"There is a civilian nearby, their position has been marked on your map." call OT_fnc_notifyMinor;
//pick the closest group and reveal

private _sorted = [_targets,[],{_x distance player},"ASCEND"] call BIS_fnc_SortBy;
private _group = group (_sorted select 0);
player reveal [leader _group,4];

//give waypoint
private _wp = [player,position leader _group,"Customer"] call OT_fnc_givePlayerWaypoint;
private _done = false;
private _reached = false;

while {sleep 0.5; !_reached} do {
    if(!isNil "_wp") then {
        //update waypoint
        OT_missionMarker = position leader _group;
        _wp setWaypointPosition [OT_missionMarker, 0];
    };
    if(player distance (leader _group) < 30) then {
        _reached = true;
        "Use your interaction key on the civilian to talk to them and see if they wanna buy your Ganja. Not everyone is into the sweet herb, but just keep trying until you get lucky." call OT_fnc_notifyMinor;
    };
};
call OT_fnc_clearPlayerWaypoint;
