_group = _this;


_start = getpos ((units _group) select 0);
if(isNil "_start") exitWith {};

_wp = _group addWaypoint [getpos (nearestbuilding _start),35];
_wp setWaypointType "GUARD";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
