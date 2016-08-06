private ["_idx","_jugador","_cosa","_id"];

_cosa = _this select 0;
_jugador = _this select 1;
_id = _this select 2;
_cosa enableSimulationGlobal false;
_cosa removeAction _id;
_cosa attachTo [_jugador,[0,2,1]];

_idx = _jugador addAction ["Drop Here", {{detach _x} forEach attachedObjects player;},nil,0,false,true,"",""];

waitUntil {sleep 0.05; (count attachedObjects _jugador == 0) or (vehicle _jugador != _jugador) or (!alive _jugador) or (!isPlayer _jugador)};

{detach _x} forEach attachedObjects _jugador;
_jugador removeAction _idx;

_cosa setPosATL [getPosATL _cosa select 0,getPosATL _cosa select 1,getPosATL _jugador select 2];

sleep 1;
_cosa addAction ["Move this", "actions\move.sqf",nil,0,false,true,"",""];
_cosa enableSimulationGlobal true;