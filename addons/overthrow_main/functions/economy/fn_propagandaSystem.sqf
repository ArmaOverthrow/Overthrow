if !(isServer) exitWith {};
propaganda_system_lasthour = 0;
waitUntil {sleep 1;server getVariable ["StartupType",""] != ""};

sleep 20;

["propaganda_system","_counter%10 isEqualTo 0 && {!((date#3) isEqualTo propaganda_system_lasthour)}","
	private _numplayers = count([] call CBA_fnc_players);
	propaganda_system_lasthour = date select 3;
	if(_numplayers > 0) then {
		_totalStability = 0;
		_totalPop = 0;
		_abandoned = server getVariable [""NATOabandoned"",[]];
		{
			private _town = _x;
			private _townPos = server getVariable _town;
			private _commsAbandoned = ((_townPos call OT_fnc_nearestComms) select 1) in _abandoned;
			private _stability = server getVariable format[""stability%1"",_town];
			private _pop = server getVariable format[""population%1"",_town];
			_totalStability = _totalStability + _stability;
			_totalPop = _totalPop + _pop;
			if(_town in _abandoned) then {
				if(_commsAbandoned) then {
					[_town,1] call OT_fnc_stability;
				}else{
					if((random 100) > 80) then {
						[_town,-1] call OT_fnc_stability;
					};
				};
			}else{
				if(_commsAbandoned) then {
					_police = server getVariable [format[""garrison%1"",_town],0];
					_chance = 20;
					if(_police < 4) then {
						_chance = 50;
					};
					if(_police < 2) then {
						_chance = 80;
					};
					if((random 100) < _chance) then {
						[_town,-2] call OT_fnc_stability;
					}else{
						if((random 100) > 50) then {
							[_town,-1] call OT_fnc_stability;
						};
					};
				};
			};
		}foreach(OT_allTowns);
		server setVariable [format[""stability%1"",OT_nation],_totalStability / (count OT_allTowns),true];
		server setVariable [format[""population%1"",OT_nation],_totalPop,true];
	};
"] call OT_fnc_addActionLoop;
