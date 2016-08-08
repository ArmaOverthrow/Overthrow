_civs = compileFinal preProcessFileLineNumbers "spawners\civ.sqf";
_garrison = compileFinal preProcessFileLineNumbers "spawners\townGarrison.sqf";
_cardealers = compileFinal preProcessFileLineNumbers "spawners\carDealer.sqf";
_crims = compileFinal preProcessFileLineNumbers "spawners\criminal.sqf";
_gundealer = compileFinal preProcessFileLineNumbers "spawners\gunDealer.sqf";
_vehicles = compileFinal preProcessFileLineNumbers "spawners\ambientVehicles.sqf";
{
	_pos = server getvariable _x;
	[_pos,[_civs,_garrison,_cardealers,_crims,_gundealer,_vehicles],_x] call AIT_fnc_registerSpawner;	
}foreach(AIT_allTowns);