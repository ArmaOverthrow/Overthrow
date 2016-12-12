
params ["_pos","_mobsterid","_spawnid"];

private _garrison = server getVariable [format["crimgarrison%1",_mobsterid],0];
if(_garrison == 0) exitWith {[]};

private _leader = server getVariable [format["mobleader%1",_mobsterid],false];
if (typename _leader == "BOOL") exitWith {[]};

private _groups = [];
private _group = createGroup east;
_groups pushback _group;
_group setBehaviour "SAFE";


//the camp
_veh = createVehicle ["Campfire_burning_F",_pos,[],0,"CAN_COLLIDE"];
_groups pushback _veh;
_dir = random 360;
_flagpos = [_pos,2,_dir] call BIS_fnc_relPos;
_veh = createVehicle [OT_flag_CRIM,_flagpos,[],0,"CAN_COLLIDE"];
_groups pushback _veh;

_numtents = 2 + round(random 3);
_count = 0;

while {_count < _numtents} do {
	//this code is in tents
	_d = random 360;
	_p = [_pos,[2,9],_d] call SHK_pos;
	_p = _p findEmptyPosition [1,40,"Land_TentDome_F"];
	_veh = createVehicle ["Land_TentDome_F",_p,[],0,"CAN_COLLIDE"];
	_veh setDir _d;
	_groups pushback _veh;
	_count = _count + 1;
	sleep 0.1;
};
		

//spawn in the crime boss
_start = [_pos,[0,30]] call SHK_pos;			
_civ = _group createUnit [OT_CRIM_Unit, _start, [],0, "NONE"];
_civ setRank "COLONEL";
[_civ] joinSilent nil;
[_civ] joinSilent _group;
_civ setVariable ["garrison",_mobsterid,true];
_civ call OT_fnc_initMobBoss;
{
	_x addCuratorEditableObjects[[_civ],false];
}foreach(allcurators);
sleep 0.2;
//spawn in his protection
_count = 0;
while {_count < _garrison} do {
	_start = [_pos,[0,60]] call SHK_pos;
	_civ = _group createUnit [OT_CRIM_Unit, _start, [],0, "NONE"];
	_civ setRank "MAJOR";
	[_civ] joinSilent nil;
	[_civ] joinSilent _group;
	_civ setVariable ["garrison",_mobsterid,true];
	_civ call OT_fnc_initMobster;
	_count = _count + 1;
	{
		_x addCuratorEditableObjects[[_civ],false];
	}foreach(allcurators);
	sleep 0.2;
};

_wp = _group addWaypoint [_flagpos,0];
_wp setWaypointType "GUARD";

spawner setvariable [_spawnid,_groups,false];