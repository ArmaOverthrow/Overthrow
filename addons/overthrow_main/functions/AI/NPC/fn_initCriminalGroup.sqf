params ["_group","_townPos"];

_group setVariable ["VCM_NORESCUE",true];
_group setVariable ["VCM_TOUGHSQUAD",true];

private _start = position(leader _group);

_dest = _townPos call OT_fnc_getRandomRoadPosition;
private _firstPos = _dest;

_wp = _group addWaypoint [_dest,5];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_dest = _townPos call OT_fnc_getRandomRoadPosition;

_wp = _group addWaypoint [_dest,10];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_dest = _townPos call OT_fnc_getRandomRoadPosition;

_wp = _group addWaypoint [_dest,10];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_dest = _townPos call OT_fnc_getRandomRoadPosition;

_wp = _group addWaypoint [_dest,10];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_dest = _townPos call OT_fnc_getRandomRoadPosition;

_wp = _group addWaypoint [_dest,10];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_wp = _group addWaypoint [_firstPos,5];
_wp setWaypointType "CYCLE";
