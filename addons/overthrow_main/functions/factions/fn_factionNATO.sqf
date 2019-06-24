if (!isServer) exitwith {};

private _abandoned = [];
private _resources = 0;
private _diff = server getVariable ["OT_difficulty",1];

private _nextturn = 30; //wait 30 seconds from game start until spending resources
private _count = 0;

server setVariable ["NATOattacking","",true];
server setVariable ["NATOattackstart",0,true];
server setVariable ["NATOlastattack",0,true];
server setVariable ["QRFpos",nil,true];
server setVariable ["QRFprogress",nil,true];
server setVariable ["QRFstart",nil,true];

private _lastmin = date select 4;
private _lastsched = -1;

OT_nextNATOTurn = time+_nextturn;
publicVariable "OT_nextNATOTurn";

[{

	params ["_handle","_vars"];
	_vars params ["_abandoned","_resources","_diff","_nextturn","_count","_lastmin","_lastsched"];

	private _numplayers = count([] call CBA_fnc_players);
	if(_numplayers > 0) then {
		_fobs = server getVariable ["NATOfobs",[]];
		_abandoned = server getVariable ["NATOabandoned",[]];
		_resources = server getVariable ["NATOresources",2000];
		private _countered = (server getVariable ["NATOattacking",""]) != "";
		_knownTargets = spawner getVariable ["NATOknownTargets",[]];
		_schedule = server getVariable ["NATOschedule",[]];
		private _popControl = call OT_fnc_getControlledPopulation;

		//scheduler
		if(count _schedule > 0) then {
			private _item = [];
			private _idx = -1;
			private _remove = [];
			{
				_x params ["_id","_ty","_p1","_p2","_hour"];
				if(!isNil "_hour" && _hour < 23 && _hour == (date select 3)) exitWith {_remove pushback _forEachIndex;_idx = _forEachIndex; _item = _x};
				if(!isNil "_hour" && _hour > 23) then {_remove pushback _forEachIndex}; //remove old bugged schedules from v0.7.7.3
			}forEach(_schedule);
			if(_idx > -1) then {
				_item params ["_id","_mission","_p1","_p2"];
				if(_mission isEqualTo "CONVOY") then {
					_vehtypes = [];
					_numveh = round(random 2) + 2;
					_count = 0;
					while {_count < _numveh} do {
						_count = _count + 1;
						_vehtypes pushback (selectRandom OT_NATO_Vehicles_Convoy);
					};
					[_vehtypes,[],_p1 select 1,_p2 select 1,_id] spawn OT_fnc_NATOConvoy;
				};
			};
			{
				_schedule deleteAt _x;
			}foreach(_remove);
			server setVariable ["NATOschedule",_schedule];
		};


		//Objective QRF && drone intel reports
		if !(_countered) then {
			{
				_x params ["_pos","_name","_cost"];
				if !(_name in _abandoned) then {
					if(_pos call OT_fnc_inSpawnDistance) then {
						_numgarrison = server getVariable [format["garrison%1"],0];
						_nummil = {side _x isEqualTo west} count (_pos nearObjects ["CAManBase",500]);
						_numres = {side _x isEqualTo resistance || captive _x} count (_pos nearObjects ["CAManBase",100]);
						if(_numgarrison < 4 && _nummil < _numres) then {
							_countered = true;
							private _m = 1;
							if(_popControl > 1000) then {_m = 2};
							if(_popControl > 2000) then {_m = 4};
							_cost = _cost * _m;
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
					if((!isNull _drone) && {alive _drone}) then {
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

		//Respond to town stability changes
		if !(_countered) then {
			_sorted = [OT_allTowns,[],{server getvariable format["population%1",_x]},"DESCEND"] call BIS_fnc_SortBy;
			{
				_town = _x;
				_pos = server getVariable _town;
				_stability = server getVariable format ["stability%1",_town];
				_population = server getVariable format ["population%1",_town];
				_garrison = server getVariable format ["garrison%1",_town];
				//Limit towns checked to those within range of players
				if(_pos call OT_fnc_inSpawnDistance) then {
					//Send QRF to Town with >100 population
					if(_population >= 100 && {_stability isEqualTo 0} && {!(_town in _abandoned)}) then {
						server setVariable [format ["garrison%1",_town],0,true];
						diag_log format["Overthrow: NATO responding to %1",_town];
						private _m = 3;
						if(_popControl > 1000) then {_m = 4};
						if(_popControl > 2000) then {_m = 5};

						_strength = _population * _m;
						if(_strength > _resources) then {_strength = _resources};
						if(_town in OT_NATO_priority) then {_strength = _resources};
						[_town,_strength] spawn OT_fnc_NATOResponseTown;
						server setVariable ["NATOattacking",_town,true];
						server setVariable ["NATOattackstart",time,true];
						_countered = true;
						_resources = _resources - _strength;
					}else{
						//Send patrol to towns low in stability (new in v0.7.8.5)
						if(_resources > 250 && _stability < 30 && {!(_town in _abandoned)} && !(server getVariable [format["NATOpatrolsent%1",_town],false])) then {
							([_pos] call OT_fnc_NATOGetAttackVectors) params ["_ground","_air"];
							if(count _ground > 0) then {
								server setVariable [format["NATOpatrolsent%1",_town],true];
								(_ground select 0) params ["_obpos","_obname"];
								private _dir = _pos getDir _obpos;
								private _ao = [_pos,_dir] call OT_fnc_getAO;
								_resources = _resources - 75;
								call {
									if(_population < 100) exitWith {
										//Just send the troops
									};
									if(_population < 500) exitWith {
										if((random 100) < (_diff * 2)) then {
											//small chance of a support vehicle
											_resources = _resources - 100;
											[_obpos,_pos,100,0] spawn OT_fnc_NATOGroundSupport;
											diag_log format["Overthrow: NATO Sent ground support to %1 from %2",_town,_obname];
										};
									};
									//population > 500, definitely send support
									_resources = _resources - 100;
									[_obpos,_pos,100,0] spawn OT_fnc_NATOGroundSupport;
								};
								diag_log format["Overthrow: NATO Sent ground forces to %1 from %2",_town,_obname];
								[_obpos,_ao,_pos,false,5] spawn OT_fnc_NATOGroundReinforcements;
							}else{
								if(count _air > 0 && _population > 500) then {
									server setVariable [format["NATOpatrolsent%1",_town],true];
									(_air select 0) params ["_obpos","_obname"];

									if((random 100) < (_diff * 2)) then {
										//small chance of CAS
										_resources = _resources - 150;
										[_obpos,_pos,0] spawn OT_fnc_NATOAirSupport;
										diag_log format["Overthrow: NATO Sent CAS to %1 from %2",_town,_obname];
									};
									private _dir = _pos getDir _obpos;
									private _ao = [_pos,_dir] call OT_fnc_getAO;
									_resources = _resources - 100;

									[_obpos,_ao,_pos,true,15] spawn OT_fnc_NATOGroundReinforcements;
									diag_log format["Overthrow: NATO Sent ground forces by air to %1 from %2",_town,_obname];
								};
							};
						};
					}

				};
				//Abandon Town with <100 population if it has dropped to 0 stability
				if(_population < 100 && {(_stability isEqualTo 0)} && {!(_town in _abandoned)}) then {
					_abandoned pushback _town;
					server setVariable ["NATOabandoned",_abandoned,true];
					server setVariable [format ["garrison%1",_town],0,true];
					format["NATO has abandoned %1",_town] remoteExec ["OT_fnc_notifyGood",0,false];
					_countered = true;
					diag_log format["Overthrow: NATO has abandoned %1",_town];
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
					_nummil = {side _x isEqualTo west} count (_pos nearObjects ["CAManBase",300]);
					_numres = {side _x isEqualTo resistance || captive _x} count (_pos nearObjects ["CAManBase",100]);
					if(_nummil < _numres) then {
						_abandoned pushback _name;
						server setVariable ["NATOabandoned",_abandoned,true];
						_name setMarkerColor "ColorGUER";
						_t = _pos call OT_fnc_nearestTown;
						format["Resistance has captured the %1 tower",_name] remoteExec ["OT_fnc_notifyGood",0,false];
						_resources = _resources - 100;
						_countered = true;
						format["%1_restrict",_name] setMarkerAlpha 0;
					};
				};
			};
			if(_countered) exitWith {};
		}foreach(OT_NATOcomms);

		//Check on FOBs
		_clearedFOBs = [];
		{
			_x params ["_pos","_garrison"];
			_nummil = {side _x isEqualTo west} count (_pos nearObjects ["CAManBase",300]);
			_numres = {side _x isEqualTo resistance || captive _x} count (_pos nearObjects ["CAManBase",50]);
			if(_nummil isEqualTo 0 && {_numres > 0}) then {
				_clearedFOBs pushback _x;
				"Cleared NATO FOB" remoteExec ["OT_fnc_notifyMinor",0,false];
				_flag = _pos nearobjects [OT_flag_NATO,50];
				if(count _flag > 0) then{
					deleteVehicle (_flag select 0);
				};
				deleteMarker format["natofob%1",str _pos];
			};
		}foreach(_fobs);

		{
			_fobs deleteAt (_fobs find _x);
		}foreach(_clearedFOBs);

		//expire targets
		private _expired = [];
		{
			if((time - (_x select 5)) > 800) then {
				_expired pushback _x;
			};
		}foreach(_knownTargets);
		{
			_knownTargets deleteAt (_knownTargets find _x);
		}foreach(_expired);

		//Scramble jets and helos

		{
			_x params ["_ty","_pos","_threat","_target",["_done",false]];
			if(!_done) then {
				private _chance = 85;
				if(_diff > 1) then {_chance = 80};
				if(_diff < 1) then {_chance = 90};
				if(_popControl > 1000) then {_chance = _chance - 5};
				if(_popControl > 2000) then {_chance = _chance - 10};

				if(_ty isEqualTo "P" || _ty isEqualTo "H") then {
					if(_resources > 500 && ((random 100) > _chance)) then {
						[_target,_pos] spawn OT_fnc_NATOScrambleJet;
						_resources = _resources - 500;
						_x set [4,true];
						if(([OT_nation] call OT_fnc_support) > (random 250)) then {
							format["Intel reports that NATO has scrambled a jet to intercept %1",(typeof _target) call OT_fnc_vehicleGetName]
						};
						_countered = true;
					};
				};
				if(_ty isEqualTo "V" && _threat > 100) then {
					if(_resources > 500 && ((random 100) > _chance)) then {
						[_target,_pos] spawn OT_fnc_NATOScrambleHelicopter;
						_resources = _resources - 350;
						_x set [4,true];
						if(([OT_nation] call OT_fnc_support) > (random 250)) then {
							format["Intel reports that NATO has scrambled a helicopter to intercept %1",(typeof _target) call OT_fnc_vehicleGetName]
						};
						_countered = true;
					};
				};
			};
			if(_countered) exitWith {};
		}foreach(_knownTargets);

		//NATO gets to play if it hasn't reacted to anything
		if(time >= OT_nextNATOTurn && {!_countered}) then {
			OT_lastNATOTurn = time;
			publicVariable "OT_lastNATOTurn";
			_lastAttack = time - (server getVariable ["NATOlastattack",0]);
			_resourceGain = server getVariable ["NATOresourceGain",0];
			//NATO turn
			_nextturn = OT_NATOwait + random OT_NATOwait;
			OT_nextNATOTurn = time+_nextturn;
			publicVariable "OT_nextNATOTurn";

			_count = 0;
			_chance = 98;
			_gain = 75;
			_mul = 25;
			if(_diff > 1) then {_gain = 150;_mul = 50;_chance = 97};
			if(_diff < 1) then {_gain = 0;_mul = 15;_chance = 99};
			if(_popControl > 1000) then {_chance = _chance - 1};
			if(_popControl > 2000) then {_chance = _chance - 1};

			//Recover resources
			_resources = _resources + _gain + _resourceGain + ((round (_popControl * 0.01)) * _mul);

			server setVariable ["NATOlastgain",_gain + _resourceGain + ((round (_popControl * 0.01)) * _mul),true];

			//Counter Towns
			_lastcounter = server getVariable ["NATOlastcounter",""];
			{
				_town = _x;
				_pos = server getVariable _town;
				_stability = server getVariable format ["stability%1",_town];
				_population = server getVariable format ["population%1",_town];
				if(_town != _lastcounter) then {
					if(_pos call OT_fnc_inSpawnDistance) then {
						_nummil = {side _x isEqualTo west} count (_pos nearObjects ["CAManBase",300]);
						_numres = {side _x isEqualTo resistance || captive _x} count (_pos nearObjects ["CAManBase",200]);
						if(_nummil < 3 && {_numres > 0}) then {
							if((time - _lastAttack) > 1200 && {(_town in _abandoned)} && {(_resources > _population)} && {(random 100) > _chance}) then {
								//Counter a town
								diag_log format ["Overthrow: Counter-attacking %1",_town];
								private _m = 3;
								if(_popControl > 1000) then {_m = 4};
								if(_popControl > 2000) then {_m = 5};
								private _cost = _population * _m;
								if(_resources < _cost) then {_cost = _resources};
								[_town,_cost] spawn OT_fnc_NATOCounterTown;
								server setVariable ["NATOlastcounter",_town,true];
								server setVariable ["NATOattacking",_town,true];
								server setVariable ["NATOattackstart",time,true];
								server setVariable ["NATOlastattack",time,true];
								_resources = _resources - _cost;
								_countered = true;
							};
						};
					};
				};
				if(_countered) exitWith {};
			}foreach (OT_allTowns);

			//Spawn missing drones & counter objectives
			{
				_x params ["_pos","_name","_pri"];
				private _chance = 99;
				if(_pri > 800) then {_chance = _chance - 1};
				if(_popControl > 1000) then {_chance = _chance - 1};
				if(_popControl > 2000) then {_chance = _chance - 1};
				if((_time - _lastAttack) > 1200 && {(_name != _lastcounter)} && {(_name in _abandoned)} && {(_resources > _pri)} && {(random 100) > _chance}) exitWith {
					//Counter an objective

					private _m = _diff + 1;
					if(_popControl > 1000) then {_m = 2};
					if(_popControl > 2000) then {_m = 4};
					if(_pri > 800) then {_m = _m + 2};
					if(_pri > _resources) then {_pri = _resources};
					_resources = _resources - _pri;
					[_name,_pri * _m] spawn OT_fnc_NATOCounterObjective;
					diag_log format ["Overthrow: Counter-attacking %1",_name];
					server setVariable ["NATOlastcounter",_name,true];
					server setVariable ["NATOattacking",_name,true];
					server setVariable ["NATOattackstart",time,true];
					server setVariable ["NATOlastattack",time,true];
					_countered = true;
				};

				if !(_name in _abandoned) then {
					_drone = spawner getVariable [format["drone%1",_name],objNull];
					if(!alive _drone) then {
						deleteVehicle _drone;
					};
					if((isNull _drone || !alive _drone) && {_resources > 10}) then {
						_targets = [];
						{
							_town = _x;
							_p = server getVariable _town;
							if((_p distance _pos) < 3000 && _p call OT_fnc_inSpawnDistance) then {
								_stability = server getVariable format["stability%1",_town];
								if((_town in _abandoned) || (_stability < 50)) then {
									_targets pushback _p;
								};
							};
						}foreach(OT_allTowns);

						{
							_x params ["_p","_name"];
							if((_p distance _pos) < 3000) then {
								if (_name in _abandoned && _p call OT_fnc_inSpawnDistance) then {
									_targets pushback _p;
								};
							};
						}foreach(OT_NATOobjectives + OT_NATOcomms);

						{
							_x params ["_ty","_p"];
							if(((toUpper _ty) isEqualTo "FOB") && {(_p distance _pos) < 3000} && _p call OT_fnc_inSpawnDistance) then {
								_targets pushback _p;
							};
						}foreach(_knownTargets);

						if(count _targets > 0) then {
							_targets = [_targets,[],{random 100},"ASCEND"] call BIS_fnc_sortBy;
							_group = createGroup blufor;
							_group deleteGroupWhenEmpty true;
							_p = [_pos,0,0,false,[0,0],[100,OT_NATO_Vehicles_ReconDrone]] call SHK_pos_fnc_pos;
							_drone = createVehicle [OT_NATO_Vehicles_ReconDrone, _p, [], 0,""];
							_drone enableDynamicSimulation false;

							createVehicleCrew _drone;
							{
								[_x] joinSilent _group;
							}foreach(crew _drone);


							spawner setVariable [format["drone%1",_name],_drone,false];
							_resources = _resources - 10;

							{
								_wp = _group addWaypoint [_x,100];
								_wp setWaypointType "MOVE";
								_wp setWaypointBehaviour "COMBAT";
								_wp setWaypointSpeed "FULL";
								_wp setWaypointTimeout [5,20,60];
								_wp setWaypointStatements ["true",format["(vehicle this) flyInHeight %1;",25+random 50]];
							}foreach(_targets);

							_wp = _group addWaypoint [_pos,300];
							_wp setWaypointType "MOVE";
							_wp setWaypointBehaviour "COMBAT";
							_wp setWaypointSpeed "FULL";
							_wp setWaypointTimeout [5,20,60];
							_wp setWaypointStatements ["true",format["(vehicle this) flyInHeight %1;",25+random 50]];

							_wp = _group addWaypoint [_pos,0];
							_wp setWaypointType "CYCLE";

							{
								_x addCuratorEditableObjects [[_drone]];
							}foreach(allCurators);

							[_drone,_name] spawn OT_fnc_NATODrone;
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
			if(_popControl > 1000) then {
				_chance = _chance - 10;
			};
			if(_popControl > 2000) then {
				_chance = _chance - 10;
			};
			if(_diff > 1) then {
				_chance = _chance - 5;
			};

			if(!(spawner getVariable ["NATOdeploying",false]) && {(_spend > 500)} && {(count _fobs) < 3} && {(random 100) > _chance}) then {
				//Deploy an FOB
				_lowest = "";
				{
					_stability = server getVariable [format["stability%1",_x],100];
					if((_x in _abandoned) || _stability < 50) exitWith {
						_lowest = _x;
					};
				}foreach([OT_allTowns,[],{random 100},"DESCEND"] call BIS_fnc_sortBy);
				if(_lowest != "") then {
					_townPos = (server getVariable _lowest);
					_pp = [_townPos,random 360,2000] call SHK_pos_fnc_pos;
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

						if(!_near && {(_pos distance _bpos) > 400} && {(_pos distance _townPos) > 250}) exitWith {
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

			//Reinforce gendarm
			if(_spend >= 20) then {
				{
					_town = _x;
					_townPos = server getVariable _town;
					_current = server getVariable format ["garrison%1",_town];;
					_stability = server getVariable format ["stability%1",_town];
					_population = server getVariable format ["population%1",_town];
					if!(_town in _abandoned) then {
						_max = round(_population / 40);
						if(_max < 4) then {_max = 4};
						_garrison = 2+round((1-(_stability / 100)) * _max);
						if(_town in OT_NATO_priority) then {
							_garrison = round(_garrison * 2);
						};
						_need = _garrison - _current;
						if(_need < 0) then {_need = 0};
						if(_need > 1 && {_spend >= 20}) then {
							_spend = _spend - 20;
							_resources = _resources - 20;
							_x spawn OT_fnc_NATOsendGendarmerie;
						};
					};
					if(_spend < 20) exitWith {};
				}foreach ([OT_allTowns,[],{random 100},"DESCEND"] call BIS_fnc_sortBy);
			};

			//Send a ground patrol
			private _last = spawner getVariable ["NATOlastpatrol",0];
			if((time - _last) > 1200 && _spend > 150) then {
				private _done = false;
				{
					_town = _x;
					_stability = server getVariable format ["stability%1",_town];
					_townPos = server getVariable _town;
					if(_townPos call OT_fnc_inSpawnDistance) then {
						_base = _townPos call OT_fnc_nearestObjective;
						_basename = _base select 1;
						_basepos = _base select 0;
						if !(_basename in OT_allComms) then {
							_baseregion = _basepos call OT_fnc_getRegion;
							_townregion = _townPos call OT_fnc_getRegion;
							_dist = _basepos distance _townPos;
							if(!(_basename in _abandoned) && _baseregion isEqualTo _townregion && _dist < 5000 && _stability < 50 && (random 100) > _chance) exitWith {
								_spend = _spend - 150;
								_done = true;
								_resources = _resources - 150;
								[_basename,_townPos] spawn OT_fnc_NATOGroundPatrol;
								spawner setVariable ["NATOlastpatrol",time,false];
							};
						};
					};
					if(_done) exitWith {};
				}foreach ([OT_allTowns,[],{random 100},"DESCEND"] call BIS_fnc_sortBy);
			};

			//Schedule a convoy
			private _lastConvoy = spawner getVariable ["NATOlastconvoy",0];
			if(_spend > 0) then {
				if((time - _lastConvoy) > 3600 && _spend > 500 && {(random 100) > _chance}) then {
					_start = selectRandom (OT_objectiveData + OT_airportData);
					_startName = _start select 1;
					_startPos = _start select 0;
					if(_startName in _abandoned) exitWith {};
					_end = [];
					{
						_x params ["_p","_n"];
						if((_n != _startName) && {!(_n in _abandoned)} && {([_p,_startPos] call OT_fnc_regionIsConnected)}) exitWith {
							_end = _x;
						};
					}foreach([OT_NATOobjectives,[],{random 100},"DESCEND"] call BIS_fnc_sortBy);
					if(count _end > 0) then {
						//Schedule a convoy
						private _id = format["CONVOY%1",round(random 99999)];
						_hour = (date select 3) + 2;
						if(_hour > 5 && _hour < 17) then {
							spawner setVariable ["NATOlastconvoy",time,false];
							_spend = _spend - 500;
							_resources = _resources - 500;
							_schedule pushback [_id,"CONVOY",_start,_end,_hour];
						};
					};
				};
			};

			//Send an air patrol
			_last = spawner getVariable ["NATOlastairpatrol",0];
			if((time - _last) > 3600 && _spend > 250 && _popControl > 750) then {
				private _frombase = "";
				{
					_x params ["_obpos","_name"];
					if !(_name in _abandoned) then {
						_frombase = _name;
					};
				}foreach([OT_airportData,[],{random 100},"DESCEND"] call BIS_fnc_sortBy);
				if(!(_frombase isEqualTo "") && {(random 100) > _chance}) then {
					private _waypoints = [];
					{
						_x params ["_pos"];
						_waypoints pushback _pos;
					}foreach(_fobs);
					{
						if((server getVariable [format ["garrison%1",_x],-1]) > 0) then {
							private _pos = markerPos _x;
							_waypoints pushback _x
						};
						if((count _waypoints) > 6) exitWith {};
					}foreach ([OT_NATO_control,[],{random 100},"DESCEND"] call BIS_fnc_sortBy);

					if((count _waypoints) > 0) then {
						_spend = _spend - 250;
						_resources = _resources - 250;
						spawner setVariable ["NATOlastairpatrol",time,false];
						[_frombase,_waypoints] spawn OT_fnc_NATOAirPatrol;
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
					if(!(_pos call OT_fnc_inSpawnDistance) && {(_garrison < _max)} && {(_spend > 150)} &&  {(random 100 > _chance)}) then {
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
				if((_garrison < _max) && {(_spend > 150)} &&  {(random 100 > _chance)}) exitWith {
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
				if(!("Mortar" in _upgrades) && {(_spend > 300)} && {(random 100 > _chance)}) exitWith {
					_spend = _spend - 300;
					_resources = _resources - 300;
					_upgrades pushback "Mortar";
					[_pos,["Mortar"]] spawn OT_fnc_NATOupgradeFOB;
				};
				if(!("Barriers" in _upgrades) && {(_spend > 50)} && {(random 100 > _chance)}) exitWith {
					_spend = _spend - 50;
					_resources = _resources - 50;
					_upgrades pushback "Barriers";
					[_pos,["Barriers"]] spawn OT_fnc_NATOupgradeFOB;
				};
				if(!("HMG" in _upgrades) && {(_spend > 150)} && {(random 100 > _chance)}) exitWith {
					_spend = _spend - 150;
					_resources = _resources - 150;
					_upgrades pushback "HMG";
					[_pos,["HMG"]] spawn OT_fnc_NATOupgradeFOB;
				};
			}foreach(_fobs);
		};
		//Finish
		_limit = 2500;
		if(_diff > 0 && _popControl > 1000) then {_limit = _limit + 500};
		if(_diff > 1 && _popControl > 1000) then {_limit = _limit + 500};
		if(_popControl > 2000) then {_limit = _limit + 500};
		if(_diff > 1 && _popControl > 2000) then {_limit = _limit + 500};
		if(_resources > _limit) then {_resources = _limit};
		server setVariable ["NATOresources",_resources,true];
		server setVariable ["NATOabandoned",_abandoned,true];
		spawner setVariable ["NATOknownTargets",_knownTargets,true];
		server setVariable ["NATOschedule",_schedule,true];
		server setVariable ["NATOfobs",_fobs,true];
	};
	_count = _count + 1;

}, 10, [_abandoned,_resources,_diff,_nextturn,_count,_lastmin,_lastsched]] call CBA_fnc_addPerFrameHandler;
