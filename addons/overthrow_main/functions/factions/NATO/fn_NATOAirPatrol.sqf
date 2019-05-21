//Scramble a helicopter to take out a target
params ["_frombase","_waypoints",["_delay",0]];

if((count _waypoints) < 2) exitWith {};

private _abandoned = server getVariable ["NATOabandoned",[]];
if !(_frombase in _abandoned) then {
    if(_delay > 0) then {sleep _delay};
    diag_log format["Overthrow: NATO Sending air patrol from %1",_frombase];

    private _vehtype = OT_NATO_Vehicles_AirSupport_Small call BIS_fnc_selectRandom;
    if((call OT_fnc_getControlledPopulation) > 1500) then {_vehtype = OT_NATO_Vehicles_AirSupport call BIS_fnc_selectRandom};

    private _frompos = server getVariable _frombase;
    private _pos = _frompos findEmptyPosition [2,100,_vehtype];
    if(isNil "_pos") exitWith {};

    private _group = creategroup blufor;
    private _veh = _vehtype createVehicle _pos;
    _veh setVariable ["garrison","HQ",false];

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
    private _attackpos = [_topos,[0,200]] call SHK_pos_fnc_pos;

    {
        _wp = _group addWaypoint [_x,50];
        _wp setWaypointType "SAD";
        _wp setWaypointBehaviour "SAFE";
        _wp setWaypointSpeed "FULL";
        _wp setWaypointTimeout [300,300,300];
    }foreach(_waypoints);

    _timeout = time + ((count _waypoints) * 300);

    waitUntil {sleep 10;!isNil "_veh" && alive _veh && time > _timeout};

    while {(count (waypoints _group)) > 0} do {
        deleteWaypoint ((waypoints _group) select 0);
    };

    sleep 1;

    if(isNil "_veh" || !alive _veh) exitWith {};

    _wp = _group addWaypoint [_frompos,50];
    _wp setWaypointType "MOVE";
    _wp setWaypointBehaviour "SAFE";
    _wp setWaypointSpeed "FULL";

    waitUntil{sleep 10;(alive _veh && (_veh distance _frompos) < 150) || !alive _veh};

    if(alive _veh) then {
        while {(count (waypoints _group)) > 0} do {
            deleteWaypoint ((waypoints _group) select 0);
        };
        _veh land "LAND";
        waitUntil{sleep 10;(getpos _veh)#2 < 2};
    };
    _veh call OT_fnc_cleanup;
    _group call OT_fnc_cleanup;
};
