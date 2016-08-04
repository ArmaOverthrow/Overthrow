private ["_leaderpos","_town","_building"];
_town = _this;

_posTown = server getVariable _town;

_near = nearestObjects [_posTown, AIT_crimHouses, 400];
_pos = _posTown;
if((count _near) > 0) then {
	_near = _near call BIS_fnc_arrayShuffle;
	_building = _near call BIS_Fnc_selectRandom;
	_pos = _building buildingpos 0;
};

_num = 3;

_leaderpos = [_pos, 0, 6, 0, 0, 40, 0] call BIS_fnc_findSafePos;
server setVariable [format["crimleader%1",_town],_leaderpos,true];
server setVariable [format ["timecrims%1",_town],0,true];
server setVariable [format ["numcrims%1",_town],_num,true];		
_skill = 0.7;		

if(_posTown call inSpawnDistance) then {
	_region = server getVariable format["region_%1",_town];
	_towns = server getVariable format["towns_%1",_region];
	
	_closest = [];
	{
		_pos = server getVariable _x;
		if((_pos distance _posTown) < 3500) then {
			_closest pushback _x;
		};
	}foreach(_towns);
	
	_start = _closest call BIS_fnc_selectRandom;
	_group = createGroup east;		
	
	_startpos = [(server getvariable _start), 0, 550, 1, 0, 20, 0] call BIS_fnc_findSafePos;
	_roadselect = _startpos nearRoads 300;
	
	_vehtype = AIT_vehTypes_crim call BIS_Fnc_selectRandom;
				
	_roadsel = _roadselect select 0;
	_startpos = getPos _roadsel;
	_startpos = _startpos findEmptyPosition [0,100,_vehtype];	
	_spawnpos = [_startpos, 0, 100, 1, 0, 0, 0] call BIS_fnc_findSafePos;

	_civ = _group createUnit [AIT_CRIM_Units_Para call BIS_Fnc_selectRandom, _spawnpos, [],0, "NONE"];
	[_civ] joinSilent _group;
	[_civ] call initCrimLeader;
	
	_dirveh = [_startpos,_leaderpos] call BIS_fnc_DirTo;
	
	_veh = _vehtype createVehicle _startpos;
	_veh setDir _dirveh;
				
	_veh addEventHandler ["HandleDamage",{if (((_this select 1) find "wheel" != -1) and (_this select 4=="") and (!isPlayer driver (_this select 0))) then {0;} else {(_this select 2);};}]; //Stops civilians from losing their wheels all the time
	//_civ moveInDriver _veh;
	_group addVehicle _veh;
	
	_wp = _group addWaypoint [_leaderpos,75];
	_wp setWaypointType "GETOUT";
	
	_wp = _group addWaypoint [_leaderpos,0];
	_wp setWaypointType "GUARD";
	_wp setWaypointFormation "LINE";
	
	_count = 0;
	while{_count < _num} do {
		_spawnpos = [_spawnpos, 0, 15, 0, 0, 20, 0] call BIS_fnc_findSafePos;
		_civ = _group createUnit [AIT_CRIM_Units_Bandit call BIS_Fnc_selectRandom, _spawnpos, [],0, "NONE"];

		[_civ] call initCriminal;
		//_civ moveInCargo _veh;
		_civ setskill _skill-0.2;
		
		[_civ] joinSilent _group;
		sleep 0.1;
		_count = _count + 1;
	};
};