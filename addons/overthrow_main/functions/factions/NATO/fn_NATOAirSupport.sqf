params ["_frompos","_attackpos",["_delay",0]];
if (_delay > 0) then {sleep _delay};
private _vehtype = OT_NATO_Vehicles_AirSupport call BIS_fnc_SelectRandom;


private _dir = [_frompos,_attackpos] call BIS_fnc_dirTo;
_pos = [_frompos,0,120,false,[0,0],[250,_vehtype]] call SHK_pos_fnc_pos;

_group = creategroup blufor;
_veh = createVehicle [_vehtype, _pos, [], 0,""];
_veh setVariable ["garrison","HQ",false];

clearWeaponCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
clearItemCargoGlobal _veh;
clearBackpackCargoGlobal _veh;

_veh setDir (_dir);
_group addVehicle _veh;
createVehicleCrew _veh;
{
	[_x] joinSilent _group;
	_x setVariable ["garrison","HQ",false];
	_x setVariable ["NOAI",true,false];
}foreach(crew _veh);
_allunits = (units _group);
sleep 1;

{
	_x addCuratorEditableObjects [[_veh]];
}foreach(allCurators);

_topos = [_attackpos,[0,200]] call SHK_pos_fnc_pos;

_wp = _group addWaypoint [_topos,50];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointSpeed "FULL";
_wp setWaypointTimeout [300,300,300];

_topos = [_attackpos,[0,200]] call SHK_pos_fnc_pos;

_wp = _group addWaypoint [_topos,50];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointSpeed "FULL";
_wp setWaypointTimeout [300,300,300];

_topos = [_attackpos,[0,200]] call SHK_pos_fnc_pos;

_wp = _group addWaypoint [_topos,50];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointSpeed "FULL";
_wp setWaypointTimeout [300,300,300];

_topos = [_attackpos,[0,200]] call SHK_pos_fnc_pos;

_wp = _group addWaypoint [_topos,50];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointSpeed "FULL";
_wp setWaypointTimeout [300,300,300];

_topos = [_attackpos,[0,200]] call SHK_pos_fnc_pos;

_wp = _group addWaypoint [_topos,50];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointSpeed "FULL";
_wp setWaypointTimeout [300,300,300];

_topos = [_attackpos,[0,200]] call SHK_pos_fnc_pos;

_wp = _group addWaypoint [_topos,50];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointSpeed "FULL";
_wp setWaypointTimeout [300,300,300];

_timeout = time + 1800;

waitUntil {sleep 10;alive _veh && time > _timeout};

while {(count (waypoints _group)) > 0} do {
	deleteWaypoint ((waypoints _group) select 0);
};

sleep 1;

_wp = _group addWaypoint [_frompos,50];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "FULL";

waitUntil{sleep 10;(alive _veh && (_veh distance _frompos) < 150) || !alive _veh};

if(alive _veh) then {
	while {(count (waypoints _group)) > 0} do {
		deleteWaypoint ((waypoints _group) select 0);
	};
	_veh action ["LAND", _veh];
	waitUntil{sleep 10;(speed _veh) isEqualTo 0};
};
_veh call OT_fnc_cleanup;
_group call OT_fnc_cleanup;
