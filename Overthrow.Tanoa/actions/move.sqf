private ["_idx","_jugador","_cosa","_id"];

_cosa = _this select 0;
_jugador = _this select 1;
_id = _this select 2;
_cosa remoteExec ["enableSimulationGlobal false",2];
_cosa enableSimulation false;
_cosa removeAction _id;

_originalpos = getposATL _cosa;
_originaldir = getDir _cosa;
_mass = getMass _cosa;
_cosa setMass 0;
{
	_cosa disableCollisionWith _x;
}foreach(vehicles + allUnits);

_p = getpos _cosa;
_j = getpos _jugador;
_p = [0,2.5,((_p select 2) - (_j select 2))+1.2];

_cosa attachTo [_jugador,_p];
_cosa allowDamage false;

AIT_moveIdx = _jugador addAction ["Drop Here", {{detach _x} forEach attachedObjects player;},nil,0,false,true,"",""];

waitUntil {sleep 0.1; (count attachedObjects _jugador == 0) or (vehicle _jugador != _jugador) or (!alive _jugador) or (!isPlayer _jugador)};

{detach _x} forEach attachedObjects _jugador;
_jugador removeAction AIT_moveIdx;

if!([(getpos player),"Misc"] call canPlace) exitWith {
	"You cannot move this too far from a building or camp that you own" call notify_minor;
	_cosa setPosATL _originalpos;
	_cosa setDir _originaldir;
	_cosa addAction ["Move this", "actions\move.sqf",nil,0,false,true,"",""];
	_cosa enableSimulationGlobal true;
};

_cosa setPosATL [getPosATL _cosa select 0,getPosATL _cosa select 1,getPosATL _jugador select 2];
_cosa addAction ["Move this", "actions\move.sqf",nil,0,false,true,"",""];
_cosa remoteExec ["enableSimulationGlobal true",2];
_cosa enableSimulation true;
_cosa allowDamage true;
_cosa setMass _mass;
{
	_cosa enableCollisionWith _x;
}foreach(vehicles + allUnits);