private _group = _this;

private _garrison = ((units _group) select 0) getvariable ["garrison",""];
private _start = position ((units _group) select 0);

if(isNil "_start") exitWith {};

_wp = _group addWaypoint [_start,5];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_dest = getpos([_start,OT_allHouses + OT_allShops + OT_offices + OT_portBuildings] call getRandomBuilding);

_wp = _group addWaypoint [_dest,10];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_dest = getpos([_start,OT_allHouses + OT_allShops + OT_offices + OT_portBuildings] call getRandomBuilding);

_wp = _group addWaypoint [_dest,10];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_dest = getpos([_start,OT_allHouses + OT_allShops + OT_offices + OT_portBuildings] call getRandomBuilding);

_wp = _group addWaypoint [_dest,10];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_dest = getpos([_start,OT_allHouses + OT_allShops + OT_offices + OT_portBuildings] call getRandomBuilding);

_wp = _group addWaypoint [_dest,10];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointTimeout [10,20,60];

_wp = _group addWaypoint [_start,5];
_wp setWaypointType "CYCLE";
