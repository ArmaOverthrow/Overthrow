if !(isServer) exitWith {};
_lasthour = 0;
waitUntil {sleep 1;server getVariable ["StartupType",""] != ""};
sleep 20;
while {true} do {
	_lasthour = date select 3;
	private _abandoned = server getVariable ["NATOabandoned",[]];
	{
		private _town = _x;
		private _townPos = server getVariable _town;
		private _commsAbandoned = ((_townPos call nearestComms) select 1) in _abandoned;
		private _stability = server getVariable format["stability%1",_town];
		if(_town in _abandoned) then {
			if(_commsAbandoned) then {
				//Resistance controls both, stability goes up if theres police
				_police = server getVariable [format["police%1",_town],0];
				if (_police > 0) then {
					[_town,floor(_police / 2)] call stability;
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
	}foreach(OT_allTowns);
	waitUntil {sleep 5;(date select 3) != _lasthour}; //do actions on the hour
};