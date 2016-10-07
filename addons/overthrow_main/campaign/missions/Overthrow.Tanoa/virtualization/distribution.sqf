_spawner = compileFinal preProcessFileLineNumbers "spawners\distribution.sqf";
waitUntil {!isNil "OT_economyLoadDone"};
{
	_pos = getpos _x;
	[_pos,_spawner,_x] call OT_fnc_registerSpawner;	
}foreach(OT_activeDistribution);