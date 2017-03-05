private ["_spawner"];
_spawner = compileFinal preProcessFileLineNumbers "spawners\employees.sqf";

{
	private ["_p","_i"];
	_p = _x select 0;
	_i = _x select 1;
	[_p,_spawner,[_p,_i]] call OT_fnc_registerSpawner;
}foreach(OT_economicData);

[OT_factoryPos,_spawner,[OT_factoryPos,"Factory"]] call OT_fnc_registerSpawner;
