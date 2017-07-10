//Let's find some wrecks to salvage

private _done = player getVariable ["OT_tutesDone",[]];
player setVariable ["OT_tutesDone",_done+["Economy"],true];

private _targets = [];
private _destination = [];
private _thistown = (getpos player) call OT_fnc_nearestTown;

//First do we have a toolkit?
if !("ToolKit" in items player) then {
    "Go and grab the toolkit from your ammobox at home, you'll need a backpack to carry it" call OT_fnc_notifyMinor;
    _home = player getVariable "home";
    private _wp = [player,_home,"Grab Toolkit"] call OT_fnc_givePlayerWaypoint;
    while {sleep 5;true} do {
        if("ToolKit" in items player) exitWith {};
    };
};

//Is there some already spawned within spawn distance?
{
    if(damage _x > 0.9) then {
        _targets pushback _x;
    };
}foreach(player nearObjects ["Car", OT_spawnDistance]);


//No? well where is the closest town?
if(count _targets == 0) exitWith {
    private _towns = [OT_townData,[],{(_x select 0) distance player},"ASCEND"] call BIS_fnc_SortBy;
    private _town = _towns select 1;
    private _destination = _town select 0;
    _town = _town select 1;

    if(count _destination > 0) then {
        //give waypoint
        [player,_destination,_town] call OT_fnc_givePlayerWaypoint;

        format["There doesnt seem to be any wrecks nearby. Head to %1, you should be able to find some there. It's marked on your map",_town] call OT_fnc_notifyMinor;

        waitUntil {player distance _destination < 200};
        sleep 10; //If the player fast travelled, give time to spawn

        //loop and hope we find a target
        [] spawn (OT_tutorialMissions select 3);
    };
};

"There is a wreck nearby. Use the toolkit to salvage it" call OT_fnc_notifyMinor;

private _sorted = [_targets,[],{_x distance player},"ASCEND"] call BIS_fnc_SortBy;
private _veh = _sorted select 0;
player reveal [_veh,4];


//give waypoint
private _wp = [player,position _veh,"Wreck"] call OT_fnc_givePlayerWaypoint;
private _done = false;
private _reached = false;

while {sleep 0.5; !_reached} do {
    if(player distance _veh < 10 and "ToolKit" in items player) then {
        _reached = true;
        "Use your interaction key on the wreck to talk to salvage it. The items you get can be sold at any Hardware store, just drive up to it and press 'Y'" call OT_fnc_notifyMinor;
    };
};
call OT_fnc_clearPlayerWaypoint;
