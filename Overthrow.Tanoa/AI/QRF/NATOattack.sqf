private ["_group","_population","_posTown","_vehs","_soldier","_vehtype","_pos","_wp","_numgroups","_attackpos","_count","_tgroup","_ao"];

_town = _this;

_population = server getVariable format["population%1",_town];
_posTown = server getVariable _town;

_mSize = 350;
if(_town in AIT_capitals) then {
	_mSize = 700;
};

_tskid = [resistance,[format["assault%1",_town]],[format["NATO is assaulting %1 from Tuvanaka Airbase.",_town],format["Battle of %1",_town],format["assault%1",_town]],_posTown,1,2,true,"Defend",true] call BIS_fnc_taskCreate;

_vehs = [];
_soldiers = [];
_groups = [];

//Drones
if(_population > 50) then {
	{
		_group = createGroup blufor;
		_vehtype = _x;
		_pos = [getMarkerPos AIT_NATO_AirSpawn,0,0,false,[0,0],[100,_vehtype]] call SHK_pos;
		_veh = createVehicle [_vehtype, _pos, [], 0,""];  	
		_veh setDir 50;
		_vehs pushback _veh;
		_group addVehicle _veh;
		createVehicleCrew _veh;	
		{
			[_x] joinSilent _group;
		}foreach(crew _veh);
		
		_wp = _group addWaypoint [_posTown,0];
		_wp setWaypointType "SAD";
		_wp setWaypointBehaviour "COMBAT";
		_wp setWaypointSpeed "FULL"; 
		
		sleep 0.1;
	}foreach(AIT_NATO_Vehicles_AirDrones);

	{
		_x addCuratorEditableObjects [_vehs+_soldiers,true];
	} forEach allCurators;
	sleep 35;
};

_numgroups = 1+floor(_population / 100);
if(_numgroups > 3) then {_numgroups = 3};

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

//Transport
_tgroup = creategroup blufor;
_pos = [getMarkerPos AIT_NATO_AirSpawn,0,0,false,[0,0],[100,AIT_NATO_Vehicle_AirTransport_Large]] call SHK_pos;
sleep 0.1;

_veh = createVehicle [AIT_NATO_Vehicle_AirTransport_Large, _pos, [], 0,""];  		
_vehs pushback _veh;

_veh setDir (50);

_tgroup addVehicle _veh;
createVehicleCrew _veh;
{
	_x setVariable ["NOAI",true,false];
	[_x] joinSilent _tgroup;		
	_x setVariable ["garrison","HQ",false];
	_x disableAI "AUTOCOMBAT";
}foreach(crew _veh);	

while {_count < _numgroups} do {
	_ao = [_posTown,[350,500],_attackdir + (random 90)] call SHK_pos;
	_group = [AIT_NATO_HQPos, blufor, (configFile >> "CfgGroups" >> "West" >> "BLU_T_F" >> "Infantry" >> "B_T_InfSquad_Weapons")] call BIS_fnc_spawnGroup;
	_count = _count + 1;
	sleep 0.2;
		
	{
		_x moveInCargo _veh;
		_soldiers pushback _x;
		_x setVariable ["garrison","HQ",false];
	}foreach(units _group);	
	
	sleep 1;
	
	_wp = _group addWaypoint [_attackpos,20];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "COMBAT";

	_wp = _group addWaypoint [_attackpos,0];
	_wp setWaypointType "GUARD";
	_wp setWaypointBehaviour "COMBAT";
	
	{
		_x addCuratorEditableObjects [_vehs+_soldiers,true];
	} forEach allCurators;
};

_moveto = [getMarkerPos AIT_NATO_AirSpawn,2500,50] call BIS_fnc_relPos;

_wp = _tgroup addWaypoint [_moveto,0];
_wp setWaypointType "MOVE";
_wp setWaypointStatements ["true","(vehicle this) flyInHeight 500;"];
_wp setWaypointCompletionRadius 350;

_moveto = [getMarkerPos AIT_NATO_AirSpawn,5500,90] call BIS_fnc_relPos;

_wp = _tgroup addWaypoint [_moveto,0];
_wp setWaypointType "MOVE";
_wp setWaypointCompletionRadius 550;
_wp setWaypointSpeed "FULL";

_flydir = [_moveto,_ao] call BIS_fnc_dirTo;
_moveto = [_ao,3000,_flydir - 180] call BIS_fnc_relPos;

_wp = _tgroup addWaypoint [_moveto,0];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "CARELESS";
_wp setWaypointCompletionRadius 350;

_moveto = [_ao,200,_flydir - 180] call BIS_fnc_relPos;

_wp = _tgroup addWaypoint [_moveto,0];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "CARELESS";
_wp setWaypointStatements ["true","(vehicle this) AnimateDoor ['Door_rear_source', 1, false];(vehicle this) forceSpeed 65;"];
_wp setWaypointCompletionRadius 350;
_wp setWaypointSpeed "LIMITED";

_moveto = [_ao,5000,_flydir] call BIS_fnc_relPos;
_wp = _tgroup addWaypoint [_moveto,0];
_wp setWaypointType "SCRIPTED";
_wp setWaypointStatements ["true","[vehicle this,75] execVM 'funcs\addons\eject.sqf';"];	
_wp setWaypointCompletionRadius 125;
_wp setWaypointSpeed "LIMITED";

_moveto = [_moveto,4000,270] call BIS_fnc_relPos;
_wp = _tgroup addWaypoint [_moveto,0];
_wp setWaypointType "MOVE";
_wp setWaypointCompletionRadius 550;
_wp setWaypointSpeed "LIMITED";

_moveto = [AIT_NATO_HQPos,400,_dir] call SHK_pos;

_wp = _tgroup addWaypoint [_moveto,0];
_wp setWaypointType "LOITER";
_wp setWaypointBehaviour "CARELESS";
_wp setWaypointSpeed "FULL";	
_wp setWaypointCompletionRadius 100;
_wp setWaypointStatements ["true","(vehicle this) AnimateDoor ['Door_rear_source', 0, false];(vehicle this) forceSpeed -1;"];	

_wp = _tgroup addWaypoint [_moveto,0];
_wp setWaypointType "SCRIPTED";
_wp setWaypointStatements ["true","[vehicle this] execVM 'funcs\cleanup.sqf'"]; 

_comp = AIT_NATO_Vehicle_AirTransport_Large call ISSE_Cfg_Vehicle_GetName;
_an = "A";
if((_ao select [0,1]) in ["A","E","I","O","a","e","i","o"]) then {_an = "An"};
[3,_ao,"Known Intel",format["Intelligence reports that this will be the dropzone for the battle. %1 %2 is also known to be departing %3 with %4 troops",_an,_comp,AIT_NATO_HQ,count _soldiers]] remoteExec ["intelEvent",0,false];

[_soldiers,_attackpos,_town,_tskid] spawn {
	_soldiers = _this select 0;
	_attackpos = _this select 1;
	_town = _this select 2;
	_tskid = _this select 3;
	
	private ["_size","_active","_alive"];
	sleep 20;
	_size = count _soldiers;
	_lostat = round(_size * 0.2);
	_active = true;
	
		
	while {_active} do {
		_alive = [];
		_inrange = [];
		{
			if(alive _x and !(_x call hasOwner)) then {
				_alive pushback _x;
				if(_x distance _attackpos < 150) then {
					_inrange pushback _x;
				};
			};
		}foreach(_soldiers);
		if(count _alive <= _lostat) then {
			[_tskid, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
			_active = false;
			format["NATO has abandoned %1",_town] remoteExec ["notify_good",0,false];
		}else{
			if(((count _inrange) / (count _alive)) > 0.7) then {
				//check for any alive enemies
				_enemies = [];
				{
					if(side _x == resistance || side _x == east) then {
						_enemies pushback _x;
					};
				}foreach(_attackpos nearentities ["Man",400]);
				if((count _enemies) == 0 and (count _inrange) > 1) then {
					//NATO has won					
					[_tskid, "FAILED",true] spawn BIS_fnc_taskSetState;
					_active = false;
					[_town,50] call stability;
					_abandoned = server getVariable "NATOabandoned";
					_abandoned deleteAt (_abandoned find _town);
					server setVariable ["NATOabandoned",_abandoned,true];
				};
			};
		};		
		sleep 10;
	};

};

if(_population < 120) exitWith{};
_pos = AIT_NATO_HQPos;
sleep 60;
//Air support (Heli)
{	
	_group = createGroup blufor;
	_vehtype = _x;
	_pos = [_pos,40 + random 60,50 + random 180,false,[0,0],[100,_vehtype]] call SHK_pos;
	_veh = createVehicle [_vehtype, _pos, [], 0,""];  	
	_vehs pushback _veh;
	_veh setDir 50;
	_group addVehicle _veh;
	
	createVehicleCrew _veh;
	{
		[_x] joinSilent _group;
		_x setVariable ["garrison","HQ",false];
	}foreach(crew _veh);	
	_wp = _group addWaypoint [_posTown,50];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointSpeed "FULL"; 
	sleep 40;
}foreach(AIT_NATO_Vehicles_AirSupport);

{
	_x addCuratorEditableObjects [_vehs+_soldiers,true];
} forEach allCurators;


if(_population < 500) exitWith{};
sleep 20; 

//Air support (Winged)
{	
	_group = createGroup blufor;
	_vehtype = _x;
	_pos = [getMarkerPos AIT_NATO_AirSpawn,0,0,false,[0,0],[100,_vehtype]] call SHK_pos;
	_veh = createVehicle [_vehtype, _pos, [], 0,""];  	
	_vehs pushback _veh;
	_veh setDir 50;
	_group addVehicle _veh;
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
}foreach(AIT_NATO_Vehicles_AirWingedSupport);



