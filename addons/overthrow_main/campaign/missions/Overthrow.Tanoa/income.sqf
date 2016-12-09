//Manages passive income for all players (Lease + taxes)

waitUntil {sleep 1;server getVariable ["StartupType",""] != ""};
private _lasthour = date select 3;
while {true} do {
	waitUntil {sleep 3;(date select 3) != _lasthour}; //do actions on the hour
	_lasthour = date select 3;
	private _inf = 1;
	private _total = 0;

	if(OT_fastTime) then {
		if(_lasthour == 19) then {
			setTimeMultiplier 8;
		};
		if(_lasthour == 7) then {
			setTimeMultiplier 4;
		};
	};

	if((_lasthour == 0) or (_lasthour == 6) or (_lasthour == 12) or (_lasthour == 18)) then {
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
	};
	_totax = 0;
	_tax = server getVariable ["taxrate",0];
	if(_tax > 0) then {
		_totax = round(_total * (_tax / 100));
	};

	{
		private _owned = _x getvariable ["owned",[]];
		_lease = 0;
		{
			private _bdg = OT_centerPos nearestObject _x;
			if !(isNil "_bdg") then {
				if(_bdg getVariable ["leased",false]) then {
					private _data = _bdg call OT_fnc_getRealEstateData;
					_lease = _lease + (_data select 2);
				};
			};
		}foreach(_owned);
		if(_lease > 0) then {
			_tt = 0;
			if(_tax > 0) then {
				_tt = round(_lease * (_tax / 100));
			};
			_totax = _totax + _tt;
			[_lease-_tt] remoteExec ["money",_x,false];
		};
	}foreach([] call CBA_fnc_players);

	_funds = server getVariable ["money",0];
	server setVariable ["money",_funds+_totax];
	_total = _total - _totax;

	_numPlayers = count([] call CBA_fnc_players);
	if(_numPlayers > 0) then {
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
};
