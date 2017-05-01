if (!isServer) exitwith {};

private ["_name","_pos","_garrison","_need","_townPos","_current","_stability","_police","_civ","_units","_move","_NATObusy","_abandoned"];

OT_NATOobjectives = [];
OT_NATOcomms = [];


private _NATObusy = false;
private _abandoned = [];
private _diff = server getVariable ["OT_difficulty",1];
OT_NATOobjectives = server getVariable ["NATOobjectives",[]];
OT_NATOcomms = server getVariable ["NATOcomms",[]];
OT_NATOhvts = server getVariable ["NATOhvts",[]];
OT_allObjectives = [];
OT_allComms = [];

if((server getVariable "StartupType") == "NEW" or (server getVariable ["NATOversion",0]) < OT_NATOversion) then {
	diag_log "Overthrow: Generating NATO";
	server setVariable ["NATOversion",OT_NATOversion,false];
	_abandoned = server getVariable ["NATOabandoned",[]];

	(OT_loadingMessages call BIS_fnc_selectRandom) remoteExec['blackFaded',0,false];
	sleep 0.1;
	{
		_stability = server getVariable format ["stability%1",_x];
		if(_stability < 11 and !(_x in _abandoned)) then {
			_abandoned pushback _x;
		};
	}foreach (OT_allTowns);
	server setVariable ["NATOabandoned",_abandoned,true];
	server setVariable ["garrisonHQ",1000,false];
	OT_NATOobjectives = [];
	OT_NATOcomms = [];
	OT_NATOhvts = [];
	server setVariable ["NATOobjectives",OT_NATOobjectives,false];
	server setVariable ["NATOcomms",OT_NATOcomms,false];
	server setVariable ["NATOhvts",OT_NATOhvts,false];

	_numHVTs = 6;
	if(_diff == 0) then {_numHVTs = 4};
	if(_diff == 2) then {_numHVTs = 8};

	//Find military objectives
	{
		_x params ["_pos","_name"];
		if !(_name in _abandoned) then {
			OT_NATOobjectives pushBack [_pos,_name];
			server setVariable [format ["vehgarrison%1",_name],[],true];

			_garrison = floor(4 + random(8));
			if(_name in OT_NATO_priority or _name in OT_allAirports) then {
				_garrison = floor(16 + random(8));
				server setVariable [format ["vehgarrison%1",_name],["B_T_APC_Tracked_01_AA_F","B_HMG_01_high_F","B_HMG_01_high_F","B_GMG_01_high_F"],true];
			};
			if(_name == OT_NATO_HQ) then {
				_garrison = 48;
				server setVariable [format ["vehgarrison%1",_name],["B_T_APC_Tracked_01_AA_F","B_T_APC_Tracked_01_AA_F","B_GMG_01_high_F","B_GMG_01_high_F","B_GMG_01_high_F","B_HMG_01_high_F","B_HMG_01_high_F","B_HMG_01_high_F"],true];
				server setVariable [format ["airgarrison%1",_name],[OT_NATO_Vehicle_AirTransport_Large],true];
			}else{
				server setVariable [format ["airgarrison%1",_name],[],true];
			};
			server setVariable [format ["garrison%1",_name],_garrison,true];

			if(_name == OT_NATO_HQ) then {
				OT_NATO_HQPos = _pos;
			};

			sleep 0.05;

		}else{
			OT_NATOobjectives pushBack [_pos,_name];
		};
	}foreach (OT_objectiveData + OT_airportData);

	_count = 0;
	_done = [];
	while {_count < _numHVTs} do {
		_ob = selectRandom (OT_NATOobjectives - ([[OT_NATO_HQ,OT_NATO_HQPos]] + _done));
		_name = _ob select 1;
		_done pushback _ob;
		_id = format["%1%2",_name,round(random 99999)];
		OT_NATOhvts pushback [_id,_name,""];
		_count = _count + 1;
	};

	(OT_loadingMessages call BIS_fnc_selectRandom) remoteExec['blackFaded',0];
	sleep 0.1;
	//Add comms towers
	{
		_x params ["_pos","_name"];
		OT_NATOcomms pushBack [_pos,_name];
		_garrison = floor(4 + random(4));
		server setVariable [format ["garrison%1",_name],_garrison,true];
	}foreach (OT_commsData);

	server setVariable ["NATOobjectives",OT_NATOobjectives,true];
	server setVariable ["NATOcomms",OT_NATOcomms,true];
	server setVariable ["NATOhvts",OT_NATOhvts,true];
	diag_log "Overthrow: Distributing NATO vehicles";
	//Randomly distribute NATO's vehicles
	{
		_type = _x select 0;
		_num = _x select 1;
		_count = 0;
		while {_count < _num} do {
			_obj = OT_NATOobjectives call BIS_fnc_selectRandom;
			_name = _obj select 1;
			_garrison = server getVariable format["vehgarrison%1",_name];
			_garrison pushback _type;
			_count = _count + 1;
			server setVariable [format ["vehgarrison%1",_name],_garrison,true];
		};
	}foreach(OT_NATO_Vehicles_Garrison);

	{
		_type = _x select 0;
		_num = _x select 1;
		_count = 0;
		while {_count < _num} do {
			_name = OT_allAirports call BIS_fnc_selectRandom;
			_garrison = server getVariable [format["airgarrison%1",_name],[]];
			_garrison pushback _type;
			_count = _count + 1;
			server setVariable [format ["airgarrison%1",_name],_garrison,true];
		};
	}foreach(OT_NATO_Vehicles_AirGarrison);
	diag_log "Overthrow: Setting up NATO checkpoints";
	{
		_garrison = floor(8 + random(6));
		if(_x in OT_NATO_priority) then {
			_garrison = floor(12 + random(6));
		};

		//_x setMarkerText format ["%1",_garrison];
		_x setMarkerAlpha 0;
		server setVariable [format ["garrison%1",_x],_garrison,true];
		sleep 0.05;
	}foreach (OT_NATO_control);
	diag_log "Overthrow: Garrisoning towns";
	{
		_town = _x;
		_garrison = 0;
		_stability = server getVariable format ["stability%1",_town];
		_population = server getVariable format ["population%1",_town];
		if(_stability > 10) then {
			_max = round(_population / 30);
			if(_max < 4) then {_max = 4};
			_garrison = 2+round((1-(_stability / 100)) * _max);
			if(_town in OT_NATO_priority) then {
				_garrison = round(_garrison * 2);
			};
		};
		server setVariable [format ["garrison%1",_x],_garrison,true];
		sleep 0.05;
	}foreach (OT_allTowns);
};
diag_log "Overthrow: NATO Init Done";

OT_NATOInitDone = true;
publicVariable "OT_NATOInitDone";

{
	_pos = _x select 0;
	_name = _x select 1;
	_mrk = createMarker [_name,[_pos,25,270] call BIS_fnc_relPos];
	_mrk setMarkerShape "ICON";
	if(_name in (server getVariable "NATOabandoned")) then {
		_mrk setMarkerType "flag_Tanoa";
	}else{
		_mrk setMarkerType "flag_NATO";
	};

	server setVariable [_name,_pos,true];

	OT_allObjectives pushback _name;
}foreach(OT_NATOobjectives);

publicVariable "OT_allObjectives";

{
	_pos = _x select 0;
	_name = _x select 1;
	_mrk = createMarker [_name,_pos];
	_mrk setMarkerShape "ICON";
	_mrk setMarkerType "loc_Transmitter";
	if(_name in (server getVariable "NATOabandoned")) then {
		_mrk setMarkerColor "ColorGUER";
	}else{
		_mrk setMarkerColor "ColorBLUFOR";
	};
	server setVariable [_name,_pos,true];
	OT_allComms pushback _name;
	OT_allObjectives pushback _name;
}foreach(OT_NATOcomms);
server setVariable ["NATOattacking","",true];
server setVariable ["NATOattackstart",0,true];

sleep OT_NATOwait + round(random OT_NATOwait);

while {true} do {
	_garrisoned = false;
	_numplayers = count([] call CBA_fnc_players);
	_resources = server getVariable ["NATOresources",1000];
	_resourceGain = server getVariable ["NATOresourceGain",0];

	if(_numplayers > 0) then {
		diag_log format["Overthrow: NATO turn @ %1",time];
		_abandoned = server getVariable "NATOabandoned";


		private _currentAttack = server getVariable ["NATOattacking",""];
		private _currentAttackStart = server getVariable ["NATOattackstart",0];
		if(_currentAttack != "" and (time - _currentAttackStart) > 2400) then {
			server setVariable ["NATOattacking","",true];
			_currentAttack = "";
			{
				if(side _x == west) then {
					_lead = (units _x) select 0;
					if((_lead getVariable ["garrison",""]) == "HQ") then {
						if((vehicle _lead) != _lead) then {
							[vehicle _lead] spawn OT_fnc_cleanup;
						};
						[_x] spawn OT_fnc_cleanup;
					};
				}
			}foreach(allgroups);
		};

		if(_currentAttack == "") then {
			_resources = _resources + _resourceGain + ((count _abandoned) * 25);
			diag_log format["Overthrow: NATO resources @ %1",_resources];
		}else{
			diag_log format["Overthrow: NATO still attacking %1",_currentAttack];
		};

		if(_currentAttack != "") then {
			_garrisoned = true;
		};

		//Objective response
		if !(_garrisoned) then {
			{
				_pos = _x select 0;
				_name = _x select 1;
				if !(_name in _abandoned) then {
					if(_pos call OT_fnc_inSpawnDistance) then {
						_nummil = {side _x == west} count (_pos nearObjects ["CAManBase",300]);
						_numres = {side _x == resistance or captive _x} count (_pos nearObjects ["CAManBase",200]);
						if(_nummil < 3 and _numres > 0) then {
							_garrisoned = true;
							server setVariable ["NATOattacking",_name,true];
							server setVariable ["NATOattackstart",time,true];
							diag_log format["Overthrow: NATO responding to %1",_name];
							[_name,_resources] spawn OT_fnc_NATOResponseObjective;
							_name setMarkerAlpha 1;
							_resources = 0;
						};
					};
				};
				if(_garrisoned) exitWith {};
			}foreach(OT_NATOobjectives);
		};
		if !(_garrisoned) then {
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
					if(_need > 1 and _resources >= 20) then {
						_resources = _resources - 20;
						_x spawn reGarrisonTown;
					};
				};
			}foreach (OT_allTowns);
		};

		{
			_town = _x;
			_stability = server getVariable format ["stability%1",_town];
			_population = server getVariable format ["population%1",_town];
			if(_population < 50) then {
				if(_stability < 10 and !(_town in _abandoned)) then {
					_abandoned pushback _town;
					server setVariable [format ["garrison%1",_town],0,true];
					format["NATO has abandoned %1",_town] remoteExec ["notify_good",0,false];
					[_town,15] call stability;
				};
			};
		}foreach (OT_allTowns);

		//Town response
		if !(_garrisoned) then {
			_sorted = [OT_allTowns,[],{server getvariable format["population%1",_x]},"DESCEND"] call BIS_fnc_SortBy;
			{
				_town = _x;
				_stability = server getVariable format ["stability%1",_town];
				_population = server getVariable format ["population%1",_town];
				if(_population > 50 and _stability < 10 and !(_town in _abandoned) and (_resources >= _population)) exitWith {
					server setVariable [format ["garrison%1",_town],0,true];
					diag_log format["Overthrow: NATO responding to %1",_town];
					[_town,_population] spawn OT_fnc_NATOResponseTown;
					server setVariable ["NATOattacking",_town,true];
					server setVariable ["NATOattackstart",time,true];
					_garrisoned = true;
					_resources = _resources - _population;
				};
			}foreach (_sorted);
		};

		//Objective counter-attacks
		if (!(_garrisoned) and count(_abandoned) > 2 and (_resources > 1000) and (random 100) > 95) then {
			_highest = 0;
			_high = 0;
			private _sorted = [OT_NATOobjectives,[],{(_x select 0) distance OT_NATO_HQPos},"ASCEND"] call BIS_fnc_SortBy;
			{
				_x params ["_pos","_name"];
				if(_name != server getVariable ["NATOlastcounter",""]) then {
					if(_name in _abandoned) exitWith {
						diag_log format["Overthrow: NATO beginning attack on %1",_name];
						[_name,_resources] spawn OT_fnc_NATOCounterObjective;
						server setVariable ["NATOlastcounter",_name,true];
						server setVariable ["NATOattacking",_name,true];
						server setVariable ["NATOattackstart",time,true];
						_resources = 0;
						_garrisoned = true;
					};
				};
			}foreach (_sorted);
		};

		//Town counter-attacks
		if (!(_garrisoned) and count(_abandoned) > 5 and (_resources > 1000) and (random 100) > 98) then {
			_highest = 0;
			_high = 0;
			{
				if(_x != server getVariable ["NATOlastcounter",""]) then {
					_pop = server getVariable[format["population%1",_x],0];
					if(_pop > 0 and _pop > _high) then {
						_high = _pop;
						_highest = _x;
					};
				};
			}foreach (_abandoned);
			if(_high > 0) then {
				diag_log format["Overthrow: NATO beginning attack on %1",_highest];
				[_highest,_resources] spawn OT_fnc_NATOCounterTown;
				server setVariable ["NATOlastcounter",_name,true];
				server setVariable ["NATOattacking",_highest,true];
				server setVariable ["NATOattackstart",time,true];
				_resources = 0;
				_garrisoned = true;
			};
		};

		//HVT Convoys
		if (!(_garrisoned) and (_resources > 200) and (random 100) > 96) then {
			_highest = 0;
			_high = 0;
			//Move a random HVT somewhere
			_hvt = selectRandom OT_NATOhvts;
			_hvt params ["_id","_loc","_status"];
			_dest = selectRandom OT_NATOobjectives;
			if(_status == "" and (_dest select 1) != _loc) then {
				_frompos = server getVariable _loc;
				_times = 0;
				_do = true;
				while {!([_frompos,_dest select 0] call OT_fnc_regionIsConnected)} do {
					_dest = selectRandom OT_NATOobjectives;
					_times = _times + 1;
					if(_times > 50) exitWith {_do = false};
				};
				if (_do) then {
					diag_log format["Overthrow: NATO moving a HVT from %1 to %2",_loc,_dest select 1];
					[[],[_hvt],_loc,_dest select 1] spawn OT_fnc_NATOConvoy;
					_resources = _resources - 200;
					_garrisoned = true;
				};
			};
		};

		//Radio tower counter-attacks
		if (!(_garrisoned) and count(_abandoned) > 2 and (_resources > 200) and (random 100) > 90) then {
			_highest = 0;
			_high = 0;
			private _sorted = [OT_NATOcomms,[],{(_x select 0) distance OT_NATO_HQPos},"ASCEND"] call BIS_fnc_SortBy;
			{
				_x params ["_pos","_name"];
				if(_pos in _abandoned) exitWith {
					diag_log format["Overthrow: NATO sending recon team to %1",_name];
					_pos spawn OT_fnc_NATOSupportRecon;
					_resources = _resources - 200;
					_garrisoned = true;
				};
			}foreach (_sorted);
		};

		{
			_x params ["_pos","_name"];
			_alive = 0;
			_enemy = 0;
			{
				if((side _x == west) and (alive _x) and ((_x getVariable ["garrison",""]) == "HQ")) then {
					_alive = _alive + 1;
				};
				if((side _x == resistance) and (alive _x) and !(_x getvariable ["ace_isunconscious",false])) then {
					_enemy = _enemy + 1;
				};
			}foreach(_pos nearEntities ["CAManBase",50]);
			if(_alive > 1 and _enemy == 0) then {
				_abandoned deleteAt (_abandoned find _name);
				format["NATO has retaken control of the %1 tower",_name] remoteExec ["notify_good",0,false];
				_name setMarkerColor "ColorBLUFOR";
				_resources = _resources + 50;
				server setVariable [format["garrison%1",_name],floor(4 + random(8)),true];
			};
		}foreach(OT_NATOcomms);

		if !(_garrisoned) then {
			//Nothing to do, so NATO will harass
			_chance = 98;
			if(count _abandoned > 4) then {_chance = 95};
			if(count _abandoned > 8) then {_chance = 90};
			if(((random 100) > _chance) and (count _abandoned) > 0 and (_resources >= 25)) then {
				_target = _abandoned call BIS_fnc_selectRandom;
				_pos = server getvariable _target;
				if !(isNil "_pos") then {
					_pos spawn OT_fnc_NATOSupportSniper;
					_resources = _resources - 25;
				};
			};
		};
	};

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
				};
			};
		};
	}foreach(OT_NATOcomms);
	if(_resources < 0) then {_resources = 0};

	{
		if(count (units _x) == 0) then {
			deleteGroup _x;
		};
	}foreach(allGroups);
	if(_resources > 2500) then {_resources = 2500};
	server setVariable ["NATOresources",_resources,true];
	server setVariable ["NATOabandoned",_abandoned,true];
	sleep OT_NATOwait + round(random OT_NATOwait);
};
