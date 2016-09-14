private ["_group","_population","_posTown","_vehs","_soldier","_vehtype","_pos","_wp","_numgroups","_attackpos","_count","_tgroup","_ao"];

_posTown = _this;

_vehs = [];
_soldiers = [];
_groups = [];

_count = 0;
_pos = AIT_NATO_HQPos;

_dir = [_pos,_posTown] call BIS_fnc_dirTo;

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
_group = createGroup blufor;


{
	_type = _x;
	_civ = _group createUnit [_type, AIT_NATO_HQPos, [],0, "NONE"];
	_civ setRank "CAPTAIN";	
}foreach(AIT_NATO_Units_CTRGSupport);

sleep 0.2;

//Transport
_tgroup = creategroup blufor;
_pos = [_pos,60,80,false,[0,0],[100,AIT_NATO_Vehicle_CTRGTransport]] call SHK_pos;
sleep 0.1;
_veh = createVehicle [AIT_NATO_Vehicle_CTRGTransport, _pos, [], 0,""];  		
_vehs pushback _veh;


_veh setDir (_dir);
_tgroup addVehicle _veh;
createVehicleCrew _veh;
{
	[_x] joinSilent _tgroup;
	_x setVariable ["NOAI",true,false];
	_x setVariable ["garrison","HQ",false];
}foreach(crew _veh);	

{
	_x moveInCargo _veh;
	_soldiers pushback _x;
	_x setVariable ["garrison","HQ",false];
}foreach(units _group);	

sleep 1;

_moveto = [AIT_NATO_HQPos,500,_dir] call SHK_pos;
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
wp setWaypointCompletionRadius 50;
_wp setWaypointSpeed "FULL";

_wp = _tgroup addWaypoint [_ao,0];
_wp setWaypointType "SCRIPTED";
_wp setWaypointStatements ["true","[vehicle this,50] execVM 'funcs\addons\eject.sqf'"];	
_wp setWaypointTimeout [10,10,10];

_wp = _tgroup addWaypoint [_ao,0];
_wp setWaypointType "SCRIPTED";
_wp setWaypointStatements ["true","(vehicle this) AnimateDoor ['Door_rear_source', 0, false];"];	
_wp setWaypointTimeout [15,15,15];

_moveto = [AIT_NATO_HQPos,200,_dir] call SHK_pos;

_wp = _tgroup addWaypoint [_moveto,0];
_wp setWaypointType "LOITER";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "FULL";	
_wp setWaypointCompletionRadius 100;

_wp = _tgroup addWaypoint [_moveto,0];
_wp setWaypointType "SCRIPTED";
_wp setWaypointStatements ["true","[vehicle this] execVM 'funcs\cleanup.sqf'"]; 

_wp = _group addWaypoint [_attackpos,20];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "COMBAT";

_wp = _group addWaypoint [_attackpos,0];
_wp setWaypointType "GUARD";
_wp setWaypointBehaviour "COMBAT";

_comp = AIT_NATO_Vehicle_CTRGTransport call ISSE_Cfg_Vehicle_GetName;
_an = "A";
if((_ao select [0,1]) in ["A","E","I","O","a","e","i","o"]) then {_an = "An"};
[5,_ao,format["%1 Reinforcements",_town],format["NATO has dispatched a CTRG support team to this location. Reports indicate that %1 %2 is departing %3 as we speak.",_an,_comp,AIT_NATO_HQ]] remoteExec ["intelEvent",0,false];

{
	_x addCuratorEditableObjects [_vehs+_soldiers,true];
} forEach allCurators;


