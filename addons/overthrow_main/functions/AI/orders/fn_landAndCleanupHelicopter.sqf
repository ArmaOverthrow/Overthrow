params ["_veh","_pos"];


while {(count (waypoints _group)) > 0} do {
    deleteWaypoint ((waypoints _group) select 0);
};

_veh move _pos;

sleep 3;

while {((alive _veh) && !(unitReady _veh))} do
{
       sleep 3;
};

if(alive _veh) then {
	_veh land "LAND";
	waitUntil{sleep 10;unitReady _veh};
    [_veh,true] call OT_fnc_cleanup;
};
