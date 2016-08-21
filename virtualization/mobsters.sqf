private ["_spawner"];
_spawner = compileFinal preProcessFileLineNumbers "spawners\mobster.sqf";
waitUntil {!isNil "AIT_CRIMInitDone"};
{
	private ["_p","_i"];
	_p = _x select 0;
	_i = _x select 1;
	[_p,_spawner,_i] call AIT_fnc_registerSpawner;	
}foreach(server getVariable ["activemobsters",[]]);