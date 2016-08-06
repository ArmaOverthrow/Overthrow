_spawner = compileFinal preProcessFileLineNumbers "spawners\shop.sqf";

{
	_pos = getpos _x;
	[_pos,_spawner,_x] call AIT_fnc_registerSpawner;	
}foreach(AIT_activeShops);