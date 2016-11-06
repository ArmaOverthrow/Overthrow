private ["_group","_population","_posTown","_vehs","_soldier","_vehtype","_pos","_wp","_numgroups","_attackpos","_count","_tgroup","_ao"];

_objective = _this;
_posTown = getMarkerPos _objective;



_tskid = [resistance,[format["counter%1",_objective]],[format["NATO is sending forces to %1 from Tuvanaka Airbase. This is our chance to capture it if we can hold the field.",_objective],format["Capture %1",_objective],format["counter%1",_objective]],_posTown,1,2,true,"Target",true] call BIS_fnc_taskCreate;

_vehs = [];
_soldiers = [];
_groups = [];
_airgroups = [];

//Drones

{
	_group = createGroup blufor;
	_vehtype = _x;
	_pos = [getMarkerPos OT_NATO_AirSpawn,0,0,false,[0,0],[100,_vehtype]] call SHK_pos;
	_veh = createVehicle [_vehtype, _pos, [], 0,""];  	
	_veh setDir 50;
	_vehs pushback _veh;
	_group addVehicle _veh;
	_airgroups pushback _group;
	createVehicleCrew _veh;	
	{
		[_x] joinSilent _group;
	}foreach(crew _veh);
	
	_wp = _group addWaypoint [_posTown,0];
	_wp setWaypointType "SAD";
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointSpeed "FULL"; 
	
	sleep 0.1;
}foreach(OT_NATO_Vehicles_AirDrones);

{
	_x addCuratorEditableObjects [_vehs+_soldiers,true];
} forEach allCurators;
sleep 25;

_numgroups = 2;
if(_objective in OT_NATO_Priority) then {
	_numgroups = 4;
};

_count = 0;
_pos = OT_NATO_HQPos;

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

while {_count < _numgroups} do {
	_ao = [_posTown,[350,500],_attackdir + (random 90)] call SHK_pos;
	_squadtype = ["B_T_InfSquad_Weapons","B_T_InfSquad","B_T_InfSquad","B_T_InfSquad"] call BIS_fnc_SelectRandom;	
	_group = [OT_NATO_HQPos, WEST, (configFile >> "CfgGroups" >> "West" >> "BLU_T_F" >> "Infantry" >> _squadtype)] call BIS_fnc_spawnGroup;
	_count = _count + 1;
	sleep 0.2;
	
	//Transport
	_tgroup = creategroup blufor;
	_pos = [_pos,60,80,false,[0,0],[100,OT_NATO_Vehicle_AirTransport]] call SHK_pos;
	sleep 0.1;
	_veh = createVehicle [OT_NATO_Vehicle_AirTransport, _pos, [], 0,""];  		
	_vehs pushback _veh;
	
	
	_veh setDir (_dir);
	_tgroup addVehicle _veh;
	_airgroups pushback _tgroup;
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
		_x setVariable ["VCOM_NOPATHING_Unit",true,false];
	}foreach(units _group);	
	
	sleep 1;
	
	_moveto = [OT_NATO_HQPos,500,_dir] call SHK_pos;
	_wp = _tgroup addWaypoint [_moveto,0];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointSpeed "FULL";
	_wp setWaypointCompletionRadius 150;
	_wp setWaypointStatements ["true","(vehicle this) flyInHeight 150;"];
	
	_wp = _tgroup addWaypoint [_ao,0];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointStatements ["true","(vehicle this) AnimateDoor ['Door_rear_source', 1, false];"];
	wp setWaypointCompletionRadius 50;
	_wp setWaypointSpeed "FULL";
	
	_wp = _tgroup addWaypoint [_ao,0];
	_wp setWaypointType "SCRIPTED";
	_wp setWaypointStatements ["true","[vehicle this,75] execVM 'funcs\addons\eject.sqf'"];	
	_wp setWaypointTimeout [10,10,10];
	
	_wp = _tgroup addWaypoint [_ao,0];
	_wp setWaypointType "SCRIPTED";
	_wp setWaypointStatements ["true","(vehicle this) AnimateDoor ['Door_rear_source', 0, false];"];	
	_wp setWaypointTimeout [15,15,15];
	
	_moveto = [OT_NATO_HQPos,200,_dir] call SHK_pos;

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
	
	{
		_x addCuratorEditableObjects [_vehs+_soldiers,true];
	} forEach allCurators;
	sleep 20;
};

_comp = OT_NATO_Vehicle_AirTransport call ISSE_Cfg_Vehicle_GetName;
_an = "A";
if((_ao select [0,1]) in ["A","E","I","O","a","e","i","o"]) then {_an = "An"};
[3,_ao,"Known Intel",format["Intelligence reports that NATO will insert troops at this location. %1 %2 is known to be departing %3 with %4 personnel. CAS Support also incoming, composition unknown.",_an,_comp,OT_NATO_HQ,count _soldiers]] remoteExec ["intelEvent",0,false];

[_soldiers,_attackpos,_objective,_tskid,_airgroups] spawn {
	_soldiers = _this select 0;
	_attackpos = _this select 1;
	_objective = _this select 2;
	_tskid = _this select 3;
	_airgroups = _this select 4;
	
	_first = _soldiers select ((count _soldiers) - 1);
	waitUntil {(_first distance _attackpos) < 1000};
	
	private ["_size","_active","_alive"];
	_size = count _soldiers;
	_lostat = round(_size * 0.4);
	_active = true;
		
	while {_active} do {
		_alive = [];
		_inrange = [];
		{
			if(alive _x) then {
				if(_x distance _attackpos < 1200) then {
					_alive pushback _x;
				};
				if(_x distance _attackpos < 150) then {
					_inrange pushback _x;
				};
			};
		}foreach(_soldiers);
		
		if(count _alive <= _lostat) then {
			[_tskid, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
			_active = false;			
			_objective setMarkerType "flag_Tanoa";
			_o = "";
			if(_objective in OT_needsThe) then {
				_o = "The ";
			};
			_effect = "";
			if(_objective == "fuel depot") then {
				_efect = "(Vehicles are now cheaper)";
			};
			format["Resistance has captured %1%2 (+100 Influence) %3",_o,_objective,_effect] remoteExec ["notify_good",0,false];
			100 remoteExec ["influenceSilent",0,false];	
			_flag = _attackpos nearEntities[OT_flag_NATO,500];
			if(count _flag > 0) then{
				deleteVehicle (_flag select 0);
			};
		}else{
			if(((count _inrange) / (count _alive)) > 0.7) then {
				//check for any alive enemies
				_enemies = [];
				{
					if(side _x == resistance || side _x == east) then {
						_enemies pushback _x;
					};
				}foreach(_attackpos nearentities ["Man",400]);
				if((count _inrange) > (count _enemies)) then {
					//NATO has won					
					[_tskid, "FAILED",true] spawn BIS_fnc_taskSetState;
					_active = false;
					_abandoned = server getVariable "NATOabandoned";
					_abandoned deleteAt (_abandoned find _objective);
					server setVariable ["NATOabandoned",_abandoned,true];
					server setVariable [format["garrison%1",_objective],8 + random 12,true];
				};
			};
		};		
		sleep 2;
	};
	//Send any air units home
	{
		if(alive (leader _x)) then {
			_tgroup = _x;
			 while {(count (waypoints _tgroup)) > 0} do
			 {
			  deleteWaypoint ((waypoints _tgroup) select 0);
			 };

			_wp = _tgroup addWaypoint [OT_NATO_HQPos,400];
			_wp setWaypointType "MOVE";
			_wp setWaypointBehaviour "COMBAT";
			_wp setWaypointSpeed "FULL";
			_wp setWaypointCompletionRadius 400;
			
			_wp = _tgroup addWaypoint [OT_NATO_HQPos,400];
			_wp setWaypointType "SCRIPTED";
			_wp setWaypointStatements ["true","[vehicle this] execVM 'funcs\cleanup.sqf'"]; 
		};
	}foreach(_airgroups);
};

_pos = OT_NATO_HQPos;
//Air support (Heli)
{	
	_group = createGroup blufor;
	_vehtype = _x;
	_pos = [_pos,40 + random 60,50 + random 180,false,[0,0],[100,_vehtype]] call SHK_pos;
	_veh = createVehicle [_vehtype, _pos, [], 0,""];  	
	_vehs pushback _veh;
	_veh setDir 50;
	_group addVehicle _veh;
	_airgroups pushback _group;
	
	createVehicleCrew _veh;
	{
		[_x] joinSilent _group;
		_x setVariable ["garrison","HQ",false];
	}foreach(crew _veh);	
	_wp = _group addWaypoint [_posTown,50];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointSpeed "FULL"; 
	sleep 10;
}foreach(OT_NATO_Vehicles_AirSupport);

{
	_x addCuratorEditableObjects [_vehs+_soldiers,true];
} forEach allCurators;


if(_objective in OT_NATO_Priority) then {
	sleep 20; 
	//Air support (Winged)
	{	
		_group = createGroup blufor;
		_vehtype = _x;
		_pos = [getMarkerPos OT_NATO_AirSpawn,0,0,false,[0,0],[100,_vehtype]] call SHK_pos;
		_veh = createVehicle [_vehtype, _pos, [], 0,""];  	
		_vehs pushback _veh;
		_veh setDir 50;
		_group addVehicle _veh;
		_airgroups pushback _group;
		createVehicleCrew _veh;
		{
			[_x] joinSilent _group;
			_x setVariable ["garrison","HQ",false];
		}foreach(crew _veh);	
		
		{
			_x addCuratorEditableObjects [[_veh],true];
		} forEach allCurators;
		
		_wp = _group addWaypoint [_posTown,0];
		_wp setWaypointType "SAD";
		_wp setWaypointBehaviour "COMBAT";
		_wp setWaypointSpeed "FULL"; 
			
		sleep 5;
	}foreach(OT_NATO_Vehicles_AirWingedSupport);
};



