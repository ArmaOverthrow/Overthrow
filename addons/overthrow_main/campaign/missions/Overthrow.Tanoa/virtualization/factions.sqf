_spawner = compileFinal preProcessFileLineNumbers "spawners\factionrep.sqf";
waitUntil {!isNil "OT_economyLoadDone"};
{
    _x params ["_cls","_name","_side"];
	_pos = server getVariable [format["factionrep%1",_cls],[]];
    if(count _pos > 0) then {
	       [_pos,_spawner,[_cls,_name]] call OT_fnc_registerSpawner;
    }
}foreach(OT_allFactions);
