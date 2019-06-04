params ["_start","_name","_spawnid"];
sleep random 0.2;

private _count = 0;

private _numNATO = server getVariable format["garrison%1",_name];
if(isNil "_numNATO") then {
	//New checkpoint was added
	_numNATO = 6 + round(random 4);
	server setVariable [format["garrison%1",_name],_numNATO,true];
};
if(_numNATO <= 0) exitWith {[]};

private _road = [_start] call BIS_fnc_nearestRoad;
if(isNil "_road") exitWith {diag_log format["Overthrow: WARNING: Couldnt find road for %1 %2",_name,_start];[]};

_start = getPos _road;

if((count _start) isEqualTo 0 || _start#1 isEqualTo 0) exitWith {diag_log format["Overthrow: WARNING: Couldnt find road for %1 %2",_name,_start];[]};

private _vehtype = OT_vehTypes_civ call BIS_Fnc_selectRandom;

private _roadscon = roadsConnectedto _road;
private _dir = [_road, _roadscon select 0] call BIS_fnc_DirTo;
if(isNil "_dir") then {_dir = 90};

private _vehs = [_start,_dir,OT_tpl_checkpoint] call BIS_fnc_objectsMapper;

private _groups = [];
private _soldiers = [];

_count = 0;
_range = 100;
_groupcount = 0;

_group = createGroup blufor;
_group setVariable ["VCM_TOUGHSQUAD",true,true];
_group setVariable ["VCM_NORESCUE",true,true];
_groups pushBack _group;
_groupcount = 1;

_start = [_start,7,_dir-90] call BIS_fnc_relPos;

_civ = _group createUnit [OT_NATO_Unit_TeamLeader, _start, [],0, "NONE"];
_civ setVariable ["garrison",_name,false];
_civ setRank "MAJOR";
_soldiers pushBack _civ;
[_civ,_name] call OT_fnc_initMilitary;
_civ setBehaviour "SAFE";
sleep 0.5;

{
	if(_x isKindOf "StaticWeapon") then {
		_group addVehicle _x;
		createVehicleCrew _x;
		((units _x) select 0) setVariable ["NOAI",true,false];
		(units _x) joinSilent _group;
		sleep 0.5;
	};
	_groups pushback _x;
}foreach(_vehs);

_count = _count + 1;
sleep 0.3;
while {_count < _numNATO} do {
	_start = [_start,2,_dir-180] call BIS_fnc_relPos;
	_civ = _group createUnit [OT_NATO_Units_LevelTwo call BIS_fnc_selectRandom, _start, [],0, "NONE"];
	_civ setVariable ["garrison",_name,false];
	_soldiers pushBack _civ;
	_civ setRank "CAPTAIN";
	[_civ,_name] call OT_fnc_initMilitary;
	_civ setBehaviour "SAFE";
	sleep 0.5;
	_count = _count + 1;
	_groupcount = _groupcount + 1;
	if(_count isEqualTo 2) then {
		_start = [_start,20,_dir+90] call BIS_fnc_relPos;
	};
};
_group spawn OT_fnc_initNATOCheckpoint;
{
	_x addCuratorEditableObjects [units _group];
}foreach(allcurators);

spawner setvariable [_spawnid,_groups,false];
