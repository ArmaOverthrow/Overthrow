private ["_pos","_players","_posPlayer","_playersalive"];

_pos = _this;
_return = false;

_players = [player];
if(isMultiplayer) then {
	_players = playableUnits;
};
	
({alive _x and (_pos distance _x) < AIT_spawnDistance} count _players) > 0
/*
//So zeus spawns, a'la ALiVE
_zeus = getpos curatorCamera;
if ((_zeus select 0) != 0) then {
	if((_zeus distance _pos) < AIT_spawnDistance) exitWith {_return = true};
};

_return;*/
