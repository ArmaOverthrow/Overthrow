if (!isServer) exitwith {};

OT_NATOobjectives = [];
OT_NATOcomms = [];

OT_NATOobjectives = server getVariable ["NATOobjectives",[]];
OT_NATOcomms = server getVariable ["NATOcomms",[]];
OT_NATOhvts = server getVariable ["NATOhvts",[]];
OT_allObjectives = [];
OT_allComms = [];

private _diff = server getVariable ["OT_difficulty",1];

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
		_x params ["_pos","_name","_worth"];
		if !(_name in _abandoned) then {
			OT_NATOobjectives pushBack _x;
			server setVariable [format ["vehgarrison%1",_name],[],true];

            _base = 8;
            _statics = OT_NATO_StaticGarrison_LevelOne;
            if(_worth > 500) then {
                _base = 16;
                _statics = OT_NATO_StaticGarrison_LevelTwo;
            };
            if(_worth > 1000) then {
                _base = 24;
                _statics = OT_NATO_StaticGarrison_LevelThree;
            };
			_garrison = floor(_base + random(8));
			server setVariable [format ["vehgarrison%1",_name],_statics,true];

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
		}else{
			OT_NATOobjectives pushBack _x;
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
    //First, build a weighted list of objectives
    _prilist = [];
    {
        _x params ["_pos","_name","_worth"];

        if(_worth > 250) then {
            _prilist pushback _name;
        };
        if(_worth > 800) then {
            _prilist pushback _name;
        };
        if(_worth > 1200) then {
            _prilist pushback _name;
        };
    }foreach(OT_NATOobjectives);

	{
		_type = _x select 0;
		_num = _x select 1;
		_count = 0;
		while {_count < _num} do {
			_name = _prilist call BIS_fnc_selectRandom;
			_garrison = server getVariable format["vehgarrison%1",_name];
			_garrison pushback _type;
			_count = _count + 1;
			server setVariable [format ["vehgarrison%1",_name],_garrison,true];
		};
	}foreach(OT_NATO_Vehicles_Garrison);

    //Weighted airport list to distribute air vehicles
    _prilist = [];
    {
        _x params ["_pos","_name","_worth"];
        _prilist pushback _name;
        if(_worth > 500) then {
            _prilist pushback _name;
        };
        if(_worth > 800) then {
            _prilist pushback _name;
        };
        if(_worth > 1000) then {
            _prilist pushback _name;
        };
    }foreach(OT_airportData);

	{
		_type = _x select 0;
		_num = _x select 1;
		_count = 0;
		while {_count < _num} do {
			_name = _prilist call BIS_fnc_selectRandom;
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
