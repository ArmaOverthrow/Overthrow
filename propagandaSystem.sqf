if !(isServer) exitWith {};

while {true} do {
	private _abandoned = server getVariable ["NATOabandoned",[]];
	{
		private _town = _x;
		private _townPos = server getVariable _town;
		private _commsAbandoned = ((_townPos call nearestComms) select 1) in _abandoned;
		private _stability = server getVariable format["stability%1",_town];
		if(_town in _abandoned) then {
			if(_commsAbandoned) then {
				//Resistance controls both, stability goes up if theres no crim leader
				_leaderpos = server getVariable [format["crimleader%1",_town],false];
				if ((typeName _leaderpos) != "ARRAY") then {
					[_town,1] call stability;
				};
			}else{
				//NATO owns the tower but not the town, stability goes down
				if((random 100) > 80) then {
					[_town,-1] call stability;
				};
			};
		}else{
			if(_commsAbandoned) then {
				//Resistance controls tower but not town, stability goes down, but will not trigger a battle
				
				if(_stability > 20) then {
					if((random 100) > 40) then {
						[_town,-1] call stability;
					};
				};
			};
		};
	}foreach(AIT_allTowns);
	sleep 600;
};