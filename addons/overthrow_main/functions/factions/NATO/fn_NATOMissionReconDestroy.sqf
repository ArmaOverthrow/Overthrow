params ["_knownPos"];

private _posTarget = _knownPos;
private _close = nil;
private _dist = 2000;
private _closest = "";
private _abandoned = server getVariable["NATOabandoned",[]];
{
	_pos = _x select 0;
	_name = _x select 1;
	if(([_pos,_knownPos] call OT_fnc_regionIsConnected) && !(_name in _abandoned)) then {
		_d = (_pos distance _knownPos);
		if(_d < _dist) then {
			_dist = _d;
			_close = _pos;
			_closest = _name;
		};
	};
}foreach(OT_NATOobjectives);
_isAir = false;
if(isNil "_close") then {
	_isAir = true;
	{
		_x params ["_obpos","_name","_pri"];
		if !(_name in _abandoned) exitWith {
			_close = _obpos;
		};
	}foreach([OT_airportData,[],{random 100},"ASCEND"] call BIS_fnc_SortBy);
};
_start = [_close,50,200, 1, 0, 0, 0] call BIS_fnc_findSafePos;
_group = [_start, WEST, (configFile >> "CfgGroups" >> "West" >> OT_faction_NATO >> "Infantry" >> OT_NATO_Group_Recon)] call BIS_fnc_spawnGroup;

sleep 0.5;

_dir = [_start,_posTarget] call BIS_fnc_dirTo;

if(_isAir) then {
	_attackpos = [_posTarget,[0,150]] call SHK_pos_fnc_pos;

	//Determine direction to attack from (preferrably away from water)
	_attackdir = random 360;
	if(surfaceIsWater ([_posTarget,150,_attackDir] call BIS_fnc_relPos)) then {
		_attackdir = _attackdir + 180;
		if(_attackdir > 359) then {_attackdir = _attackdir - 359};
		if(surfaceIsWater ([_posTarget,150,_attackDir] call BIS_fnc_relPos)) then {
			_attackdir = _attackdir + 90;
			if(_attackdir > 359) then {_attackdir = _attackdir - 359};
			if(surfaceIsWater ([_posTarget,150,_attackDir] call BIS_fnc_relPos)) then {
				_attackdir = _attackdir + 180;
				if(_attackdir > 359) then {_attackdir = _attackdir - 359};
			};
		};
	};
	_attackdir = _attackdir - 45;
	_ao = [_posTarget,[350,500],_attackdir + (random 90)] call SHK_pos_fnc_pos;
	_tgroup = creategroup blufor;

	_spawnpos = _close findEmptyPosition [5,100,OT_NATO_Vehicle_AirTransport_Small];
	_veh =  OT_NATO_Vehicle_AirTransport_Small createVehicle _spawnpos;
	_veh setDir _dir;
	_tgroup addVehicle _veh;



	createVehicleCrew _veh;
	{
		[_x] joinSilent _tgroup;
		_x setVariable ["garrison","HQ",false];
		_x setVariable ["NOAI",true,false];
	}foreach(crew _veh);

	{
		_x moveInCargo _veh;
		_x setVariable ["garrison","HQ",false];
	}foreach(units _group);

	sleep 2;

	_moveto = [_close,500,_dir] call SHK_pos_fnc_pos;
	_wp = _tgroup addWaypoint [_moveto,0];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointSpeed "FULL";
	_wp setWaypointCompletionRadius 150;
	_wp setWaypointStatements ["true","(vehicle this) flyInHeight 100;"];

	_wp = _tgroup addWaypoint [_ao,0];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointStatements ["true","(vehicle this) AnimateDoor ['Door_rear_source', 1, false];"];
	_wp setWaypointCompletionRadius 50;
	_wp setWaypointSpeed "FULL";

	_wp = _tgroup addWaypoint [_ao,0];
	_wp setWaypointType "SCRIPTED";
	_wp setWaypointStatements ["true","[vehicle this,75] spawn OT_fnc_parachuteAll"];
	_wp setWaypointTimeout [10,10,10];

	_wp = _tgroup addWaypoint [_ao,0];
	_wp setWaypointType "SCRIPTED";
	_wp setWaypointStatements ["true","(vehicle this) AnimateDoor ['Door_rear_source', 0, false];"];
	_wp setWaypointTimeout [15,15,15];

	_moveto = [_close,200,_dir] call SHK_pos_fnc_pos;

	_wp = _tgroup addWaypoint [_moveto,0];
	_wp setWaypointType "LOITER";
	_wp setWaypointBehaviour "CARELESS";
	_wp setWaypointSpeed "FULL";
	_wp setWaypointCompletionRadius 100;

	_wp = _tgroup addWaypoint [_moveto,0];
	_wp setWaypointType "SCRIPTED";
	_wp setWaypointStatements ["true","[vehicle this] call OT_fnc_cleanup"];

	{
		_x addCuratorEditableObjects [units _tgroup,true];
	} forEach allCurators;
};
{
	_x addCuratorEditableObjects [units _group,true];
} forEach allCurators;
sleep 2;

//This squad operates in stealth mode, therefore does not respond to calls for help from other units
{
	_x setVariable ["VCOM_NOPATHING_Unit",true,false];
	_x setVariable ["OT_targetPos",_knownPos,true];
}foreach(units _group);

_wp = _group addWaypoint [_posTarget,0];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointSpeed "FULL";
_wp setWaypointStatements ["true","this spawn OT_fnc_NATOSetExplosives"];
