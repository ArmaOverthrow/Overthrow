private _group = _this;

_group setVariable ["VCM_NORESCUE",true];
_group setVariable ["VCM_TOUGHSQUAD",true];

private _start = getPosATL ((units _group) select 0);

if(isNil "_start") exitWith {};

private _wp = _group addWaypoint [_start,40];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

private _dest = [_start,[50,75],45] call SHK_pos_fnc_pos;

if(!isNil "_dest" && {(_dest select 0) != 0}) then {
    _wp = _group addWaypoint [_dest,40];
    _wp setWaypointType "MOVE";
    _wp setWaypointBehaviour "SAFE";
    _wp setWaypointSpeed "LIMITED";
    _wp setWaypointTimeout [10,20,60];
};

_dest = [_start,[50,100],180] call SHK_pos_fnc_pos;

if(!isNil "_dest" && {(_dest select 0) != 0}) then {
    _wp = _group addWaypoint [_dest,40];
    _wp setWaypointType "MOVE";
    _wp setWaypointBehaviour "SAFE";
    _wp setWaypointSpeed "LIMITED";
    _wp setWaypointTimeout [10,20,60];
};

_dest = [_start,[50,100],270] call SHK_pos_fnc_pos;

if(!isNil "_dest" && {(_dest select 0) != 0}) then {
    _wp = _group addWaypoint [_dest,40];
    _wp setWaypointType "MOVE";
    _wp setWaypointBehaviour "SAFE";
    _wp setWaypointSpeed "LIMITED";
    _wp setWaypointTimeout [10,20,60];
};

_dest = [_start,[50,100],0] call SHK_pos_fnc_pos;

if(!isNil "_dest" && {(_dest select 0) != 0}) then {
    _wp = _group addWaypoint [_dest,40];
    _wp setWaypointType "MOVE";
    _wp setWaypointBehaviour "SAFE";
    _wp setWaypointSpeed "LIMITED";
    _wp setWaypointTimeout [10,20,60];
};

_wp = _group addWaypoint [_start,5];
_wp setWaypointType "CYCLE";
