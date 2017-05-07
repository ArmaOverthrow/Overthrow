if (!isServer) exitwith {};

private _abandoned = [];
private _resources = 0;
private _diff = server getVariable ["OT_difficulty",1];

private _nextturn = OT_NATOwait + random OT_NATOwait;
private _count = 0;

server setVariable ["NATOattacking","",true];
server setVariable ["NATOattackstart",0,true];

private _lastmin = date select 4;
private _lastsched = -1;

while {sleep 10;true} do {
	private _numplayers = count([] call CBA_fnc_players);
	if(_numplayers > 0) then {
		_abandoned = server getVariable ["NATOabandoned",[]];
		_resources = server getVariable ["NATOresources",2000];
		private _countered = (server getVariable ["NATOattacking",""]) != "";

		_knownTargets = spawner getVariable ["NATOknownTargets",[]];

		_schedule = server getVariable ["NATOschedule",[]];

		//scheduler

		if(_lastmin != (date select 4)) then {
			private _lastmin = date select 4;
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
					_item params ["_mission","_ty","_pos"];
					if(_mission == "DESTROY") then {
						[_pos] spawn OT_fnc_NATOMissionReconDestroy;
					};
				};
				if(_lastmin == 0 or _lastmin == 30) then {
					_item = _schedule select 0;

				};
			};
		};


		//Objective QRF and drone intel reports
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
								_knownTargets pushback [_ty,_pos,_pri,_obj,false];
							};
						}foreach(_intel);
						_drone setVariable ["OT_seenTargets",[]];
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
			_resourceGain = server getVariable ["NATOresourceGain",0];
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
			_resources = _resources + _resourceGain + ((count _abandoned) * 25);

			//Spawn missing drones
			{
				_x params ["_pos","_name"];
				if !(_name in _abandoned) then {
					_drone = spawner getVariable [format["drone%1",_name],objNull];
					if(isNull _drone or !alive _drone) then {
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

							_drone spawn OT_fnc_initDrone;
						};
					};
				};
				if(_resources <= 0) exitWith {_resources = 0};
			}foreach(OT_NATOobjectives + OT_NATOcomms);

			//Decide on spend
			_spend = 0;
			if(_resources > 500) then {
				_spend = 500;
			};
			if(_resources > 1000) then {
				_spend = 800;
			};
			if(_resources > 1500) then {
				_spend = 1200;
			};

			//Schedule some missions
			if(_spend > 0) then {
				_targets = [_knownTargets,[],{_x select 2},"DESCEND"] call BIS_fnc_sortBy;
				{
					_x params ["_ty","_pos","_pri","_obj","_done"];
					if !(_done) then {
						if(_ty == "WH" or _ty == "PS" or _ty == "WS") then {
							if(_spend > 250) then {
								_schedule pushback ["DESTROY",_ty,_pos];
								_spend = _spend - 250;
								_resources = _resources -250;
								_x set [4,true];
							};
						};
					};
				}foreach(_targets);
			};


		};
		//Finish
		if(_resources > 2500) then {_resources = 2500};
		server setVariable ["NATOresources",_resources,true];
		server setVariable ["NATOabandoned",_abandoned,true];
		spawner setVariable ["NATOknownTargets",_knownTargets,true];
		server setVariable ["NATOschedule",_schedule,true];
	};
	_count = _count + 1;
};
