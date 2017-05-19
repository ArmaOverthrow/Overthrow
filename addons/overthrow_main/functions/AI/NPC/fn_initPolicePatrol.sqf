_group = _this;


_start = getpos (leader _group);

_wp = _group addWaypoint [getpos (nearestbuilding _start),5];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_dest = getpos([_start,OT_allHouses + OT_shops + OT_offices + OT_portBuildings] call OT_fnc_getRandomBuilding);

_wp = _group addWaypoint [_dest,10];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_dest = getpos([_start,OT_allHouses + OT_shops + OT_offices + OT_portBuildings] call OT_fnc_getRandomBuilding);

_wp = _group addWaypoint [_dest,10];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_dest = getpos([_start,OT_allHouses + OT_shops + OT_offices + OT_portBuildings] call OT_fnc_getRandomBuilding);

_wp = _group addWaypoint [_dest,10];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_dest = getpos([_start,OT_allHouses + OT_shops + OT_offices + OT_portBuildings] call OT_fnc_getRandomBuilding);

_wp = _group addWaypoint [_dest,10];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_wp = _group addWaypoint [_start,5];
_wp setWaypointType "CYCLE";