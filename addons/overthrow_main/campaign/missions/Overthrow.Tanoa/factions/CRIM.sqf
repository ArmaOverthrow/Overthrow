if (!isServer) exitwith {};

_leaderpos = objNULL;
OT_CRIMmobsters = [];

waitUntil {!isNil "OT_NATOInitDone"};

_activemobsters = server getVariable ["activemobsters",false];
if((server getVariable "StartupType") == "NEW" or (server getVariable ["CRIMversion",0]) < OT_CRIMversion) then {
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
			_garrison = 4 + round(random 4);
			_building = [_posTown, OT_crimHouses] call getRandomBuilding;
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
	
	
	_mobsters = [];
	_t = 0;
	{		
		_pos = _x select 0;
		_pos set [2,0];
		if !(_pos isFlatEmpty  [-1, -1, 0.5, 10] isEqualTo []) then {
			_ob = _pos call nearestObjective;
			_town = _pos call nearestTown;
			
			_obpos = _ob select 0;
			_obdist = _obpos distance _pos;
			
			_towndist = 500;
			if (!isNil "_town") then {
				if !(_town in (server getVariable ["NATOabandoned",[]])) then {
					_stability = server getVariable format ["stability%1",_town];
					_population = server getVariable format ["population%1",_town];
					_towndist = (server getVariable _town) distance _pos;				
					if(_stability < 20) then {
						_towndist = _towndist * 2;
					};
					if(_stability > 60) then {
						_towndist = _towndist * 0.5;
					};
					if(_population < 160) then {
						_towndist = _towndist * 2;
					};
				};			
			};
			
			_control = _pos call nearestCheckpoint;
			_cdist = (getmarkerpos _control) distance _pos;
			
			_mdist = 2000;
			if(count _mobsters > 0) then {
				_mdist = _pos distance ((_pos call nearestMobster) select 0);
			};
			
			if(_obdist > 1000 and _towndist > 400 and _cdist > 800 and _mdist > 700) then {
				_t = _t + 1;
				
				_garrison = 6 + round(random 4);
				
				_mobsters pushback [_pos,_t];
				server setVariable ["activemobsters",_mobsters,false];
				server setVariable [format["crimgarrison%1",_t],_garrison];
				server setVariable [format["mobleader%1",_t],_pos];
			};
		};
	}foreach (selectBestPlaces [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), 50000,"(1 + forest + trees) * (1 - houses) * (1 - sea)",10,600]);
	
	server setVariable ["activemobsters",_mobsters,true];
};
OT_CRIMInitDone = true;
publicVariable "OT_CRIMInitDone";

_sleeptime = 20;

while {true} do {
	if(count allPlayers > 0) then {		
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
					_mob = _posTown call nearestMobster;
					_mobpos = _mob select 0;
					_region = server getVariable [format["region_%1",_town],""];
					if(_region != "") then {
						if([_mobpos,_region] call fnc_isInMarker) then {
							if ((typeName _leaderpos) == "ARRAY") then {
								server setVariable [format ["timecrims%1",_x],_time+_sleeptime,false];
								_chance = 20;
								_max = 4;
								if(_town in (server getVariable ["NATOabandoned",[]])) then {
									_chance = 80;
									_max = 10;
								};								
								
								if(((random 100) < _chance) and _num < _max) then {
									_numadd = round(random 4);																	
									if(_leaderpos call inSpawnDistance) then {
										[_leaderpos,_numadd,_x] spawn sendCrims;
									}else{
										server setVariable [format ["numcrims%1",_x],_num+_numadd,true];
									};
								};
							}else{							
								//New leader spawn
								
								_building = [_posTown, OT_crimHouses] call getRandomBuilding;
								if(isNil "_building") then {
									_leaderpos = [[[_posTown,50]]] call BIS_fnc_randomPos;
								}else{
									_leaderpos = getpos _building;
								};	
								
								[_leaderpos,_x] spawn newLeader;
																
								server setVariable [format ["timecrims%1",_x],0,false];	

								[2,_leaderpos,"Gang Hideout",format["Intelligence reports that this building was recently purchased by a known underworld figure, it's possible they will use this location as a base of operations for a new gang in %1.",_town],"target"] remoteExec ["intelEvent",0,false];
							};
						};
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

