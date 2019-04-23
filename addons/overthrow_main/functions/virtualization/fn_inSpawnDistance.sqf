if(typename _this == "GROUP") exitWith {false};
(
	{
		(alive _x || (_x getVariable ["player_uid",false]) isEqualType "")
		&&
		(_this distance _x) < OT_spawnDistance
	} count (
		(
			(alldeadmen + allPlayers) - entities "HeadlessClient_F"
		)
		+
		(spawner getVariable ["track",[]])
	)
	> 0
)
