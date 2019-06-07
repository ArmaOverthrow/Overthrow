params ["_frompos","_attackpos",["_delay",0]];
if (_delay > 0) then {sleep _delay};
private _vehtype = OT_NATO_Vehicles_AirSupport call BIS_fnc_SelectRandom;


private _dir = _frompos getDir _attackpos;
//look for a helipad
private _helipads = (_frompos nearObjects ["Land_HelipadCircle_F", 400]) + (_frompos nearObjects ["Land_HelipadSquare_F", 400]);
private _pos = false;
{
	//check if theres anything on it
	private _on = ASLToAGL getPosASL _x nearEntities ["Air",15];
	if((count _on) isEqualTo 0) exitWith {_pos = getPosASL _x;_dir = getDir _x};
}foreach(_helipads);

if !(_pos isEqualType []) then {
	_pos = [_frompos,0,120,false,[0,0],[250,_vehtype]] call SHK_pos_fnc_pos;
};

private _group = creategroup blufor;
private _veh = createVehicle [_vehtype, _pos, [], 0,""];
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

_wp = _group addWaypoint [_topos,600];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointSpeed "FULL";
_wp setWaypointTimeout [30,30,30];

_topos = [_attackpos,[0,200]] call SHK_pos_fnc_pos;

_wp = _group addWaypoint [_topos,600];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointSpeed "FULL";
_wp setWaypointTimeout [30,30,30];

_topos = [_attackpos,[0,200]] call SHK_pos_fnc_pos;

_wp = _group addWaypoint [_topos,600];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointSpeed "FULL";
_wp setWaypointTimeout [30,30,30];

_topos = [_attackpos,[0,200]] call SHK_pos_fnc_pos;

_wp = _group addWaypoint [_topos,600];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointSpeed "FULL";
_wp setWaypointTimeout [30,30,30];

_topos = [_attackpos,[0,200]] call SHK_pos_fnc_pos;

_wp = _group addWaypoint [_topos,600];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointSpeed "FULL";
_wp setWaypointTimeout [30,30,30];

_topos = [_attackpos,[0,200]] call SHK_pos_fnc_pos;

_wp = _group addWaypoint [_topos,0];
_wp setWaypointType "CYCLE";

private _timeout = time + 1800;

waitUntil {sleep 10;alive _veh && time > _timeout};

while {(count (waypoints _group)) > 0} do {
	deleteWaypoint ((waypoints _group) select 0);
};

[_veh,_pos,_group] spawn OT_fnc_landAndCleanupHelicopter;
