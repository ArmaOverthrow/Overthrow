//Manages passive income for all players (Lease + taxes)

waitUntil {sleep 1;server getVariable ["StartupType",""] != ""};
private _lasthour = date select 3;
while {true} do {
	private _hour = 
	waitUntil {sleep 600;(_hour != _lasthour) and ((_hour == 0) or (_hour == 6) or (_hour == 12) or (_hour == 18))}; //do actions on the hour
	_lasthour = date select 3;
	private _total = 0;	
	private _inf = 1;
	{
		private _town = _x;
		_total = _total + 250;
		if(_town in OT_allAirports) then {
			_total = _total + ((server getVariable ["stabilityTanoa",100]) * 4); //Tourism income
		};
		_inf = _inf + 1;
		if(_town in OT_allTowns) then {			
			private _population = server getVariable format["population%1",_town];
			private _stability = server getVariable format["stability%1",_town];
			private _garrison = server getVariable [format['police%1',_town],0];
			private _add = round(_population * (_stability/100));			
			if(_stability > 49) then {
				_add = round(_add * 4);
			};
			if(_garrison == 0) then {
				_add = round(_add * 0.5);
			};
			_total = _total + _add;
		};
	}foreach(server getVariable ["NATOabandoned",[]]);
	
	{
		private _owned = _x getvariable ["owned",[]];
		_lease = 0;
		{
			private _bdg = OT_centerPos nearestObject _x;
			if !(isNil "_bdg") then {
				if(_bdg getVariable ["leased",false]) then {				
					private _data = _bdg call getRealEstateData;
					_lease = _lease + (_data select 2);				
				};
			};
		}foreach(_owned);
		if(_lease > 0) then {
			private _money = _x getVariable ["money",0];
			_x setVariable ["money",_money+_lease,true];
		};
	}foreach([] call CBA_fnc_players);
	
	
	_numPlayers = count([] call CBA_fnc_players);
	if(isNil "_total") then {_total = 0};
	_perPlayer = round(_total / _numPlayers);
	if(_perPlayer > 0) then {
		_inf remoteExec ["influenceSilent",0,false];	
		{
			_money = _x getVariable ["money",0];
			_x setVariable ["money",_money+_perPlayer,true];
		}foreach([] call CBA_fnc_players);
		format ["Tax income: $%1 (+%2 Influence)",[_perPlayer, 1, 0, true] call CBA_fnc_formatNumber,_inf] remoteExec ["notify_good",0,true];
	}else{
		_inf remoteExec ["influence",0,false];	
	};
	
};

