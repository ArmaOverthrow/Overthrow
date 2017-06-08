/* ----------------------------------------------------------------------------
Function: incomeSystem
---------------------------------------------------------------------------- */
//Manages passive income for all players (Lease + taxes)

waitUntil {sleep 1;server getVariable ["StartupType",""] != ""};
private _lasthour = date select 3;
while {true} do {
	waitUntil {sleep 3;(date select 3) != _lasthour}; //do actions on the hour
	_lasthour = date select 3;

	if(OT_fastTime) then {		
		if(_lasthour == 19) then {
			setTimeMultiplier 8;
		};
		if(_lasthour == 7) then {
			setTimeMultiplier 4;
		};
	};

	if((_lasthour == 0) or (_lasthour == 6) or (_lasthour == 12) or (_lasthour == 18)) then {
		private _inf = 1;
		private _total = 0;

		_t = call OT_fnc_getTaxIncome;
		_total = _t select 0;
		_inf = _t select 1;

		_totax = 0;
		_tax = server getVariable ["taxrate",0];
		if(_tax > 0) then {
			_totax = round(_total * (_tax / 100));
		};

		{
			private _owned = _x getvariable ["leasedata",[]];
			_lease = 0;
			{
				_x params ["_id","_cls","_pos","_town"];
				private _data = [_cls,_town] call OT_fnc_getRealEstateData;
				_lease = _lease + (_data select 2);
			}foreach(_owned);
			if(_lease > 0) then {
				_tt = 0;
				if(_tax > 0) then {
					_tt = round(_lease * (_tax / 100));
				};
				_totax = _totax + _tt;
				[_lease-_tt,"Lease Income"] remoteExec ["OT_fnc_money",_x,false];
			};
		}foreach([] call CBA_fnc_players);

		sleep 5;

		_funds = server getVariable ["money",0];
		server setVariable ["money",_funds+_totax];
		_total = _total - _totax;

		_numPlayers = count([] call CBA_fnc_players);
		if(_numPlayers > 0) then {
			if(isNil "_total") then {_total = 0};
			_perPlayer = round(_total / _numPlayers);
			if(_perPlayer > 0) then {
				private _diff = server getVariable ["OT_difficulty",1];
				if(_diff == 0) then {_perPlayer = round(_perPlayer * 1.2)};
				if(_diff == 2) then {_perPlayer = round(_perPlayer * 0.8)};

				_inf remoteExec ["OT_fnc_influenceSilent",0,false];
				{
					_money = _x getVariable ["money",0];
					_x setVariable ["money",_money+_perPlayer,true];
				}foreach([] call CBA_fnc_players);
				format ["Tax income: $%1 (+%2 Influence)",[_perPlayer, 1, 0, true] call CBA_fnc_formatNumber,_inf] remoteExec ["OT_fnc_notifyMinor",0,false];
			}else{
				_inf remoteExec ["OT_fnc_influence",0,false];
			};
		};
	};
};
