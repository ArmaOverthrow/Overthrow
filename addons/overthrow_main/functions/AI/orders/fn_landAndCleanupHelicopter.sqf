params ["_veh","_pos","_group"];


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
	[_veh,true] call OT_fnc_cleanup;
};

[_group,true] call OT_fnc_cleanup;
