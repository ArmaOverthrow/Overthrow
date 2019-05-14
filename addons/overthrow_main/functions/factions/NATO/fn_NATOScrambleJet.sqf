//Scramble a jet to take out a target
params ["_target","_targetpos",["_delay",0]];

private _abandoned = server getVariable ["NATOabandoned",[]];
if !(OT_NATO_HQ in _abandoned) then {
    if(_delay > 0) then {sleep _delay};
    diag_log "Overthrow: NATO Scrambling Jet";

    private _vehtype = selectRandom OT_NATO_Vehicles_AirWingedSupport;
    private _frompos = OT_NATO_JetPos;

    private _pos = _frompos findEmptyPosition [2,100,_vehtype];

    private _group = creategroup blufor;
    private _veh = _vehtype createVehicle _pos;
    _veh setVariable ["garrison","HQ",false];

    _veh setDir OT_NATO_JetDir;

    {
        _x addCuratorEditableObjects [[_veh]];
    }foreach(allCurators);

    clearWeaponCargoGlobal _veh;
    clearMagazineCargoGlobal _veh;
    clearItemCargoGlobal _veh;
    clearBackpackCargoGlobal _veh;

    _group addVehicle _veh;
    createVehicleCrew _veh;
    {
    	[_x] joinSilent _group;
    	_x setVariable ["garrison","HQ",false];
    	_x setVariable ["NOAI",true,false];
    }foreach(crew _veh);
    sleep 1;

    private _dir = [_targetpos,OT_NATO_JetPos] call BIS_fnc_dirTo;
    private _attackpos = [_targetpos,[200,500],_dir] call SHK_pos_fnc_pos;

    _wp = _group addWaypoint [_attackpos,50];
    _wp setWaypointType "SAD";
    _wp setWaypointBehaviour "COMBAT";
    _wp setWaypointSpeed "FULL";
    _wp setWaypointTimeout [500,600,700];

    _timeout = time + 600;

    waitUntil {sleep 10;alive _veh && time > _timeout};

    while {(count (waypoints _group)) > 0} do {
        deleteWaypoint ((waypoints _group) select 0);
    };

    sleep 1;

    _wp = _group addWaypoint [OT_NATO_JetLandPos,50];
    _wp setWaypointType "MOVE";
    _wp setWaypointBehaviour "SAFE";
    _wp setWaypointSpeed "FULL";

    waitUntil{sleep 10;(alive _veh && (_veh distance OT_NATO_JetLandPos) < 150) || !alive _veh};

    if(alive _veh) then {
        while {(count (waypoints _group)) > 0} do {
            deleteWaypoint ((waypoints _group) select 0);
        };
        _veh action ["LAND", _veh];
        waitUntil{sleep 10;(speed _veh) isEqualTo 0};
    };
    _veh call OT_fnc_cleanup;
    _group call OT_fnc_cleanup;
};
