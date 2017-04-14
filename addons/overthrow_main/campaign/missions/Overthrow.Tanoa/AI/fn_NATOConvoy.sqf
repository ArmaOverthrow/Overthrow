params ["_vehtypes","_hvts","_from","_to"];


private _frompos = server getvariable _from;
private _fromregion = _frompos call OT_fnc_getRegion;
private _topos = server getvariable _to;

private _dir = [_frompos,_topos] call BIS_fnc_dirTo;

private _group = creategroup blufor;
private _track = objNull;

if ([_topos,_fromregion] call OT_fnc_regionIsConnected) then {
    _convoypos = _frompos;
    {
        _pos = [_convoypos,0,120,false,[0,0],[250,_x]] call SHK_pos;
        _veh = createVehicle [_x, _pos, [], 0,""];
    	_veh setVariable ["garrison","HQ",false];

    	_veh setDir (_dir);
    	_group addVehicle _veh;
    	createVehicleCrew _veh;
    	{
    		[_x] joinSilent _group;
    		_x setVariable ["garrison","HQ",false];
            _x setVariable ["NOAI",true,false];
            _x disableAI "AUTOCOMBAT";
    	}foreach(crew _veh);
        _convoypos = [_convoypos,20,-_dir] call BIS_fnc_relPos;
    	sleep 0.1;
    }foreach(_vehtypes);

    {
        _pos = [_convoypos,0,120,false,[0,0],[250,OT_NATO_Vehicle_HVT]] call SHK_pos;
        _veh = createVehicle [OT_NATO_Vehicle_HVT, _pos, [], 0,""];
    	_veh setVariable ["garrison","HQ",false];

    	_veh setDir (_dir);
    	_group addVehicle _veh;
    	createVehicleCrew _veh;
    	{
    		[_x] joinSilent _group;
    		_x setVariable ["garrison","HQ",false];
            _x setVariable ["NOAI",true,false];
            _x disableAI "AUTOCOMBAT";
    	}foreach(crew _veh);

        _lead = leader _veh;
        _lead setVariable ["hvt",true,true];
        _lead setVariable ["hvt_id",_x select 0,true];
        _lead setRank "COLONEL";
        if(isNull _track) then {_track = _lead};

        _convoypos = [_convoypos,20,-_dir] call BIS_fnc_relPos;

    	sleep 0.1;
        _x set [2,"CONVOY"];
    }foreach(_hvts);

    private _numsupport = 2;

    private _count = 0;
    while {_count < _numsupport} do {
        _vehtype = selectRandom OT_NATO_Vehicles_GroundSupport;
        _pos = [_convoypos,0,120,false,[0,0],[250,_vehtype]] call SHK_pos;
        _veh = createVehicle [_vehtype, _pos, [], 0,""];
    	_veh setVariable ["garrison","HQ",false];

    	_veh setDir (_dir);
    	_group addVehicle _veh;
    	createVehicleCrew _veh;
    	{
    		[_x] joinSilent _group;
    		_x setVariable ["garrison","HQ",false];
            _x setVariable ["NOAI",true,false];
            _x disableAI "AUTOCOMBAT";
    	}foreach(crew _veh);
        _convoypos = [_convoypos,20,-_dir] call BIS_fnc_relPos;
        _count = _count + 1;
        sleep 0.1;
    };
    sleep 5;
    _wp = _group addWaypoint [asltoatl _topos,50];
    _wp setWaypointType "MOVE";
    _wp setWaypointBehaviour "SAFE";
    _wp setWaypointSpeed "LIMITED";
    _wp setWaypointTimeout [60,60,60];

    _wp = _group addWaypoint [_topos,500];
    _wp setWaypointType "SCRIPTED";
    _wp setWaypointStatements ["true","[group this] spawn OT_fnc_cleanup"];
};
_group call distributeAILoad;

if(isNull _track) exitWith {};
waitUntil {(_track distance _topos) < 100 or !alive _track};

if(alive _track) then {
    {
        _x set [2,""];
        _x set [1,_to];
    }foreach(_hvts);
};
