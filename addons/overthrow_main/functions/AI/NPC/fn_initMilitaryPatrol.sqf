private _group = _this;

private _start = position ((units _group) select 0);

if(isNil "_start") exitWith {};

_wp = _group addWaypoint [_start,40];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_dest = [_start,[50,75],45] call SHK_pos;

if(!isNil "_dest" and (_dest select 0) != 0) then {
    _wp = _group addWaypoint [_dest,40];
    _wp setWaypointType "MOVE";
    _wp setWaypointBehaviour "SAFE";
    _wp setWaypointSpeed "LIMITED";
    _wp setWaypointTimeout [10,20,60];
};

_dest = [_start,[50,100],180] call SHK_pos;

if(!isNil "_dest" and (_dest select 0) != 0) then {
    _wp = _group addWaypoint [_dest,40];
    _wp setWaypointType "MOVE";
    _wp setWaypointBehaviour "SAFE";
    _wp setWaypointSpeed "LIMITED";
    _wp setWaypointTimeout [10,20,60];
};

_dest = [_start,[50,100],270] call SHK_pos;

if(!isNil "_dest" and (_dest select 0) != 0) then {
    _wp = _group addWaypoint [_dest,40];
    _wp setWaypointType "MOVE";
    _wp setWaypointBehaviour "SAFE";
    _wp setWaypointSpeed "LIMITED";
    _wp setWaypointTimeout [10,20,60];
};

_dest = [_start,[50,100],0] call SHK_pos;

if(!isNil "_dest" and (_dest select 0) != 0) then {
    _wp = _group addWaypoint [_dest,40];
    _wp setWaypointType "MOVE";
    _wp setWaypointBehaviour "SAFE";
    _wp setWaypointSpeed "LIMITED";
    _wp setWaypointTimeout [10,20,60];
};

_wp = _group addWaypoint [_start,5];
_wp setWaypointType "CYCLE";
