_garrison = compileFinal preProcessFileLineNumbers "spawners\militaryGarrison.sqf";

{
	_name = _x select 1;
	_pos = _x select 0;
	[_pos,_garrison,_name] call AIT_fnc_registerSpawner;	
}foreach(AIT_NATOobjectives);