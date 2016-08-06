_group = _this;


_start = getpos ((units _group) select 0);

_wp = _group addWaypoint [getpos (nearestbuilding _start),0];
_wp setWaypointType "GUARD";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
