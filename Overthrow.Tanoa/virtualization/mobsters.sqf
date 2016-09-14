private ["_spawner"];
_spawner = compileFinal preProcessFileLineNumbers "spawners\mobster.sqf";
waitUntil {!isNil "OT_CRIMInitDone"};
{
	private ["_p","_i"];
	_p = _x select 0;
	_i = _x select 1;
	[_p,_spawner,_i] call OT_fnc_registerSpawner;	
}foreach(server getVariable ["activemobsters",[]]);