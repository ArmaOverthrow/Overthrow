_spawner = compileFinal preProcessFileLineNumbers "spawners\distribution.sqf";
waitUntil {!isNil "AIT_economyLoadDone"};
{
	_pos = getpos _x;
	[_pos,_spawner,_x] call AIT_fnc_registerSpawner;	
}foreach(AIT_activeDistribution);