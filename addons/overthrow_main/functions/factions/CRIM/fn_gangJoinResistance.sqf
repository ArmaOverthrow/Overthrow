params ["_leader","_gangid","_player"];

private _gang = OT_civilians getVariable [format["gang%1",_gangid],[]];
if(count _gang isEqualTo 0) exitWith {diag_log "Overthrow Error: gang not found (OT_fnc_gangJoinResistance)"};

private _group = creategroup resistance;
private _name = _gang select 8;
private _town = _gang select 2;

[_leader] joinSilent grpNull;
[_leader] joinSilent _group;
_group selectLeader _leader;
_leader enableAI "PATH";

private _cc = _player getVariable ["OT_squadcount",0];
_group setGroupIdGlobal [_name];
_cc = _cc + 1;
_player hcSetGroup [_group,groupId _group,"teamgreen"];

private _gangGroup = spawner getVariable [format["gangspawn%1",_gangid],grpNull];

{
    [_x] joinSilent grpNull;
    [_x] joinSilent _group;
    [_x,getPlayerUID player] call OT_fnc_setOwner;
    _x setVariable ["OT_spawntrack",true,true];
	player reveal [_x,4];
}foreach(units _gangGroup);

_player setVariable ["OT_squadcount",_cc,true];

private _recruits = server getVariable ["squads",[]];
_recruits pushback [getplayeruid _player,_gangid,_group,[]];
server setVariable ["squads",_recruits,true];

OT_civilians setVariable [format["gangsin%1",_town],[],true];
OT_civilians setVariable [format["gang%1",_gangid],[],true];
spawner setVariable [format["gangspawn%1",_gangid],grpNull,true];

format["%1 has joined the resistance as your squad, use ctrl + space to command",_name] call OT_fnc_notifyMinor;
