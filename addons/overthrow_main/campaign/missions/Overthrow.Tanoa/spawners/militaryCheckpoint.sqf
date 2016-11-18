params ["_start","_name"];

private _count = 0;

private _numNATO = server getVariable format["garrison%1",_name];
if(_numNATO <= 0) exitWith {[]};


private _road = [_start] call BIS_fnc_nearestRoad;
private _start = getPos _road;
private _vehtype = OT_vehTypes_civ call BIS_Fnc_selectRandom;

private _roadscon = roadsConnectedto _road;
private _dir = [_road, _roadscon select 0] call BIS_fnc_DirTo;

private _vehs = [_start,_dir,template_checkpoint] call BIS_fnc_objectsMapper;
			
private _groups = [];
private _soldiers = [];

if(isNil "_numNATO") then {
	//New checkpoint was added to game
	_numNATO = 6 + (random 4);
	server setVariable [format["garrison%1",_name],_numNATO,true];
};

_count = 0;
_range = 100;
_groupcount = 0;

_group = createGroup blufor;							
_groups pushBack _group;	
_groupcount = 1;

_start = [_start,12,_dir+90] call BIS_fnc_relPos;

_civ = _group createUnit [OT_NATO_Unit_LevelOneLeader, _start, [],0, "NONE"];
_civ setVariable ["garrison",_name,false];
_civ setRank "MAJOR";
_soldiers pushBack _civ;
[_civ,_name] call initMilitary;
_civ setBehaviour "SAFE";

{
	if(typeof _x in OT_staticMachineGuns) then {
		_group addVehicle _x;
	};
	_groups pushback _x;
}foreach(_vehs);

_count = _count + 1;

while {_count < _numNATO} do {	
	_pos = [_start,0,60, 0.1, 0, 0, 0] call BIS_fnc_findSafePos;		
	_civ = _group createUnit [OT_NATO_Units_LevelTwo call BIS_fnc_selectRandom, _pos, [],0, "NONE"];
	_civ setVariable ["garrison",_name,false];
	_soldiers pushBack _civ;
	_civ setRank "CAPTAIN";
	[_civ,_name] call initMilitary;
	_civ setBehaviour "SAFE";					

	_count = _count + 1;
	_groupcount = _groupcount + 1;
};
_group spawn initCheckpoint;
	
_groups