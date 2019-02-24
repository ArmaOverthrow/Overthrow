params ["_target","_destpos"];
_txt = "";
_radius = 5;
if(count _this > 2) then {
    _txt = _this select 2;
};
if(count _this > 3) then {
    _radius = _this select 3;
};

while {(count (waypoints group _target)) > 0} do {
    deleteWaypoint ((waypoints group _target) select 0);
};
private _wp = (group _target) addWaypoint [position player, 0];
private _wp = (group player) addWaypoint [_destpos, 15];
OT_missionMarker = _destpos;
OT_missionMarkerText = _txt;

[_target,_radius,_wp] spawn {
    params ["_target","_radius","_wp"];
    while {!isNil "_wp" && (player distance waypointPosition _wp) > _radius} do {};
    if(!isNil "_wp") then {
        while {(count (waypoints group _target)) > 0} do {
            deleteWaypoint ((waypoints group _target) select 0);
        };
        OT_missionMarker = nil;
    };
};

_wp;
