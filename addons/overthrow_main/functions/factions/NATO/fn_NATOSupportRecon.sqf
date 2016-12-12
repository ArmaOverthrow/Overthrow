private _posTown = _this;

private _close = nil;
private _dist = 8000;
private _closest = "";
private _abandoned = server getVariable["NATOabandoned",[]];
private _town = _posTown call OT_fnc_nearestTown;
private _region = server getVariable format["region_%1",_town];
{
	_pos = _x select 0;
	_name = _x select 1;
	if(_pos inArea _region and !(_name in _abandoned)) then {
		_d = (_pos distance _posTown);
		if(_d < _dist) then {
			_dist = _d;
			_close = _pos;
			_closest = _name;
		};
	};
}foreach(OT_NATOobjectives);
_isHQ = false;
if(isNil "_close") then {
	_isHQ = true;
	_close = OT_NATO_HQPos;
};
_start = [_close,50,200, 1, 0, 0, 0] call BIS_fnc_findSafePos;
_group = [_start, WEST, (configFile >> "CfgGroups" >> "West" >> "BLU_T_F" >> "Infantry" >> "B_T_ReconTeam")] call BIS_fnc_spawnGroup;
_group call distributeAILoad;
sleep 0.5;

_dir = [_start,_posTown] call BIS_fnc_dirTo;

if(_isHQ) then {
	_attackpos = [_posTown,[0,150]] call SHK_pos;

	//Determine direction to attack from (preferrably away from water)
	_attackdir = random 360;
	if(surfaceIsWater ([_posTown,150,_attackDir] call BIS_fnc_relPos)) then {
		_attackdir = _attackdir + 180;
		if(_attackdir > 359) then {_attackdir = _attackdir - 359};
		if(surfaceIsWater ([_posTown,150,_attackDir] call BIS_fnc_relPos)) then {
			_attackdir = _attackdir + 90;
			if(_attackdir > 359) then {_attackdir = _attackdir - 359};
			if(surfaceIsWater ([_posTown,150,_attackDir] call BIS_fnc_relPos)) then {
				_attackdir = _attackdir + 180;
				if(_attackdir > 359) then {_attackdir = _attackdir - 359};
			};
		};
	};
	_attackdir = _attackdir - 45;
	_ao = [_posTown,[350,500],_attackdir + (random 90)] call SHK_pos;
	_tgroup = creategroup blufor;

	_spawnpos = OT_NATO_HQPos findEmptyPosition [0,100,OT_NATO_Vehicle_AirTransport_Small];
	_veh =  OT_NATO_Vehicle_AirTransport_Small createVehicle _spawnpos;
	_veh setDir _dir;
	_tgroup addVehicle _veh;

	_tgroup call distributeAILoad;

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

	_moveto = [OT_NATO_HQPos,500,_dir] call SHK_pos;
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

	_moveto = [OT_NATO_HQPos,200,_dir] call SHK_pos;

	_wp = _tgroup addWaypoint [_moveto,0];
	_wp setWaypointType "LOITER";
	_wp setWaypointBehaviour "CARELESS";
	_wp setWaypointSpeed "FULL";
	_wp setWaypointCompletionRadius 100;

	_wp = _tgroup addWaypoint [_moveto,0];
	_wp setWaypointType "SCRIPTED";
	_wp setWaypointStatements ["true","[vehicle this] spawn OT_fnc_cleanup"];

	{
		_x addCuratorEditableObjects [units _tgroup,true];
	} forEach allCurators;
}else{
	_moveto = [_start,50,_dir] call SHK_pos;
	_wp = _group addWaypoint [_moveto,5];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "SAFE";
};
{
	_x addCuratorEditableObjects [units _group,true];
} forEach allCurators;
sleep 2;

//This squad operates in stealth mode, therefore does not respond to calls for help from other units
{
	_x setVariable ["VCOM_NOPATHING_Unit",true,false];
}foreach(units _group);


_wp = _group addWaypoint [_posTown,100];
_wp setWaypointType "HOLD";
_wp setWaypointBehaviour "STEALTH";
_wp setWaypointTimeout [60,120,600];

_dest = getpos([_posTown,OT_allHouses + OT_allShops + OT_offices + OT_portBuildings] call OT_fnc_getRandomBuilding);
_wp = _group addWaypoint [_posTown,100];
_wp setWaypointType "HOLD";
_wp setWaypointBehaviour "STEALTH";
_wp setWaypointTimeout [60,120,600];

_dest = getpos([_posTown,OT_allHouses + OT_allShops + OT_offices + OT_portBuildings] call OT_fnc_getRandomBuilding);
_wp = _group addWaypoint [_posTown,100];
_wp setWaypointType "HOLD";
_wp setWaypointBehaviour "STEALTH";
_wp setWaypointTimeout [60,120,600];
