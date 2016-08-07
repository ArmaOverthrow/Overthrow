_group = _this;


_start = getpos ((units _group) select 0);

_wp = _group addWaypoint [getpos (nearestbuilding _start),5];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_dest = getpos([_start,AIT_allHouses + AIT_allShops + AIT_offices + AIT_portBuildings] call getRandomBuilding);

_wp = _group addWaypoint [_dest,10];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_dest = getpos([_start,AIT_allHouses + AIT_allShops + AIT_offices + AIT_portBuildings] call getRandomBuilding);

_wp = _group addWaypoint [_dest,10];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_dest = getpos([_start,AIT_allHouses + AIT_allShops + AIT_offices + AIT_portBuildings] call getRandomBuilding);

_wp = _group addWaypoint [_dest,10];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_dest = getpos([_start,AIT_allHouses + AIT_allShops + AIT_offices + AIT_portBuildings] call getRandomBuilding);

_wp = _group addWaypoint [_dest,10];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_wp = _group addWaypoint [_start,5];
_wp setWaypointType "CYCLE";