if (!isServer) exitwith {};

private ["_name","_pos","_garrison","_need","_townPos","_current","_stability","_police","_civ","_units","_move","_NATObusy","_abandoned"];

AIT_NATOobjectives = [];
AIT_NATOcomms = [];

_NATObusy = false;
_abandoned = [];
if((server getVariable "StartupType") == "NEW" or (server getVariable ["NATOversion",0]) < 2) then {	
	server setVariable ["NATOversion",2,false];
	(AIT_loadingMessages call BIS_fnc_selectRandom) remoteExec['blackFaded',0];
	sleep 0.1;
	{
		_stability = server getVariable format ["stability%1",_x];
		if(_stability < 11) then {
			_abandoned pushback _x;
		};
	}foreach (AIT_allTowns);
	server setVariable ["NATOabandoned",_abandoned,true];
	server setVariable ["garrisonHQ",1000,false];
	
	//Find military objectives
	{
		_name = text _x;// Get name
		_pos=getpos _x;
		
		//if its in the whitelist, within the NATO home region, or an airport, NATO lives here
		if !(_name in AIT_NATOblacklist) then {
			if((_name in AIT_NATOwhitelist) || ([_pos,AIT_NATOregion] call fnc_isInMarker) || (_name in AIT_allAirports)) then {	
				
				if((_name find "Comms") == 0) then {
					AIT_NATOcomms pushBack [_pos,_name];			
				}else{
					AIT_NATOobjectives pushBack [_pos,_name];
					server setVariable [format ["vehgarrison%1",_name],[],true];
				};			
				
				_garrison = floor(4 + random(8));
				if(_name in AIT_NATO_priority) then {
					_garrison = floor(16 + random(8));
					server setVariable [format ["vehgarrison%1",_name],["B_T_MBT_01_arty_F","B_HMG_01_high_F","B_HMG_01_high_F","B_T_Mortar_01_F"],true];					
				};
				if(_name == AIT_NATO_HQ) then {
					_garrison = 48;
					server setVariable [format ["vehgarrison%1",_name],["B_T_MBT_01_arty_F","B_T_MBT_01_arty_F","B_HMG_01_high_F","B_HMG_01_high_F","B_HMG_01_high_F","B_T_Mortar_01_F","B_T_Mortar_01_F"],true];	
					server setVariable [format ["airgarrison%1",_name],[AIT_NATO_Vehicle_AirTransport_Large],true];
				}else{
					server setVariable [format ["airgarrison%1",_name],[],true];
				};
				server setVariable [format ["garrison%1",_name],_garrison,true];				
			};
			if(_name == AIT_NATO_HQ) then {
				AIT_NATO_HQPos = getpos _x;
			};
			
			sleep 0.05;
		};
	}foreach (nearestLocations [AIT_centerPos, ["NameLocal","Airport"], 12000]);
	(AIT_loadingMessages call BIS_fnc_selectRandom) remoteExec['blackFaded',0];
	sleep 0.1;
	//Add other comms towers
	_c = 1;
	{
		_name = format["Comms%1",_c];
		_pos = getpos _x;
		_near = _pos call nearestObjective;
		if((_pos distance (_near select 0)) > 500) then {
			AIT_NATOcomms pushBack [_pos,_name];
			_garrison = floor(4 + random(4));
			server setVariable [format ["garrison%1",_name],_garrison,true];
			
			_c = _c + 1;
		};		
	}foreach (nearestObjects [AIT_centerPos,AIT_NATO_CommTowers,12000]);
	
	server setVariable ["NATOobjectives",AIT_NATOobjectives,true];
	server setVariable ["NATOcomms",AIT_NATOcomms,true];
	
	//Randomly distribute NATO's vehicles
	{
		_type = _x select 0;
		_num = _x select 1;
		_count = 0;
		while {_count < _num} do {
			_obj = AIT_NATOobjectives call BIS_fnc_selectRandom;
			_name = _obj select 1;
			_garrison = server getVariable format["vehgarrison%1",_name];
			_garrison pushback _type;
			_count = _count + 1;
			server setVariable [format ["vehgarrison%1",_name],_garrison,true];
		};
	}foreach(AIT_NATO_Vehicles_Garrison);
	
	{
		_type = _x select 0;
		_num = _x select 1;
		_count = 0;
		while {_count < _num} do {
			_name = AIT_allAirports call BIS_fnc_selectRandom;
			_garrison = server getVariable [format["airgarrison%1",_name],[]];
			_garrison pushback _type;
			_count = _count + 1;
			server setVariable [format ["airgarrison%1",_name],_garrison,true];
		};
	}foreach(AIT_NATO_Vehicles_AirGarrison);

	{
		_garrison = floor(8 + random(6));
		if(_x in AIT_NATO_priority) then {
			_garrison = floor(12 + random(6));
		};
			
		//_x setMarkerText format ["%1",_garrison];
		_x setMarkerAlpha 0;
		server setVariable [format ["garrison%1",_x],_garrison,true];
		sleep 0.05;
	}foreach (AIT_NATO_control);
	
	{
		_town = _x;
		_garrison = 0;	
		_stability = server getVariable format ["stability%1",_town];
		_population = server getVariable format ["population%1",_town];
		if(_stability > 10) then {
			_max = round(_population / 30);
			if(_max < 4) then {_max = 4};
			_garrison = 2+round((1-(_stability / 100)) * _max);
			if(_town in AIT_NATO_priority) then {
				_garrison = round(_garrison * 2);
			};
		};
		server setVariable [format ["garrison%1",_x],_garrison,true];
		server setVariable [format ["garrisonadd%1",_x], 0,false];
		sleep 0.05;
	}foreach (AIT_allTowns);
};
AIT_NATOobjectives = server getVariable "NATOobjectives";
AIT_NATOcomms = server getVariable "NATOcomms";

AIT_NATOInitDone = true;
publicVariable "AIT_NATOInitDone";

{
	_pos = _x select 0;
	_name = _x select 1;
	_mrk = createMarker [_name,[_pos,25,270] call BIS_fnc_relPos];
	_mrk setMarkerShape "ICON";
	if(_name in (server getVariable "NATOabandoned")) then {
		_mrk setMarkerType "flag_Tanoa";
	}else{
		_mrk setMarkerType "Faction_CUP_NATO";
	};
}foreach(AIT_NATOobjectives);

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
}foreach(AIT_NATOcomms);
		
sleep 5;
while {true} do {	
	_abandoned = server getVariable "NATOabandoned";
	_garrisoned = false;
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
			if(_town in AIT_NATO_priority) then {
				_garrison = round(_garrison * 2);
			};
			_need = _garrison - _current;
			if(_need < 0) then {_need = 0};
			if(_need > 1) then {
				_garrisoned = true;
				server setVariable [format ["garrisonadd%1",_x], 2,false];
				server setVariable [format ["garrison%1",_x],_current+2,true];
			};			
		}else{
			server setVariable [format ["garrison%1",_town],0,true];
			if(!(_town in _abandoned)) then {
				_town spawn NATOattack;
				_garrisoned = true;
				_abandoned pushback _town;
				server setVariable ["NATOabandoned",_abandoned,true];
			};
		};
		if(_garrisoned) exitWith {}; //only send one garrison per turn
		sleep 0.1;
	}foreach (AIT_allTowns);
	
	if !(_garrisoned) then {
		{
			_pos = _x select 0;
			_name = _x select 1;
			if !(_name in _abandoned) then {	
				_garrison = server getvariable format["garrison%1",_name];
				_vehgarrison = server getvariable format["vehgarrison%1",_name];
				
				if(_garrison == 0) then {
					_garrisoned = true;
					_name spawn NATOcounter;				
					_abandoned pushback _name;
					server setVariable ["NATOabandoned",_abandoned,true];
					_name setMarkerAlpha 1;				
				};
			};
			if(_garrisoned) exitWith {};
		}foreach(AIT_NATOobjectives);
	};
	
	{
		_pos = _x select 0;
		_name = _x select 1;
		if !(_name in _abandoned) then {			
			_garrison = server getvariable format["garrison%1",_name];				
			if(_garrison < 3) then {	
				_abandoned pushback _name;
				server setVariable ["NATOabandoned",_abandoned,true];				
				_name setMarkerColor "ColorGUER";
				_t = _pos call nearestTown;
				format["We have captured the radio tower near %1",_t] remoteExec ["notify_good",0,false];
			};
		};
		if(_garrisoned) exitWith {};
	}foreach(AIT_NATOcomms);
	
	
	{
		if(side _x == west and count (units _x) == 0) then {
			deleteGroup _x;
		};
	}foreach(allGroups);
	
	sleep AIT_NATOwait + round(random AIT_NATOwait);	
};

