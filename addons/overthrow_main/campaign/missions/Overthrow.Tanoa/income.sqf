//Manages passive income for all players (Lease + taxes)

waitUntil {sleep 1;server getVariable ["StartupType",""] != ""};
private _lasthour = date select 3;
while {true} do {	
	waitUntil {sleep 5;(date select 3) != _lasthour}; //do actions on the hour
	_lasthour = date select 3;
	_total = 0;	
	_inf = 1;
	{
		_town = _x;
		if(_town in OT_allTowns) then {
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
			_bdg = OT_centerPos nearestObject _x;
			if !(isNil "_bdg") then {
				if(_bdg getVariable ["leased",false]) then {				
					_data = _x call getRealEstateData;
					_lease = _lease + (_data select 2);				
				};
			};
		}foreach(_owned);
		if(_lease > 0) then {
			_money = _x getVariable ["money",0];
			_x setVariable ["money",_money+_lease,true];
			[_x,"Lease Income",format["Lease income for this period: $%1",_lease]] call BIS_fnc_createLogRecord;
		};
	}foreach(allPlayers);
	
	
	_numPlayers = count(allPlayers);
	if(isNil "_total") then {_total = 0};
	_perPlayer = round(_total / _numPlayers);
	if(_perPlayer > 0) then {
		_inf remoteExec ["influenceSilent",0,false];	
		{
			_money = _x getVariable ["money",0];
			_x setVariable ["money",_money+_perPlayer,true];
			[_x,"Tax Income",format ["Tax income: $%1 (+%2 Influence)",[_perPlayer, 1, 0, true] call CBA_fnc_formatNumber,_inf]] call BIS_fnc_createLogRecord;
		}foreach(allPlayers);
		format ["Tax income: $%1 (+%2 Influence)",[_perPlayer, 1, 0, true] call CBA_fnc_formatNumber,_inf] remoteExec ["notify_good",0,true];
	}else{
		_inf remoteExec ["influence",0,false];	
	};
	
};

