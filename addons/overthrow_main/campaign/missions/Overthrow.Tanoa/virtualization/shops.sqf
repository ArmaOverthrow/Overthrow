_spawner = compileFinal preProcessFileLineNumbers "spawners\shop.sqf";
waitUntil {!isNil "OT_economyLoadDone"};
{
	_pos = getpos _x;
	[_pos,_spawner,_x] call OT_fnc_registerSpawner;	
}foreach(OT_activeShops);