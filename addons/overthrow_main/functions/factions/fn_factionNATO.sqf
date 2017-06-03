if (!isServer) exitwith {};

private _abandoned = [];
private _resources = 0;
private _diff = server getVariable ["OT_difficulty",1];

private _nextturn = 3;
private _count = 0;

server setVariable ["NATOattacking","",true];
server setVariable ["NATOattackstart",0,true];
server setVariable ["NATOlastattack",-1200,true];
server setVariable ["QRFpos",nil,true];
server setVariable ["QRFprogress",nil,true];
server setVariable ["QRFstart",nil,true];

private _lastmin = date select 4;
private _lastsched = -1;

sleep 100 + (random 300);

OT_nextNATOTurn = time+(_nextturn * 10);
publicVariable "OT_nextNATOTurn";

while {sleep 10;true} do {
	private _numplayers = count([] call CBA_fnc_players);
	if(_numplayers > 0) then {
		_fobs = server getVariable ["NATOfobs",[]];
		_abandoned = server getVariable ["NATOabandoned",[]];
		_resources = server getVariable ["NATOresources",2000];
		private _countered = (server getVariable ["NATOattacking",""]) != "";
		_knownTargets = spawner getVariable ["NATOknownTargets",[]];
		_schedule = server getVariable ["NATOschedule",[]];

		//scheduler

		if(_lastmin != (date select 4)) then {
			_lastmin = date select 4;
			if(count _schedule > 0) then {
				_item = [];
				if((_lastsched == -1 or _lastsched == 0) and _lastmin >= 30) then {
					_lastsched = 30;
					_item = _schedule select 0;
				}else{
					if((_lastsched == -1 or _lastsched == 30) and _lastmin < 30) then {
						_lastsched = 0;
						_item = _schedule select 0;
					};
				};
				if(count _item > 0) then {
					_schedule deleteAt 0;
					_item params ["_mission","_p1","_p2"];
					if(_mission == "DESTROY") then {
						[_p2] spawn OT_fnc_NATOMissionReconDestroy;
					};
					if(_mission == "CONVOY") then {
						_vehtypes = [];
						_numveh = round(random 2) + 2;
						_count = 0;
						while {_count < _numveh} do {
							_count = _count + 1;
							_vehtypes pushback (selectRandom OT_NATO_Vehicles_Convoy);
						};
						[_vehtypes,[],_p1 select 1,_p2 select 1] spawn OT_fnc_NATOConvoy;
					};
				};
			};
		};


		//Objective QRF and drone intel reports
		if !(_countered) then {
			{
				_x params ["_pos","_name","_cost"];
				if !(_name in _abandoned) then {
					if(_pos call OT_fnc_inSpawnDistance) then {
						_nummil = {side _x == west} count (_pos nearObjects ["CAManBase",500]);
						_numres = {side _x == resistance or captive _x} count (_pos nearObjects 500);
						if(_nummil < _numres) then {
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
					//Drone intel report
					_drone = spawner getVariable [format["drone%1",_name],objNull];
					if((!isNull _drone) and alive _drone) then {
						_intel = _drone getVariable ["OT_seenTargets",[]];
						{
							_added = false;
							_x params ["_ty","_pos","_pri","_obj"];
							_rem = [];
							{
								_o = _x select 3;
								if (_o isEqualTo _obj) then {
									_added = true;
								};
							}foreach(_knownTargets);

							if !(_added) then {
								_knownTargets pushback [_ty,_pos,_pri,_obj,false,time];
							};
						}foreach(_intel);
						_drone setVariable ["OT_seenTargets",[]];
					};
				};
				if(_countered) exitWith {};
			}foreach(OT_objectiveData + OT_airportData);
		};

		//Town QRF (over 100 pop)
		if !(_countered) then {
			_sorted = [OT_allTowns,[],{server getvariable format["population%1",_x]},"DESCEND"] call BIS_fnc_SortBy;
			{
				_town = _x;
				_pos = server getVariable _town;
				_stability = server getVariable format ["stability%1",_town];
				_population = server getVariable format ["population%1",_town];
				if(_pos call OT_fnc_inSpawnDistance) then {
					if(_population > 100 and _stability < 10 and !(_town in _abandoned)) then {
						server setVariable [format ["garrison%1",_town],0,true];
						diag_log format["Overthrow: NATO responding to %1",_town];
						_strength = _population;
						if(_population > _resources) then {_strength = _resources};
						[_town,_strength] spawn OT_fnc_NATOResponseTown;
						server setVariable ["NATOattacking",_town,true];
						server setVariable ["NATOattackstart",time,true];
						_countered = true;
						_resources = _resources - _strength;
					};
				};
				if(_countered) exitWith {};
			}foreach (_sorted);
		};


		//Abandon towers
		{
			_pos = _x select 0;
			_name = _x select 1;
			if !(_name in _abandoned) then {
				if(_pos call OT_fnc_inSpawnDistance) then {
					_nummil = {side _x == west} count (_pos nearObjects ["CAManBase",300]);
					_numres = {side _x == resistance or captive _x} count (_pos nearObjects ["CAManBase",100]);
					if(_nummil < _numres) then {
						_abandoned pushback _name;
						server setVariable ["NATOabandoned",_abandoned,true];
						_name setMarkerColor "ColorGUER";
						_t = _pos call OT_fnc_nearestTown;
						format["Resistance has captured the %1 tower",_name] remoteExec ["OT_fnc_notifyGood",0,false];
						_resources = _resources - 100;
						_countered = true;
					};
				};
			};
			if(_countered) exitWith {};
		}foreach(OT_NATOcomms);


		//Check on FOBs
		_clearedFOBs = [];
		{
			_x params ["_pos","_garrison"];
			_nummil = {side _x == west} count (_pos nearObjects ["CAManBase",300]);
			_numres = {side _x == resistance or captive _x} count (_pos nearObjects 50);
			if(_nummil == 0 and _numres > 0) then {
				_clearedFOBs pushback _x;
				"Cleared NATO FOB" remoteExec ["OT_fnc_notifyMinor",0,false];
				_flag = _pos nearobjects [OT_flag_NATO,50];
				if(count _flag > 0) then{
					deleteVehicle (_flag select 0);
				};
			};
		}foreach(_fobs);

		{
			_fobs deleteAt (_fobs find _x);
		}foreach(_clearedFOBs);


		if(_count >= _nextturn and !_countered) then {
			OT_lastNATOTurn = time;
			publicVariable "OT_lastNATOTurn";
			_lastAttack = time - (server getVariable ["NATOlastattack",-1200]);
			_resourceGain = server getVariable ["NATOresourceGain",0];
			_abandonedSomething = false;
			//NATO turn
			_nextturn = OT_NATOwait + random OT_NATOwait;
			OT_nextNATOTurn = time+(_nextturn * 10);
			publicVariable "OT_nextNATOTurn";

			_count = 0;
			_chance = 98;
			_gain = 25;
			_mul = 25;
			if(_diff > 1) then {_gain = 75;_mul = 50};
			if(_diff < 1) then {_gain = 0;_mul = 15};

			//expire targets
			private _expired = [];
			{
				if((_x select 4) or (time - (_x select 5)) > 2400) then {
					_expired pushback _x;
				};
			}foreach(_knownTargets);
			{
				_knownTargets deleteAt (_knownTargets find _x);
			}foreach(_expired);

			//Recover resources
			_resources = _resources + _gain + _resourceGain + ((count _abandoned) * _mul);

			//Abandon towns (under 50 pop) and counter
			_lastcounter = server getVariable ["NATOlastcounter",""];
			{
				_town = _x;
				_pos = server getVariable _town;
				_stability = server getVariable format ["stability%1",_town];
				_population = server getVariable format ["population%1",_town];
				if(_pos call OT_fnc_inSpawnDistance) then {
					_nummil = {side _x == west} count (_pos nearObjects ["CAManBase",300]);
					_numres = {side _x == resistance or captive _x} count (_pos nearObjects 200);
					if(_nummil < 3 and _numres > 0) then {
						if(_population < 100) then {
							if(_stability < 10 and !(_town in _abandoned)) then {
								//Abandon a town
								_abandoned pushback _town;
								server setVariable [format ["garrison%1",_town],0,true];
								format["NATO has abandoned %1",_town] remoteExec ["OT_fnc_notifyGood",0,false];
								[_town,15] call OT_fnc_stability;
								_abandonedSomething = true;
							};
						}else{
							if(_town != _lastcounter) then {
								if(_lastAttack > 1200 and (_town in _abandoned) and (_resources > _population) and (random 100) > 99) then {
									//Counter a town
									[_town,_population] spawn OT_fnc_NATOCounterTown;
									server setVariable ["NATOlastcounter",_town,true];
									server setVariable ["NATOattacking",_town,true];
									server setVariable ["NATOattackstart",time,true];
									_resources = _resources - _population;
									_countered = true;
								};
							};
						};
					};
				}else{
					if(_population < 100) then {
						if(_stability == 0 and !(_town in _abandoned)) then {
							//Abandon a town
							_abandoned pushback _town;
							server setVariable [format ["garrison%1",_town],0,true];
							format["NATO has abandoned %1",_town] remoteExec ["OT_fnc_notifyGood",0,false];
							_abandonedSomething = true;
						};
					};
				};
				if(_abandonedSomething or _countered) exitWith {};
			}foreach (OT_allTowns);

			//Spawn missing drones & counter objectives
			{
				_x params ["_pos","_name","_pri"];
				if(_lastAttack > 1200 and (_name != _lastcounter) and (_name in _abandoned) and (_resources > _pri) and (random 100) > 99) exitWith {
					//Counter an objective

					[_name,_pri] spawn OT_fnc_NATOCounterObjective;
					server setVariable ["NATOlastcounter",_name,true];
					server setVariable ["NATOattacking",_name,true];
					server setVariable ["NATOattackstart",time,true];
					_countered = true;
					_resources = _resources - _pri;
				};

				if !(_name in _abandoned) then {
					_drone = spawner getVariable [format["drone%1",_name],objNull];
					if((isNull _drone or !alive _drone) and _resources > 10) then {
						_targets = [];
						{
							_town = _x;
							_p = server getVariable _town;
							if((_p distance _pos) < 3000) then {
								_stability = server getVariable format["stability%1",_town];
								if((_town in _abandoned) or (_stability < 50)) then {
									_targets pushback _p;
								};
							};
						}foreach(OT_allTowns);

						{
							_x params ["_p","_name"];
							if((_p distance _pos) < 3000) then {
								if (_name in _abandoned) then {
									_targets pushback _p;
								};
							};
						}foreach(OT_NATOobjectives + OT_NATOcomms);

						{
							_x params ["_ty","_p"];
							if((_ty == "FOB") and (_p distance _pos) < 3000) then {
								_targets pushback _p;
							};
						}foreach(_knownTargets);

						if(count _targets > 0) then {
							_targets = [_targets,[],{random 100},"ASCEND"] call BIS_fnc_sortBy;
							_group = createGroup blufor;
							_group deleteGroupWhenEmpty true;
							_p = [_pos,0,0,false,[0,0],[100,OT_NATO_Vehicles_ReconDrone]] call SHK_pos;
							_drone = createVehicle [OT_NATO_Vehicles_ReconDrone, _p, [], 0,""];

							createVehicleCrew _drone;
							{
								[_x] joinSilent _group;
							}foreach(crew _drone);


							spawner setVariable [format["drone%1",_name],_drone,false];
							_resources = _resources - 10;

							{
								_wp = _group addWaypoint [_x,300];
								_wp setWaypointType "MOVE";
								_wp setWaypointBehaviour "COMBAT";
								_wp setWaypointSpeed "FULL";
								_wp setWaypointTimeout [20,45,60];
							}foreach(_targets);

							_wp = _group addWaypoint [_pos,300];
							_wp setWaypointType "MOVE";
							_wp setWaypointBehaviour "COMBAT";
							_wp setWaypointSpeed "FULL";
							_wp setWaypointTimeout [10,20,60];

							_wp = _group addWaypoint [_pos,0];
							_wp setWaypointType "CYCLE";

							{
								_x addCuratorEditableObjects [[_drone]];
							}foreach(allCurators);

							_drone spawn OT_fnc_NATODrone;
						};
					};
				};
				if(_resources <= 0) exitWith {_resources = 0};
			}foreach(OT_objectiveData + OT_airportData);

			//Decide on spend
			_spend = 0;
			if(_resources > 500) then {
				_spend = 500;
			};
			if(_resources > 1000) then {
				_spend = 800;
				_chance = 95;
			};
			if(_resources > 1500) then {
				_spend = 1200;
				_chance = 90;
			};
			if(_resources > 2500) then {
				_spend = 1500;
				_chance = 80;
			};

			if(!(spawner getVariable ["NATOdeploying",false]) and (_spend > 500) and (count _fobs) < 3 and (random 100) > _chance) then {
				//Deploy an FOB
				_lowest = "";
				{
					_stability = server getVariable [format["stability%1",_x],100];
					if((_x in _abandoned) or _stability < 50) exitWith {
						_lowest = _x;
					};
				}foreach([OT_allTowns,[],{random 100},"DESCEND"] call BIS_fnc_sortBy);
				if(_lowest != "") then {
					_townPos = (server getVariable _lowest);
					_pp = [_townPos,random 360,2000] call SHK_pos;
					_gotpos = [];
					{
						_pos = _x select 0;
						_pos set [2,0];
						_bb = _pos call OT_fnc_nearestObjective;
						_bpos = _bb select 0;

						_near = false;
						{
							_pb = _x select 0;
							if(_pb distance _pos < 500) then {
								_near = true;
							};
						}foreach(_fobs);

						if(!_near and (_pos distance _bpos) > 400 and (_pos distance _townPos) > 250) exitWith {
							_gotpos = _pos;
						};
					}foreach (selectBestPlaces [_pp, 1000,"(1 - forest - trees) * (1 - houses) * (1 - sea)",5,4]);
					if(count _gotpos > 0) then {
						_spend = _spend - 500;
						_resources = _resources - 500;
						spawner setVariable ["NATOdeploying",true,false];
						[_gotpos] spawn OT_fnc_NATOMissionDeployFOB;
					};
				};
			};

			if(_spend >= 20) then {
				{
					_town = _x;
					_townPos = server getVariable _town;
					_current = server getVariable format ["garrison%1",_town];;
					_stability = server getVariable format ["stability%1",_town];
					_population = server getVariable format ["population%1",_town];
					if(_stability > 10 and !(_town in _abandoned)) then {
						_max = round(_population / 40);
						if(_max < 4) then {_max = 4};
						_garrison = 2+round((1-(_stability / 100)) * _max);
						if(_town in OT_NATO_priority) then {
							_garrison = round(_garrison * 2);
						};
						_need = _garrison - _current;
						if(_need < 0) then {_need = 0};
						if(_need > 1 and _spend >= 20) then {
							_spend = _spend - 20;
							_resources = _resources - 20;
							_x spawn OT_fnc_NATOsendGendarmerie;
						};
					};
					if(_spend < 20) exitWith {};
				}foreach ([OT_allTowns,[],{random 100},"DESCEND"] call BIS_fnc_sortBy);
			};

			//Schedule some missions
			if(_spend > 0) then {
				_targets = [_knownTargets,[],{_x select 2},"DESCEND"] call BIS_fnc_sortBy;
				{
					_x params ["_ty","_pos","_pri","_obj","_done"];
					if !(_done) then {
						if(_ty == "WH" or _ty == "PS" or _ty == "WS") then {
							if(_spend > 250 and (random 100) > _chance) then {
								_schedule pushback ["DESTROY",_ty,_pos];
								_spend = _spend - 250;
								_resources = _resources -250;
								_x set [4,true];
							};
						};
					};
				}foreach(_targets);
				if(_spend > 500 and (random 100) > _chance) then {
					_low = 50;
					_lowest = "";
					{
						_stability = server getVariable [format["stability%1",_x],100];
						if(!(_x in _abandoned) and _stability < _low) exitWith {
							_lowest = _x;
						};
					}foreach([OT_allTowns,[],{random 100},"DESCEND"] call BIS_fnc_sortBy);

					if(_lowest == "") then {
						//Could not find NATO controlled town under 50% stability, looking for resistance-controlled town above 50%
						{
							_stability = server getVariable [format["stability%1",_x],100];
							if((_x in _abandoned) and _stability > _low) exitWith {
								_lowest = _x;
							};
						}foreach([OT_allTowns,[],{random 100},"DESCEND"] call BIS_fnc_sortBy);
					};

					if(_lowest != "") then {
						_townPos = server getVariable _lowest;
						_start = ([OT_NATOobjectives,[],{(_x select 0) distance _townPos},"ASCEND"] call BIS_fnc_SortBy) select 0;
						_startName = _start select 1;
						_startPos = _start select 0;
						_end = [];
						{
							_x params ["_p","_n"];
							if((_n != _startName) and !(_n in _abandoned) and ([_p,_startPos] call OT_fnc_regionIsConnected)) exitWith {
								_end = _x;
							};
						}foreach([OT_NATOobjectives,[],{random 100},"DESCEND"] call BIS_fnc_sortBy);
						if(count _end > 0) then {
							//Schedule a convoy
							_spend = _spend - 500;
							_resources = _resources - 500;
							_schedule pushback ["CONVOY",_start,_end];
						};
					};
				};
			};

			//Upgrade garrisons
			{
				_x params ["_pos","_name","_pri"];
				if !(_name in _abandoned) then {
					_garrison = server getvariable [format["garrison%1",_name],0];
					_max = 8;
					if(_pri > 300) then {
						_max = 12;
					};
					if(_pri > 800) then {
						_max = 24;
					};
					if(_pri > 1200) then {
						_max = 32;
					};
					if(!(_pos call OT_fnc_inSpawnDistance) and (_garrison < _max) and (_spend > 150) and  (random 100 > _chance)) then {
						server setvariable [format["garrison%1",_name],_garrison+4,true];
						_spend = _spend - 150;
						_resources = _resources - 150;
					};
				};
			}foreach(OT_NATOobjectives);

			//Upgrade FOBs
			{
				_x params ["_pos","_garrison","_upgrades"];
				_max = 16;
				if((_garrison < _max) and (_spend > 150) and  (random 100 > _chance)) exitWith {
					_x set [1,_garrison + 4];
					_spend = _spend - 150;
					_resources = _resources - 150;
					_group = creategroup blufor;
					_group deleteGroupWhenEmpty true;
					_count = 0;
					while {_count < 4} do {
						_start = [[[_pos,50]]] call BIS_fnc_randomPos;

						_civ = _group createUnit [OT_NATO_Units_LevelOne call BIS_fnc_selectRandom, _start, [],0, "NONE"];
						_civ setVariable ["garrison","HQ",false];
						_civ setRank "LIEUTENANT";
						_civ setVariable ["VCOM_NOPATHING_Unit",true,false];
						_civ setBehaviour "SAFE";

						_count = _count + 1;
					};
					_group call OT_fnc_initMilitaryPatrol;
				};
				if(!("Mortar" in _upgrades) and (_spend > 300) and (random 100 > _chance)) exitWith {
					_spend = _spend - 300;
					_resources = _resources - 300;
					_upgrades pushback "Mortar";
					[_pos,["Mortar"]] spawn OT_fnc_NATOupgradeFOB;
				};
				if(!("Barriers" in _upgrades) and (_spend > 50) and (random 100 > _chance)) exitWith {
					_spend = _spend - 50;
					_resources = _resources - 50;
					_upgrades pushback "Barriers";
					[_pos,["Barriers"]] spawn OT_fnc_NATOupgradeFOB;
				};
				if(!("HMG" in _upgrades) and (_spend > 150) and (random 100 > _chance)) exitWith {
					_spend = _spend - 150;
					_resources = _resources - 150;
					_upgrades pushback "HMG";
					[_pos,["HMG"]] spawn OT_fnc_NATOupgradeFOB;
				};
			}foreach(_fobs);
		};
		//Finish
		if(_resources > 2500) then {_resources = 2500};
		server setVariable ["NATOresources",_resources,true];
		server setVariable ["NATOabandoned",_abandoned,true];
		spawner setVariable ["NATOknownTargets",_knownTargets,true];
		server setVariable ["NATOschedule",_schedule,true];
		server setVariable ["NATOfobs",_fobs,true];
	};
	_count = _count + 1;
};
