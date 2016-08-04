_group = _this;

//random 4 point cycling patrol
//TODO: remember waypoints on respawn (maybe)

_start = getpos ((units _group) select 0);
_roadselect = (_start nearRoads 400) call BIS_fnc_arrayShuffle;

_end = _roadselect call BIS_fnc_selectRandom;

_group setBehaviour "SAFE";

_wp = _group addWaypoint [_end,0];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [0, 5, 15];

_roadselect = (_start nearRoads 400) call BIS_fnc_arrayShuffle;
_end = _roadselect call BIS_fnc_selectRandom;

_wp = _group addWaypoint [_end,0];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [0, 5, 15];

_roadselect = (_start nearRoads 400) call BIS_fnc_arrayShuffle;
_end = _roadselect call BIS_fnc_selectRandom;

_wp = _group addWaypoint [_end,0];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [0, 5, 15];

_wp = _group addWaypoint [_start,0];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [0, 5, 15];

_wp1 = _group addWaypoint [_start,0];
_wp1 setWaypointType "CYCLE";
_wp setWaypointBehaviour "SAFE";
_wp1 synchronizeWaypoint [_wp];