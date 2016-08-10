_garrison = compileFinal preProcessFileLineNumbers "spawners\militaryGarrison.sqf";
_checkpoints = compileFinal preProcessFileLineNumbers "spawners\militaryCheckpoint.sqf";
{
	_name = _x select 1;
	_pos = _x select 0;
	[_pos,_garrison,_name] call AIT_fnc_registerSpawner;	
}foreach(AIT_NATOobjectives);

{
	_pos = getMarkerPos _x;
	[_pos,_checkpoints,_x] call AIT_fnc_registerSpawner;	
}foreach(AIT_NATO_control);