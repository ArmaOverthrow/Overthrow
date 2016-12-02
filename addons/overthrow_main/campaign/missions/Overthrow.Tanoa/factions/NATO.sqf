if (!isServer) exitwith {};

private ["_name","_pos","_garrison","_need","_townPos","_current","_stability","_police","_civ","_units","_move","_NATObusy","_abandoned"];

OT_NATOobjectives = [];
OT_NATOcomms = [];


_NATObusy = false;
_abandoned = [];
OT_NATOobjectives = server getVariable ["NATOobjectives",[]];
OT_NATOcomms = server getVariable ["NATOcomms",[]];
OT_allObjectives = [];

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
	server setVariable ["NATOobjectives",OT_NATOobjectives,false];
	server setVariable ["NATOcomms",OT_NATOcomms,false];

	//Find military objectives
	{
		_name = text _x;// Get name
		_pos=getpos _x;
		if !(_name in _abandoned) then {
			//if its in the whitelist, within the NATO home region, or an airport, NATO lives here
			if !(_name in OT_NATOblacklist) then {
				if((_name in OT_NATOwhitelist) || ([_pos,OT_NATOregion] call fnc_isInMarker) || (_name in OT_allAirports)) then {

					if((_name find "Comms") == 0) then {
						OT_NATOcomms pushBack [_pos,_name];
					}else{
						OT_NATOobjectives pushBack [_pos,_name];
						server setVariable [format ["vehgarrison%1",_name],[],true];
					};

					_garrison = floor(4 + random(8));
					if(_name in OT_NATO_priority or _name in OT_allAirports) then {
						_garrison = floor(16 + random(8));
						server setVariable [format ["vehgarrison%1",_name],["B_HMG_01_high_F","B_HMG_01_high_F","B_HMG_01_high_F"],true];
					};
					if(_name == OT_NATO_HQ) then {
						_garrison = 48;
						server setVariable [format ["vehgarrison%1",_name],["B_T_MBT_01_arty_F","B_T_MBT_01_arty_F","B_HMG_01_high_F","B_HMG_01_high_F","B_HMG_01_high_F","B_T_Mortar_01_F","B_T_Mortar_01_F"],true];
						server setVariable [format ["airgarrison%1",_name],[OT_NATO_Vehicle_AirTransport_Large],true];
					}else{
						server setVariable [format ["airgarrison%1",_name],[],true];
					};
					server setVariable [format ["garrison%1",_name],_garrison,true];
				};
				if(_name == OT_NATO_HQ) then {
					OT_NATO_HQPos = getpos _x;
				};

				sleep 0.05;
			};
		}else{
			if((_name find "Comms") == 0) then {
				OT_NATOcomms pushBack [_pos,_name];
			}else{
				OT_NATOobjectives pushBack [_pos,_name];
			};
		};
	}foreach (nearestLocations [OT_centerPos, ["NameLocal","Airport"], 12000]);
	(OT_loadingMessages call BIS_fnc_selectRandom) remoteExec['blackFaded',0];
	sleep 0.1;
	//Add other comms towers
	_c = 1;
	{
		_name = format["Comms%1",_c];
		_pos = getpos _x;
		_near = _pos call nearestObjective;
		_do = true;
		if !(isNil "_near") then {
			if((_pos distance (_near select 0)) < 500) then {
				_do = false;
			};
		};
		if(_do) then {
			OT_NATOcomms pushBack [_pos,_name];
			_garrison = floor(4 + random(4));
			server setVariable [format ["garrison%1",_name],_garrison,true];

			_c = _c + 1;
		};
	}foreach (nearestObjects [OT_centerPos,OT_NATO_CommTowers,12000]);

	server setVariable ["NATOobjectives",OT_NATOobjectives,true];
	server setVariable ["NATOcomms",OT_NATOcomms,true];
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
	OT_allObjectives pushback _name;
}foreach(OT_NATOcomms);
server setVariable ["NATOattacking","",true];
sleep 5;
while {true} do {
	_garrisoned = false;
	_numplayers = count([] call CBA_fnc_players);
	if(_numplayers > 0) then {
		_abandoned = server getVariable "NATOabandoned";

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
				if(_need > 1) then {
					_x spawn reGarrisonTown;
				}else{
					if(_townPos call inSpawnDistance) then {
						if(random 100 > 90) then {
							_townPos spawn NATOsearch;
						};
					};
				};
			}else{
				server setVariable [format ["garrison%1",_town],0,true];
				if(!(_town in _abandoned)) then {
					_town spawn NATOattack;
					server setVariable ["NATOattacking",_town,true];
					_garrisoned = true;
					_abandoned pushback _town;
					server setVariable ["NATOabandoned",_abandoned,true];
				};
			};
			if(_garrisoned) exitWith {}; //only send one garrison/attack per turn
			sleep 0.1;
		}foreach (OT_allTowns);

		private _currentAttack = server getVariable ["NATOattacking",""];
		if(_currentAttack != "") then {
			_garrisoned = true;
		};

		if !(_garrisoned) then {
			{
				_pos = _x select 0;
				_name = _x select 1;
				if !(_name in _abandoned) then {
					_garrison = server getvariable format["garrison%1",_name];
					_vehgarrison = server getvariable format["vehgarrison%1",_name];

					if(_garrison < 4) then {
						_garrisoned = true;
						server setVariable ["NATOattacking",_name,true];
						_name spawn NATOcounter;
						_abandoned pushback _name;
						server setVariable ["NATOabandoned",_abandoned,true];
						_name setMarkerAlpha 1;
					};
				};
				if(_garrisoned) exitWith {};
			}foreach(OT_NATOobjectives);
		};

		//Town counter-attacks
		if (!(_garrisoned) and count(_abandoned) > 4 and (random 100) > 98) then {
			_highest = 0;
			_high = 0;
			{
				_pop = server getVariable[format["population%1",_x],0];
				if(_pop > 0 and _pop > _high) then {
					_high = _pop;
					_highest = _x;
				};
			}foreach (_abandoned);
			if(_high > 0) then {
				_highest spawn NATOretakeTown;
			};
		};

		if !(_garrisoned) then {
			//Nothing to do, so NATO will harass
			_chance = 98;
			if(count _abandoned > 4) then {_chance = 95};
			if(count _abandoned > 8) then {_chance = 90};
			if(((random 100) > _chance) and (count _abandoned) > 0) then {
				_target = _abandoned call BIS_fnc_selectRandom;
				_pos = server getvariable _target;
				if !(isNil "_pos") then {
					_pos spawn NATOsniper;
				};
			};
		};
	};

	{
		_pos = _x select 0;
		_name = _x select 1;
		if !(_name in _abandoned) then {
			_garrison = server getvariable format["garrison%1",_name];
			if(_garrison < 2) then {
				_abandoned pushback _name;
				server setVariable ["NATOabandoned",_abandoned,true];
				_name setMarkerColor "ColorGUER";
				_t = _pos call nearestTown;
				format["We have captured the radio tower near %1",_t] remoteExec ["notify_good",0,false];
			};
		};
	}foreach(OT_NATOcomms);


	{
		if(count (units _x) == 0) then {
			deleteGroup _x;
		};
	}foreach(allGroups);

	sleep OT_NATOwait + round(random OT_NATOwait);
};
