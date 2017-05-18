private ["_id","_pos","_building","_tracked","_vehs","_group","_all","_shopkeeper","_groups"];

params ["_faction","_name","_spawnid"];

private _pos = server getVariable [format["factionrep%1",_faction],[]];

if(count _pos == 0) exitWith {[]};


private _groups = [];

_building = nearestBuilding _pos;

private _group = createGroup civilian;
_group setBehaviour "CARELESS";
_groups pushback _group;
private _start = _building buildingPos 0;
_shopkeeper = _group createUnit [OT_civType_shopkeeper, _start, [],0, "NONE"];

//Set face/voice and uniform
[_shopkeeper, (OT_faces_local call BIS_fnc_selectRandom)] remoteExecCall ["setFace", 0, _shopkeeper];
[_shopkeeper, "NoVoice"] remoteExecCall ["setSpeaker", 0, _shopkeeper];
_shopkeeper forceAddUniform (OT_clothes_locals call BIS_fnc_selectRandom);

_shopkeeper allowDamage false;
_shopkeeper disableAI "MOVE";
_shopkeeper disableAI "AUTOCOMBAT";
_shopkeeper setVariable ["NOAI",true,false];

_shopkeeper setVariable ["factionrep",true,true];
_shopkeeper setVariable ["faction",_faction,true];
_shopkeeper setVariable ["factionrepname",_name,true];

spawner setvariable [_spawnid,(spawner getvariable [_spawnid,[]]) + _groups,false];
