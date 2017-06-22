params ["_frompos","_attackpos","_strength","_delay"];
sleep _delay;

private _num = 1+floor(_strength / 200);

private _count = 0;

private _group = creategroup blufor;

while {_count < _num} do {
	private _vehtype = OT_NATO_Vehicles_GroundSupport call BIS_fnc_SelectRandom;

	private _dir = [_frompos,_attackpos] call BIS_fnc_dirTo;
	_pos = [_frompos,0,120,false,[0,0],[250,_vehtype]] call SHK_pos;


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
	_count = _count + 1;
	sleep 0.2;
};

_wp = _group addWaypoint [_attackpos,20];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "CARELESS";

_wp = _group addWaypoint [_attackpos,20];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointTimeout [600,600,600];

_wp = _group addWaypoint [_frompos,500];
_wp setWaypointType "SCRIPTED";
_wp setWaypointStatements ["true","[vehicle this] spawn OT_fnc_cleanup"];


