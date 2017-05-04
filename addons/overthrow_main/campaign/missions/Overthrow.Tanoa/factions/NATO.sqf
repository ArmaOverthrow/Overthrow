if (!isServer) exitwith {};

private _abandoned = [];
private _resources = 0;
private _diff = server getVariable ["OT_difficulty",1];

private _nextturn = OT_NATOwait + random OT_NATOwait;
private _count = 0;

server setVariable ["NATOattacking","",true];
server setVariable ["NATOattackstart",0,true];

while {sleep 10;true} do {
	private _numplayers = count([] call CBA_fnc_players);
	if(_numplayers > 0) then {
		_abandoned = server getVariable ["NATOabandoned",[]];
		_resources = server getVariable ["NATOresources",0];
		private _countered = (server getVariable ["NATOattacking",""]) != "";

		//Objective QRF
		if !(_countered) then {
			{
				_x params ["_pos","_name","_cost"];
				if !(_name in _abandoned) then {
					if(_pos call OT_fnc_inSpawnDistance) then {
						_nummil = {side _x == west} count (_pos nearObjects ["CAManBase",300]);
						_numres = {side _x == resistance or captive _x} count (_pos nearObjects 200);
						if(_nummil < 3 and _numres > 0) then {
							_countered = true;
							server setVariable ["NATOattacking",_name,true];
							server setVariable ["NATOattackstart",time,true];
							diag_log format["Overthrow: NATO responding to %1",_name];
							if(_resources < _cost) then {_cost = _resources};
							[_name,_cost] spawn OT_fnc_NATOResponseObjective;
							_name setMarkerAlpha 1;
							_resources = _resources - _cost;
						};
					};
				};
				if(_countered) exitWith {};
			}foreach(OT_NATOobjectives);
		};

		//Town QRF (over 50 pop)
		if !(_countered) then {
			_sorted = [OT_allTowns,[],{server getvariable format["population%1",_x]},"DESCEND"] call BIS_fnc_SortBy;
			{
				_town = _x;
				_pos = server getVariable _town;
				_stability = server getVariable format ["stability%1",_town];
				_population = server getVariable format ["population%1",_town];
				if(_pos call OT_fnc_inSpawnDistance) then {
					_nummil = {side _x == west} count (_pos nearObjects ["CAManBase",300]);
					_numres = {side _x == resistance or captive _x} count (_pos nearObjects 200);
					if(_nummil < 3 and _numres > 0) then {
						if(_population > 50 and _stability < 10 and !(_town in _abandoned) and (_resources >= _population)) then {
							server setVariable [format ["garrison%1",_town],0,true];
							diag_log format["Overthrow: NATO responding to %1",_town];
							[_town,_population] spawn OT_fnc_NATOResponseTown;
							server setVariable ["NATOattacking",_town,true];
							server setVariable ["NATOattackstart",time,true];
							_countered = true;
							_resources = _resources - _population;
						};
					};
				};
				if(_countered) exitWith {};
			}foreach (_sorted);
		};



		if(_count >= _nextturn and !_countered) then {
			_abandonedSomething = false;
			//NATO turn
			_nextturn = OT_NATOwait + random OT_NATOwait;
			_count = 0;

			//Abandon towns (under 50 pop)
			{
				_town = _x;
				_pos = server getVariable _town;
				_stability = server getVariable format ["stability%1",_town];
				_population = server getVariable format ["population%1",_town];
				if(_pos call OT_fnc_inSpawnDistance) then {
					_nummil = {side _x == west} count (_pos nearObjects ["CAManBase",300]);
					_numres = {side _x == resistance or captive _x} count (_pos nearObjects 200);
					if(_nummil < 3 and _numres > 0) then {
						if(_population < 50) then {
							if(_stability < 10 and !(_town in _abandoned)) then {
								_abandoned pushback _town;
								server setVariable [format ["garrison%1",_town],0,true];
								format["NATO has abandoned %1",_town] remoteExec ["notify_good",0,false];
								[_town,15] call stability;
							};
						};
					};
				};
				if(_abandonedSomething) exitWith {};
			}foreach (OT_allTowns);

			if(!_abandonedSomething) then {
				//Abandon towers
				{
					_pos = _x select 0;
					_name = _x select 1;
					if !(_name in _abandoned) then {
						if(_pos call OT_fnc_inSpawnDistance) then {
							_nummil = {side _x == west} count (_pos nearObjects ["CAManBase",300]);
							_numres = {side _x == resistance or captive _x} count (_pos nearObjects ["CAManBase",100]);
							if(_nummil < 3 and _numres > 0) then {
								_abandoned pushback _name;
								server setVariable ["NATOabandoned",_abandoned,true];
								_name setMarkerColor "ColorGUER";
								_t = _pos call OT_fnc_nearestTown;
								format["Resistance has captured the %1 tower",_name] remoteExec ["notify_good",0,false];
								_resources = _resources - 100;
								_abandonedSomething = true;
							};
						};
					};
					if(_abandonedSomething) exitWith {};
				}foreach(OT_NATOcomms);
			};

			//Recover resources
		};
		//Finish
		if(_resources > 2500) then {_resources = 2500};
		server setVariable ["NATOresources",_resources,true];
		server setVariable ["NATOabandoned",_abandoned,true];
	};
	_count = _count + 1;
};
