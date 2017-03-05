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

		//Do production/wages

		private _wages = 0;
		{
			private _perhr = ["Tanoa","WAGE",0] call OT_fnc_getPrice;
			if(_x == "Factory") then {_perhr = _perhr *2};
		    _num = server getVariable [format["%1employ",_x],0];
			_enum = _num;
			if(_enum > 20) then {
				_enum = 20;
			};
		    _wages = _wages + (_num * _perhr);
			_data = _x call OT_fnc_getEconomicData;

			_pos = _data select 0;
			_outnum = 2 * _num;
			_innum = 2 * _num;
			_intotal = _innum;
			if(_num > 0) then {
				if(count _data == 2 and _x != "Factory") then {
					//Just passive income
					_income = _enum * 200;
					[_income] call OT_fnc_resistanceFunds;
				};
				if(count _data == 3) then {
					//Turns something into money
					_input = _data select 2;
					_income = 0;
					_sellprice = ["Tanoa",_input,0] call OT_fnc_getSellPrice;
					{
						_stock = _x call OT_fnc_unitStock;
						_c = _x;
						{
							_x params ["_cls","_amt"];
							if(_cls == _input) exitWith {
								if(_amt >= _innum) then {
									[_target, _cls, _innum] call CBA_fnc_removeItemCargo;
									_income = _income + (_sellprice * _innum);
								}else{
									[_target, _cls, _amt] call CBA_fnc_removeItemCargo;
									_innum = _innum - _amt;
									_income = _income + (_sellprice * _amt);
								};
							};
						}foreach(_stock);
					}foreach(_pos nearObjects [OT_item_CargoContainer, 50]);
					[_income] call OT_fnc_resistanceFunds;
				};
				if(count _data == 4) then {
					//Turns something into something (or creates something from nothing)
				    _input = _data select 2;
				    _output = _data select 3;
					_container = _pos nearestObject OT_item_CargoContainer;
					if(_container isEqualTo objNull) then {
						_p = _pos findEmptyPosition [0,100,OT_item_CargoContainer];
						_container = OT_item_CargoContainer createVehicle _p;
						_container setVariable ["owner",(server getVariable ["generals",[]]) select 0,true];
						clearWeaponCargoGlobal _container;
						clearMagazineCargoGlobal _container;
						clearBackpackCargoGlobal _container;
						clearItemCargoGlobal _container;
					};
				    if(_input != "") then {
						_inputnum = 0;
						{
							_c = _x;
							{
								_x params ["_cls","_amt"];
								if(_cls == _input) exitWith {
									if(_amt >= _innum) then {
										[_c, _cls, _innum] call CBA_fnc_removeItemCargo;
										_inputnum = _inputnum + _innum;
									}else{
										[_c, _cls, _amt] call CBA_fnc_removeItemCargo;
										_innum = _innum - _amt;
										_inputnum = _inputnum + _amt;
									};
								};
							}foreach(_c call OT_fnc_unitStock);
						}foreach(_pos nearObjects [OT_item_CargoContainer, 50]);
						_outnum = round (_outnum * (_inputnum / _intotal));
				    };
				    if(_output != "" and _outnum > 0) then {
						_container addItemCargoGlobal [_output,_outnum];
				    };
				};
			};
		}foreach(server getVariable ["GEURowned",[]]);

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
				private _diff = server getVariable ["OT_difficulty",1];
				if(_diff == 0) then {_perPlayer = round(_perPlayer * 1.2)};
				if(_diff == 2) then {_perPlayer = round(_perPlayer * 0.8)};

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
};
