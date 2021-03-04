private ["_id","_pos","_building","_tracked","_vehs","_group","_all","_shopkeeper","_groups"];

params ["_faction","_name","_spawnid"];
sleep random 2;

private _pos = server getVariable [format["factionrep%1",_faction],[]];

if(count _pos isEqualTo 0) exitWith {[]};


private _groups = [];

private _group = createGroup civilian;
_group setBehaviour "CARELESS";
_groups pushback _group;

_shopkeeper = _group createUnit [OT_civType_shopkeeper, _pos, [],0, "NONE"];

//Set face/voice && uniform
[_shopkeeper, (OT_faces_local call BIS_fnc_selectRandom)] remoteExecCall ["setFace", 0, _shopkeeper];
[_shopkeeper, "NoVoice"] remoteExecCall ["setSpeaker", 0, _shopkeeper];
_shopkeeper forceAddUniform (OT_clothes_locals call BIS_fnc_selectRandom);

removeAllItems _shopkeeper;
removeHeadgear _shopkeeper;
removeAllWeapons _shopkeeper;
removeVest _shopkeeper;
removeAllAssignedItems _shopkeeper;

_shopkeeper addGoggles (selectRandom OT_allGlasses);

_shopkeeper allowDamage false;
_shopkeeper disableAI "MOVE";
_shopkeeper disableAI "AUTOCOMBAT";
_shopkeeper setVariable ["NOAI",true,false];

_shopkeeper setVariable ["factionrep",true,true];
_shopkeeper setVariable ["faction",_faction,true];
_shopkeeper setVariable ["factionrepname",_name,true];
[_shopkeeper,"self"] call OT_fnc_setOwner;
_shopkeeper setVariable ["shopcheck",true,true];

spawner setvariable [_spawnid,(spawner getvariable [_spawnid,[]]) + _groups,false];
