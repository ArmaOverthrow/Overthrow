params ["_frompos","_attackpos","_delay"];
sleep _delay;
private _vehtype = OT_NATO_Vehicles_AirSupport call BIS_fnc_SelectRandom;	


private _dir = [_frompos,_attackpos] call BIS_fnc_dirTo;
_pos = [_frompos,0,120,false,[0,0],[250,_vehtype]] call SHK_pos;	

_group = creategroup blufor;
_veh = createVehicle [_vehtype, _pos, [], 0,""];

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
_group call distributeAILoad;

_wp = _group addWaypoint [asltoatl _attackpos,20];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointSpeed "FULL";
_wp setWaypointTimeout [600,600,600];

_wp = _group addWaypoint [_frompos,2000];
_wp setWaypointType "SCRIPTED";
_wp setWaypointStatements ["true","[vehicle this] execVM 'funcs\cleanup.sqf'"];