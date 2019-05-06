private _group = _this;

private _town = server getVariable ((leader _group) getVariable "hometown");
if(isNil "_town") then {_town = position(leader _group)};
private _start = position(leader _group);

_dest = _town call OT_fnc_getRandomRoadPosition;

_wp = _group addWaypoint [_dest,5];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_dest = _town call OT_fnc_getRandomRoadPosition;

_wp = _group addWaypoint [_dest,10];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_dest = _town call OT_fnc_getRandomRoadPosition;

_wp = _group addWaypoint [_dest,10];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_dest = _town call OT_fnc_getRandomRoadPosition;

_wp = _group addWaypoint [_dest,10];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_dest = _town call OT_fnc_getRandomRoadPosition;

_wp = _group addWaypoint [_dest,10];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_wp = _group addWaypoint [_start,5];
_wp setWaypointType "CYCLE";
