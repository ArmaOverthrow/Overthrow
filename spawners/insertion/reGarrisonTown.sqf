private ["_pos","_town","_townPos","_drop","_group","_start","_stability","_vehtype","_num","_count","_police","_group","_tgroup","_wp","_attackdir","_vehtype","_civ"];

_town = _this;
_townPos = server getVariable _town;

_stability = server getVariable format["stability%1",_town];
_region = server getVariable format["region_%1",_town];

_police = [];
_support = [];
_opendoor = false;

_dist = 8000;


_attackdir = random 360;
if(surfaceIsWater ([_townPos,150,_attackDir] call BIS_fnc_relPos)) then {
	_attackdir = _attackdir + 180;
	if(_attackdir > 359) then {_attackdir = _attackdir - 359};
	if(surfaceIsWater ([_townPos,150,_attackDir] call BIS_fnc_relPos)) then {
		_attackdir = _attackdir + 90;
		if(_attackdir > 359) then {_attackdir = _attackdir - 359};
		if(surfaceIsWater ([_townPos,150,_attackDir] call BIS_fnc_relPos)) then {
			_attackdir = _attackdir + 180;
			if(_attackdir > 359) then {_attackdir = _attackdir - 359};
		};
	};
};
_attackdir = _attackdir - 45;
sleep 0.1;
_group = creategroup blufor;
_tgroup = creategroup blufor;

_vehtype = AIT_NATO_Vehicle_PoliceHeli;

_drop = [_townPos,[350,500],_attackdir + (random 90)] call SHK_pos;
_spawnpos = AIT_NATO_HQPos;	

if(_stability < 25 and (random 100) > 50) then {
	//last ditch efforts to save this town
	//send in the big guns
	_vehtype = AIT_NATO_Vehicle_AirTransport;
	_opendoor = true;
	_num = 5 + round(random 6);
	_count = 0;
	while {_count < _num} do {
		_start = [_spawnpos,[10,29],random 360] call SHK_pos;
		_civ = _group createUnit [AIT_NATO_Units_LevelTwo call BIS_fnc_selectRandom, _start, [],0, "NONE"];
		_civ setRank "SERGEANT";
		_police pushBack _civ;
		_civ setVariable ["garrison","HQ",false];
		[_civ,_town] call initMilitary;
		_count = _count + 1;
		sleep 0.1;
	};
};

if(_stability < 40 and (random 100) > 70) then {
	_townPos spawn CTRGsupport;
};

_veh =  _vehtype createVehicle _spawnpos;
_dir = [_spawnpos,_townPos] call BIS_fnc_dirTo;
_veh setDir _dir;
_tgroup addVehicle _veh;

createVehicleCrew _veh;
sleep 0.1;
{
	[_x] joinSilent _tgroup;
	_x setVariable ["NOAI",true,false];
	_x setVariable ["garrison","HQ",false];
}foreach(crew _veh);	

{
	_x moveInCargo _veh;
}foreach(_police);

_police pushBack _veh;

_start = [_spawnpos,[10,29],random 360] call SHK_pos;
_civ = _group createUnit [AIT_NATO_Unit_PoliceCommander, _start, [],0, "NONE"];
_civ setVariable ["garrison",_town,false];
_civ setRank "CORPORAL";
_civ moveInCargo _veh;
_police pushBack _civ;
[_civ,_town] call initPolice;

if(_stability > 50) then {
	_civ setBehaviour "SAFE";
};
sleep 0.1;
_start = [_spawnpos,[10,29],random 360] call SHK_pos;
_civ = _group createUnit [AIT_NATO_Unit_Police, _start, [],0, "NONE"];
_civ setRank "PRIVATE";
_civ moveInCargo _veh;
_civ setVariable ["garrison",_town,false];

_police pushBack _civ;
[_civ,_town] call initPolice;
if(_stability > 50) then {
	_civ setBehaviour "SAFE";
};

_moveto = [AIT_NATO_HQPos,500,_dir] call SHK_pos;
_wp = _tgroup addWaypoint [_moveto,0];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointSpeed "FULL";
_wp setWaypointCompletionRadius 150;
_wp setWaypointStatements ["true","(vehicle this) flyInHeight 150;"];

_wp = _tgroup addWaypoint [_drop,0];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "COMBAT";
if(_opendoor) then {
	_wp setWaypointStatements ["true","(vehicle this) AnimateDoor ['Door_rear_source', 1, false];"];
};
wp setWaypointCompletionRadius 50;
_wp setWaypointSpeed "FULL";

_wp = _tgroup addWaypoint [_drop,0];
_wp setWaypointType "SCRIPTED";
_wp setWaypointStatements ["true","[vehicle this,75] execVM 'funcs\addons\eject.sqf'"];	
_wp setWaypointTimeout [10,10,10];

_wp = _tgroup addWaypoint [_drop,0];
_wp setWaypointType "SCRIPTED";
if(_opendoor) then {
	_wp setWaypointStatements ["true","(vehicle this) AnimateDoor ['Door_rear_source', 0, false];"];	
};
_wp setWaypointTimeout [15,15,15];

_moveto = [AIT_NATO_HQPos,200,_dir] call SHK_pos;

_wp = _tgroup addWaypoint [_moveto,0];
_wp setWaypointType "LOITER";
_wp setWaypointBehaviour "CARELESS";
_wp setWaypointSpeed "FULL";	
_wp setWaypointCompletionRadius 100;

_wp = _tgroup addWaypoint [_moveto,0];
_wp setWaypointType "SCRIPTED";
_wp setWaypointStatements ["true","[vehicle this] execVM 'funcs\cleanup.sqf'"]; 

_attackpos = [_townPos,[0,150]] call SHK_pos;

_dir = [_attackpos,_drop] call BIS_fnc_dirTo;
_moveto = [_attackpos,100,_dir] call SHK_pos;

_move = _group addWaypoint [_moveto,0];
_move setWaypointType "MOVE";
_move setWaypointSpeed "FULL";
_move setWaypointBehaviour "COMBAT";

_move = _group addWaypoint [_attackpos,0];
_move setWaypointType "GUARD";
_move setWaypointSpeed "NORMAL";
_move setWaypointBehaviour "STEALTH";


{
	_x addCuratorEditableObjects [_police+_support,true];
} forEach allCurators;


_police+_support;