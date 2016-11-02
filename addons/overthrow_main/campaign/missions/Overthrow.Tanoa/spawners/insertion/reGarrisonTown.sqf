private _town = _this;
private _townPos = server getVariable _town;

private _stability = server getVariable format["stability%1",_town];
private _region = server getVariable format["region_%1",_town];

private _police = [];
private _support = [];

private _close = nil;
private _dist = 8000;
private _closest = "";
private _abandoned = server getVariable["NATOabandoned",[]];
{
	_pos = _x select 0;
	_name = _x select 1;
	if([_pos,_region] call fnc_isInMarker and !(_name in _abandoned)) then {
		_d = (_pos distance _townPos);
		if(_d < _dist) then {
			_dist = _d;
			_close = _pos;
			_closest = _name;
		};
	};
}foreach(OT_NATOobjectives);

if(!isNil "_close") then {
	_start = [_close,0,200, 1, 0, 0, 0] call BIS_fnc_findSafePos;
	_group = creategroup blufor;
	_tgroup = creategroup blufor;

	_spawnpos = _start findEmptyPosition [0,100,OT_NATO_Vehicle_Police];
	_veh =  OT_NATO_Vehicle_Police createVehicle _spawnpos;
	_veh setDir 180;
	_tgroup addVehicle _veh;
	
	createVehicleCrew _veh;
	{
		[_x] joinSilent _tgroup;		
		_x setVariable ["garrison","HQ",false];
	}foreach(crew _veh);	
	
	_police pushBack _veh;
	
	_civ = _group createUnit [OT_NATO_Unit_PoliceCommander, _start, [],0, "NONE"];
	_police pushBack _civ;
	_civ moveInCargo _veh;
	[_civ,_town] call initGendarm;
	_civ setBehaviour "SAFE";
	sleep 0.01;
	_start = [_start, 0, 20, 1, 0, 0, 0] call BIS_fnc_findSafePos;
	_civ = _group createUnit [OT_NATO_Unit_Police, _start, [],0, "NONE"];
	
	_police pushBack _civ;
	[_civ,_town] call initGendarm;
	_civ setBehaviour "SAFE";
	_civ moveInCargo _veh;
	
	_group setVariable ["veh",_veh];
	_group setVariable ["transport",_police];	
	sleep 5;
	
	_drop = (([_townPos, 50, 350, 1, 0, 0, 0] call BIS_fnc_findSafePos) nearRoads 200) select 0;	

	_move = _tgroup addWaypoint [_drop,0];
	_move setWaypointType "MOVE";
	_move setWaypointSpeed "FULL";	
	
	_move = _tgroup addWaypoint [_drop,0];
	_move setWaypointType "TR UNLOAD";	
	
	_wp = _tgroup addWaypoint [_spawnpos,0];
	_wp setWaypointType "MOVE";
	_wp setWaypointSpeed "LIMITED";	
	_wp setWaypointCompletionRadius 25;
	
	_wp = _tgroup addWaypoint [_spawnpos,0];
	_wp setWaypointType "SCRIPTED";
	_wp setWaypointStatements ["true","[vehicle this] execVM 'funcs\cleanup.sqf'"];

	_group call initGendarmPatrol;
	
	{
		_x addCuratorEditableObjects [_police+_support,true];
	} forEach allCurators;
	
	[3,_townPos,format["%1 Reinforcements",_town],format["Intelligence reports that NATO is reinforcing the garrison in %1. %2 personnel were spotted departing %3 in an offroad.",_town,2,_closest]] remoteExec ["intelEvent",0,false];
};



_police+_support;