OT_missionMarker = nil;
while {(count (waypoints group player)) > 0} do {
    deleteWaypoint ((waypoints group player) select 0);
};
