private _g = _this;

private _start = getpos ((units _g) select 0);
if(isNil "_start") exitWith {};
if(typename _start == "BOOL") exitWith {};

_g setBehaviour "SAFE";

private _hour = date select 3;

private _start = getpos ((units _g) select 0);
if(isNil "_start") exitWith {};
private _town = (leader _g) getVariable "hometown";
if(isNil "_town") then {_town = position(leader _g)};

private _dest = _town call OT_fnc_getRandomRoadPosition;

private _wp = _g addWaypoint [_dest,0];
_wp setWaypointType "MOVE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointCompletionRadius 40;
_wp setWaypointTimeout [0, 4, 8];

_wp = _g addWaypoint [_start,0];
_wp setWaypointType "MOVE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointCompletionRadius 10;
_wp setWaypointTimeout [20, 40, 80];

_wp = _g addWaypoint [_start,0];
_wp setWaypointType "CYCLE";
