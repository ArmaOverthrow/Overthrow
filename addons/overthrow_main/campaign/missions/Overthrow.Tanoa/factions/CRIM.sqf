if (!isServer) exitwith {};

_leaderpos = objNULL;
OT_CRIMmobsters = [];

waitUntil {!isNil "OT_NATOInitDone"};

_activemobsters = server getVariable ["activemobsters",false];
if((server getVariable "StartupType") == "NEW" or (server getVariable ["CRIMversion",0]) < OT_CRIMversion) then {
	diag_log "Overthrow: Generating bandits";
	server setVariable ["CRIMversion",OT_CRIMversion,false];
	{
		_town = _x;
		_posTown = server getVariable _town;
		_mSize = 300;
		if(_town in OT_capitals) then {
			_mSize = 800;
		};
		_garrison = 0;
		_stability = server getVariable format ["stability%1",_town];
		server setVariable [format["crimnew%1",_town],false,false];
		server setVariable [format["crimadd%1",_town],0,false];
		if(_stability < 30) then {
			_garrison = 1 + round(random 2);
			_building = [_posTown, OT_crimHouses] call OT_fnc_getRandomBuilding;
			if(isNil "_building") then {
				_leaderpos = [[[_posTown,_mSize]]] call BIS_fnc_randomPos;
			}else{
				_leaderpos = getpos _building;
			};

			server setVariable [format["crimleader%1",_town],_leaderpos,false];
		}else{
			server setVariable [format["crimleader%1",_town],false,false];
		};
		server setVariable [format ["numcrims%1",_x],_garrison,false];
		server setVariable [format ["timecrims%1",_x],0,false];
	}foreach (OT_allTowns);

	(OT_loadingMessages call BIS_fnc_selectRandom) remoteExec['blackFaded',0];

	_count = 0;
	_camps = 20;

	server setVariable ["activemobsters",[],false];
	_mobsters = server getVariable "activemobsters";
	_t = 0;

	private _positions = call compileFinal preprocessFileLineNumbers "data\bandits.sqf";
	if((server getvariable ["OT_difficulty",1]) == 0) then {_camps = 10};
	while {_count < _camps} do {
		_pos = selectRandom _positions;
		_mdist = 2000;
		if(count _mobsters > 0) then {
			_mdist = _pos distance ((_pos call OT_fnc_nearestMobster) select 0);
		};
		if(_mdist > 500) then {
			_t = _t + 1;
			_count = _count + 1;
			_garrison = 4 + round(random 4);

			_mobsters pushback [_pos,_t];
			server setVariable [format["crimgarrison%1",_t],_garrison];
			server setVariable [format["mobleader%1",_t],_pos];
		};
	};
	_positions = [];

	diag_log format ["Overthrow: Generated %1 bandit camps",_count];
	server setVariable ["activemobsters",_mobsters,true];
};
OT_CRIMInitDone = true;
publicVariable "OT_CRIMInitDone";

_sleeptime = 20;

while {true} do {
	_numplayers = count([] call CBA_fnc_players);
	if(_numplayers > 0) then {
		sleep _sleeptime;
		{
			_town = _x;
			_posTown = server getVariable _town;
			_mSize = 300;
			if(_town in OT_capitals) then {
				_mSize = 800;
			};
			_stability = server getVariable format ["stability%1",_town];
			if((_stability < 30) || (_town in (server getvariable "NATOabandoned"))) then {
				_time = server getVariable [format ["timecrims%1",_town],0];
				_num = server getVariable [format ["numcrims%1",_town],0];

				if(_stability < 60) then {
					_leaderpos = server getVariable [format["crimleader%1",_town],false];
					_mob = _posTown call OT_fnc_nearestMobster;
					_mobpos = _mob select 0;

					if ((typeName _leaderpos) == "ARRAY") then {
						server setVariable [format ["timecrims%1",_x],_time+_sleeptime,false];
						_chance = 10;
						_max = 3;
						if(_town in (server getVariable ["NATOabandoned",[]])) then {
							_chance = 15;
							_max = 5;
						};

						if(((random 100) < _chance) and _num < _max) then {
							_numadd = round(random 2);
							[_leaderpos,_numadd,_x] spawn sendCrims;
						};
					}else{
						//New leader spawn

						_building = [_posTown, OT_crimHouses] call OT_fnc_getRandomBuilding;
						if(isNil "_building") then {
							_leaderpos = [[[_posTown,50]]] call BIS_fnc_randomPos;
						}else{
							_leaderpos = getpos _building;
						};

						[_leaderpos,_x] spawn newLeader;

						server setVariable [format ["timecrims%1",_x],0,false];
					};
				};
			};
			sleep 0.1;
		}foreach (OT_allTowns);
	};

	{
		if(side _x == east and count (units _x) == 0) then {
			deleteGroup _x;
		};
		if(side _x == civilian and count (units _x) == 0) then {
			deleteGroup _x;
		};
	}foreach(allGroups);

	_sleeptime = OT_CRIMwait + round(random OT_CRIMwait);
};
