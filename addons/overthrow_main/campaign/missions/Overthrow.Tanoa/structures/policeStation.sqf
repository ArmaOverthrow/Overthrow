private _pos = _this select 0;
private _post = (_pos nearObjects ["Land_Cargo_House_V3_F",10]) select 0;
private _town = _pos call nearestTown;
server setVariable [format['policepos%1',_town],_pos,true];

_garrison = server getVariable format['police%1',_town];
if(isNil "_garrison") then {
	server setVariable [format['police%1',_town],2,true];
	
	_spawned = _town call (compileFinal preProcessFileLineNumbers "spawners\police.sqf");
	_despawn = spawner getVariable [format["despawn%1",_town],[]];
	[_despawn,_spawned] call BIS_fnc_arrayPushStack;
	spawner setVariable [format["despawn%1",_town],_despawn,false];
};

_post remoteExec ["initPoliceStationLocal",0,_post];


