({(alive _x or typename (_x getVariable ["player_uid",false]) == "STRING") and (_this distance _x) < OT_spawnDistance} count (allPlayers + alldeadmen + (spawner getVariable ["track",[]])) > 0)
/*
//So zeus spawns, a'la ALiVE
_zeus = getpos curatorCamera;
if ((_zeus select 0) != 0) then {
	if((_zeus distance _pos) < OT_spawnDistance) exitWith {_return = true};
};

_return;*/
