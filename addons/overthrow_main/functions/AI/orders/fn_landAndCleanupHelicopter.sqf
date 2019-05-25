params ["_veh","_pos","_group"];


while {(count (waypoints _group)) > 0} do {
    deleteWaypoint ((waypoints _group) select 0);
};

_veh move _pos;

sleep 3;

while {((alive _veh) && !(unitReady _veh))} do
{
       sleep 1;
};

if(alive _veh) then {
	_veh land "LAND";
	waitUntil{sleep 10;(getpos _veh)#2 < 2};
};
_veh call OT_fnc_cleanup;
_group call OT_fnc_cleanup;
