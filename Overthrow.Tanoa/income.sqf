//Manages passive income for all players (Lease + taxes)
_lasthour = 0;
sleep 20;
while {true} do {
	_lasthour = date select 3;
	_total = 0;	
	_inf = 1;
	{
		_town = _x;
		if(_town in AIT_allTowns) then {
			_population = server getVariable format["population%1",_town];
			_stability = server getVariable format["stability%1",_town];
			_add = round(_population * (_stability/100));			
			if(_stability > 49) then {
				_add = round(_add * 2);
			};			
			_total = _total + _add;
			_inf = _inf + 1;
		};
	}foreach(server getVariable ["NATOabandoned",[]]);
	
	{
		_owned = _x getvariable ["owned",[]];
		_lease = 0;
		{
			if(_x getVariable ["leased",false]) then {				
				_data = _x call getRealEstateData;
				_lease = _lease + (_data select 2);				
			};
		}foreach(_owned);
		if(_lease > 0) then {
			_money = _x getVariable ["money",0];
			_x setVariable ["money",_money+_lease,true];
			[_x,"Lease Income",format["Lease income for this period: $%1",_lease]] call BIS_fnc_createLogRecord;
		};
	}foreach(allPlayers);
	_inf remoteExec ["influence",0,false];	
	
	_numPlayers = count(allPlayers);
	_perPlayer = round(_total / _numPlayers);
	if(_perPlayer > 0) then {
		{
			_money = _x getVariable ["money",0];
			_x setVariable ["money",_money+_perPlayer,true];
			[_x,"Tax Income",format["Tax income for this period: $%1",_perPlayer]] call BIS_fnc_createLogRecord;
		}foreach(allPlayers);
		format ["Tax income: $%1",[_perPlayer, 1, 0, true] call CBA_fnc_formatNumber] remoteExec ["notify_good",0,true];
	};	
	
	waitUntil {sleep 5;(date select 3) != _lasthour}; //do actions on the hour
};

