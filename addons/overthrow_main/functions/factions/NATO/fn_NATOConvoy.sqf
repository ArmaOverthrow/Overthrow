params ["_vehtypes","_hvts","_from","_to",["_missionid","CONVOY"]];

private _abandoned = server getvariable ["NATOabandoned",[]];
if(_from in _abandoned) exitWith {};

private _frompos = server getvariable _from;
private _fromregion = _frompos call OT_fnc_getRegion;
private _topos = server getvariable _to;

private _dir = [_frompos,_topos] call BIS_fnc_dirTo;

private _group = creategroup blufor;
spawner setVariable [format["spawn%1",_missionid],_group,false];
_group setFormation "COLUMN";
private _track = objNull;

if ([_topos,_fromregion] call OT_fnc_regionIsConnected) then {
    _convoypos = [_frompos,random 360,120] call SHK_pos_fnc_pos;
    private _road = [_convoypos] call BIS_fnc_nearestRoad;
    if (!isNull _road) then {
        _roadscon = roadsConnectedto _road;
        if (count _roadscon isEqualTo 2) then {
            _posVeh = (getpos _road) findEmptyPosition [5,25,_vehtypes select 0];
            if(count _posVeh > 0) then {
                _convoypos = _posVeh;
                _dir = [_road, _roadscon select 0] call BIS_fnc_DirTo;
            };
        };
    };
    {
        _pos = _convoypos;
        _veh = createVehicle [_x, _pos, [], 0,""];
    	_veh setVariable ["garrison","HQ",false];

    	_veh setDir (_dir);
    	_group addVehicle _veh;
    	createVehicleCrew _veh;
        _driver = driver _veh;
        _driver disableAI "AUTOCOMBAT";
        _veh setConvoySeparation 20;
    	{
    		[_x] joinSilent _group;
    		_x setVariable ["garrison","HQ",false];
    	}foreach(crew _veh);
        _driver assignAsCommander _veh;
        _convoypos = [_convoypos,20,_dir+180] call BIS_fnc_relPos;
        {
            _x addCuratorEditableObjects [[_veh]];
        }foreach(allCurators);
    	sleep 0.3;
    }foreach(_vehtypes);

    {
        _pos = [_convoypos,0,120,false,[0,0],[250,OT_NATO_Vehicle_HVT]] call SHK_pos_fnc_pos;
        _veh = createVehicle [OT_NATO_Vehicle_HVT, _pos, [], 0,""];
    	_veh setVariable ["garrison","HQ",false];

    	_veh setDir (_dir);
    	_group addVehicle _veh;
    	createVehicleCrew _veh;

        _driver = driver _veh;
        _driver disableAI "AUTOCOMBAT";
        _veh setConvoySeparation 20;
    	{
    		[_x] joinSilent _group;
    		_x setVariable ["garrison","HQ",false];
    	}foreach(crew _veh);
        _driver assignAsCommander _veh;
        _driver setVariable ["hvt",true,true];
        _driver setVariable ["hvt_id",_x select 0,true];
        _driver setRank "COLONEL";
        if(isNull _track) then {_track = _driver};

        _convoypos = [_convoypos,20,_dir] call BIS_fnc_relPos;

    	sleep 0.3;
        _x set [2,"CONVOY"];
    }foreach(_hvts);

    private _numsupport = 2;

    if(count _hvts > 0) then {
        private _count = 0;
        while {_count < _numsupport} do {
            _vehtype = selectRandom OT_NATO_Vehicles_GroundSupport;
            _pos = [_convoypos,0,120,false,[0,0],[250,_vehtype]] call SHK_pos_fnc_pos;
            _veh = createVehicle [_vehtype, _pos, [], 0,""];
        	_veh setVariable ["garrison","HQ",false];
        	_veh setDir (_dir);
        	_group addVehicle _veh;
        	createVehicleCrew _veh;
            _driver = driver _veh;
            _driver disableAI "AUTOCOMBAT";
            _veh setConvoySeparation 20;
        	{
        		[_x] joinSilent _group;
        		_x setVariable ["garrison","HQ",false];
        	}foreach(crew _veh);
            _driver assignAsCommander _veh;
            _convoypos = [_convoypos,20,-_dir] call BIS_fnc_relPos;
            _count = _count + 1;
            sleep 0.3;
        };
    };
    sleep 5;
    _wp = _group addWaypoint [asltoatl _topos,50];
    _wp setWaypointType "MOVE";
    _wp setWaypointFormation "COLUMN";
    _wp setWaypointBehaviour "SAFE";
    _wp setWaypointSpeed "LIMITED";
    _wp setWaypointCompletionRadius 50;
    _wp setWaypointTimeout [60,60,60];

    _wp = _group addWaypoint [_topos,500];
    _wp setWaypointType "SCRIPTED";
    _wp setWaypointStatements ["true","[group this] call OT_fnc_cleanup"];
};


if(isNull _track) exitWith {};
waitUntil {(_track distance _topos) < 100 || !alive _track};

if(alive _track) then {
    {
        _x set [2,""];
        _x set [1,_to];
    }foreach(_hvts);
};
