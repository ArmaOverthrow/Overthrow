if !(isServer) exitWith {};

while {true} do {
	private _abandoned = server getVariable ["NATOabandoned",[]];
	{
		private _town = _x;
		private _townPos = server getVariable _town;
		private _commsAbandoned = ((_townPos call nearestComms) select 1) in _abandoned;
		private _stability = server getVariable format["stability%1",_town];
		if(_townPos call inSpawnDistance) then {
			if(_town in _abandoned) then {
				
			}else{
				{
					
				}foreach(AIT_NATO_missions);
			};
		};		
	}foreach(AIT_allTowns);
	sleep 600;
};