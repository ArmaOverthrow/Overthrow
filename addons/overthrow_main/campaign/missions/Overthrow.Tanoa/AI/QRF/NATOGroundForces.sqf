params ["_frompos","_ao","_attackpos","_byair","_delay"];
sleep _delay;
private _squadtype = OT_NATO_GroundForces call BIS_fnc_SelectRandom;	
private _spawnpos = [_frompos,[50,75]] call SHK_pos;
private _group1 = [_spawnpos, WEST, (configFile >> "CfgGroups" >> "West" >> "BLU_T_F" >> "Infantry" >> _squadtype)] call BIS_fnc_spawnGroup;
private _group2 = "";
private _tgroup = false;
if !(_byair) then {
	_squadtype = OT_NATO_GroundForces call BIS_fnc_SelectRandom;
	_spawnpos = [_spawnpos,[0,50]] call SHK_pos;
	_group2 = [_spawnpos, WEST, (configFile >> "CfgGroups" >> "West" >> "BLU_T_F" >> "Infantry" >> _squadtype)] call BIS_fnc_spawnGroup;
};
sleep 0.1;
private _allunits = [];
private _veh = false;

if(_frompos distance _attackpos > 1200) then {
	//Transport
	_tgroup = creategroup blufor;
	_vehtype = OT_NATO_Vehicle_Transport;
	if(_byair) then {
		_vehtype = OT_NATO_Vehicle_AirTransport;	
	};
	
	private _dir = [_frompos,_ao] call BIS_fnc_dirTo;
	_pos = [_frompos,0,75,false,[0,0],[120,_vehtype]] call SHK_pos;	

	if !(_byair) then {
		_roads = (_frompos nearRoads 200);		
		if(count _roads > 0) then {
			_pos = getpos(_roads select 0);	
		};		
	};

	_veh = createVehicle [_vehtype, _pos, [], 0,""];

	_veh setDir (_dir);
	_tgroup addVehicle _veh;
	createVehicleCrew _veh;
	{
		[_x] joinSilent _tgroup;		
		_x setVariable ["garrison","HQ",false];
		_x setVariable ["NOAI",true,false];
	}foreach(crew _veh);	
	_allunits = (units _tgroup);
	sleep 1;
	
	_tgroup call distributeAILoad;
};

{
	if(typename _tgroup == "GROUP") then {
		_x moveInCargo _veh;
	};
	[_x] joinSilent _group1;	
	_allunits pushback _x;
	_x setVariable ["garrison","HQ",false];
	_x setVariable ["VCOM_NOPATHING_Unit",true,false];
}foreach(units _group1);	

if !(_byair) then {
	{
		if(typename _tgroup == "GROUP") then {
			_x moveInCargo _veh;
		};
		[_x] joinSilent _group1;	
		_x setVariable ["VCOM_NOPATHING_Unit",true,false];
		_allunits pushback _x;
		_x setVariable ["garrison","HQ",false];
	}foreach(units _group2);	
};

_group1 call distributeAILoad;

{
	_x addCuratorEditableObjects [_allunits,true];
} forEach allCurators;
sleep 1;
if(_byair and (typename _tgroup == "GROUP")) then {	
	_wp = _tgroup addWaypoint [_frompos,0];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointSpeed "FULL";
	_wp setWaypointCompletionRadius 150;
	_wp setWaypointStatements ["true",format["(vehicle this) flyInHeight %1;",75+random 50]];

	_wp = _tgroup addWaypoint [_ao,0];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointStatements ["true","(vehicle this) AnimateDoor ['Door_rear_source', 1, false];"];
	_wp setWaypointCompletionRadius 50;
	_wp setWaypointSpeed "FULL";

	_wp = _tgroup addWaypoint [_ao,0];
	_wp setWaypointType "SCRIPTED";
	_wp setWaypointStatements ["true","[vehicle this,75] execVM 'funcs\addons\eject.sqf'"];	
	_wp setWaypointTimeout [5,5,5];

	_wp = _tgroup addWaypoint [_ao,0];
	_wp setWaypointType "SCRIPTED";
	_wp setWaypointStatements ["true","(vehicle this) AnimateDoor ['Door_rear_source', 0, false];"];	
	_wp setWaypointTimeout [40,40,40];

	
	_wp = _tgroup addWaypoint [_frompos,2000];
	_wp setWaypointType "LOITER";
	_wp setWaypointBehaviour "CARELESS";
	_wp setWaypointSpeed "FULL";	
	_wp setWaypointCompletionRadius 2000;

	_wp = _tgroup addWaypoint [_frompos,2000];
	_wp setWaypointType "SCRIPTED";
	_wp setWaypointStatements ["true","[vehicle this] execVM 'funcs\cleanup.sqf'"]; 
}else{
	if(typename _tgroup == "GROUP") then {
		_veh setdamage 0;
		_roads = (_attackpos nearRoads 500);
		private _dropos = _ao;
		if(count _roads > 0) then {
			_dropos = getpos(_roads select (count _roads - 1));
		};
		_move = _tgroup addWaypoint [_dropos,0];
		_move setWaypointTimeout [30,30,30];
		_move setWaypointType "TR UNLOAD";	
		
		_wp = _tgroup addWaypoint [_frompos,0];
		_wp setWaypointType "MOVE";
		_wp setWaypointSpeed "LIMITED";	
		_wp setWaypointCompletionRadius 25;
		
		_wp = _tgroup addWaypoint [_frompos,0];
		_wp setWaypointType "SCRIPTED";
		_wp setWaypointStatements ["true","[vehicle this] execVM 'funcs\cleanup.sqf'"];
	};
};
sleep 10;
_wp = _group1 addWaypoint [asltoatl _attackpos,20];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointSpeed "FULL";

_wp = _group1 addWaypoint [asltoatl _attackpos,0];
_wp setWaypointType "GUARD";
_wp setWaypointBehaviour "COMBAT";