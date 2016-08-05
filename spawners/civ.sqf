private ["_shops","_houses","_count","_town","_posTown","_groups","_popVar","_pop","_group","_type","_civ","_civs","_start","_end","_wp","_civTypes","_roadsel","_roadcon","_roadend","_dirveh","_vehtype","_roadselect","_spawned","_dealer","_carshops"];
if (!isServer) exitwith {};

AIT_allMusic = [""];

waitUntil{not isNil "AIT_economyInitDone"};
waitUntil{not isNil "AIT_CRIMInitDone"};

_count = 0;
_town = _this select 0;
_posTown = server getVariable _town;
_groups = [];
_civs = [];
_pos = [];
_start = [];
_spawned = [];
_numCiv = 0;

_popVar=format["population%1",_town];
_pop = server getVariable _popVar;
_shops = server getVariable format ["shops%1",_town];
_houses = server getVariable format ["houses%1",_town];
_stability = server getVariable format ["stability%1",_town];
_carshops = [];

spawner setVariable [_town,true,true];

_numVeh = 0;

if(_pop > 15) then {
	_numCiv = round(_pop * 0.05);
	_numVeh = 2 + round(_pop * 0.01);
}else {
	_numCiv = _pop;
};
_hour = date select 3;

_civTypes = AIT_civTypes_locals;

if(_pop > 150) then {
	//expats like to live here
	_civTypes = _civTypes + AIT_civTypes_expats;
};
if(_pop > 350) then {
	_civTypes = _civTypes + AIT_civTypes_tourists;
};

if(_hour > 18 || _hour < 6) then {
	//spawn less people
	_numCiv = round(_numCiv * 0.5);
};

_mSize = 400;
if(_town in AIT_capitals) then {
	_mSize = 900;
};

_buildings = [];

_gundealerpos = server getVariable format["gundealer%1",_town];
if(isNil "_gundealerpos") then {
	_building = (nearestObjects [_posTown, AIT_gunDealerHouses, _mSize+100]) call BIS_Fnc_selectRandom;
	_gundealerpos = [getpos _building, 0, 6, 0, 0, 40, 0] call BIS_fnc_findSafePos;
	server setVariable [format["gundealer%1",_town],_gundealerpos,true];
	_building setVariable ["owner",true,true];
};

_group = createGroup civilian;		
_group setBehaviour "CARELESS";
_groups pushBack _group;
_type = AIT_civTypes_gunDealers call BIS_Fnc_selectRandom;
_pos = [_gundealerpos, 0, 20, 3, 0, 20, 0] call BIS_fnc_findSafePos;
_dealer = _group createUnit [_type, _gundealerpos, [],0, "NONE"];
_civs pushBack _dealer;

_all = server getVariable "activedealers";
_all pushback _dealer;
server setVariable ["activedealers",_all,true];

_wp = _group addWaypoint [_gundealerpos,0];
_wp setWaypointType "MOVE";
_wp setWaypointSpeed "LIMITED";

_dealer remoteExec ["initGunDealerLocal",0,true];
[_dealer] call initCivilian;

_onCivKilled = _dealer addEventHandler ["killed",{
	_me = _this select 0;
	_town = (getpos _me) call nearestTown;
	server setVariable [format["gundealer%1",_town],objNULL,true];
	server setVariable [format["gunstock%1",_town],objNULL,true];
}];

_count = 0;
{
	_s = _x getVariable "spawned";
	if (isNil "_s") then {
		_s = false;
	};
	if !(_s) then {
		
		
		_type = (AIT_civTypes_locals + AIT_civTypes_expats) call BIS_Fnc_selectRandom;
		_x setVariable ["spawned",true,true];
		_buildings pushBack _x;
		_spawned = _x call spawnTemplate;
		{
			_civs pushback _x;
		}foreach(_spawned select 0);
		
		_pos = getpos _x;
		_cashdesk = _pos nearestObject AIT_item_ShopRegister;
		
		_spawnpos = [getpos _x, 0, 30, 1, 0, 0, 0] call BIS_fnc_findSafePos;
				
		_group = createGroup civilian;		
		_group setBehaviour "CARELESS";
		_groups pushBack _group;
		_civ = _group createUnit [_type, _spawnpos, [],0, "NONE"];
		_civs pushBack _civ;
		
		_all = server getVariable "activecarshops";
		_all pushback _civ;
		server setVariable ["activecarshops",_all,true];
		
		AIT_activeCarShops pushBack _civ;
		
		_civ remoteExec ["initCarShopLocal",0,true];
		[_civ] call initCivilian;
		
		_count = _count + 1;
	};
}foreach(nearestObjects [_posTown, AIT_carShops, _mSize]);

publicVariable "AIT_activeCarShops";

while {(spawner getVariable _town) and (_count < _numCiv)} do {	
	if(_hour > 18 || _hour < 6) then {
		_start = [_houses call BIS_Fnc_selectRandom, 0, 50, 1, 0, 20, 0] call BIS_fnc_findSafePos;
		_end = _houses call BIS_Fnc_selectRandom;
	}else{
		_start = [(_shops + _houses) call BIS_Fnc_selectRandom, 0, 50, 1, 0, 20, 0] call BIS_fnc_findSafePos;
		if(random(100) > 90) then {
			//chance they'll go to another town in the same region
			_region = server getVariable format["region_%1",_town];
			if(!isNil "_region") then {
				_towns = server getVariable format["towns_%1",_region];
				_dest = _towns call BIS_Fnc_selectRandom;
				if(_dest != _town) then {
					_desthouses = server getVariable format ["houses%1",_dest];
					_destshops = server getVariable format ["shops%1",_dest];
					_end = (_destshops + _desthouses) call BIS_Fnc_selectRandom;
				}else{
					//well they are definitely going to a shop then
					_end = _shops call BIS_Fnc_selectRandom;
				};
			};
		}else{
			_end = (_shops + _houses) call BIS_Fnc_selectRandom;
		};		
		
	};

	_group = createGroup civilian;
	
	_group setBehaviour "CARELESS";
	_groups pushBack _group;
	_type = _civTypes call BIS_Fnc_selectRandom;
	if(!isNil "_start")then {
	
		_civ = _group createUnit [_type, _start, [],0, "NONE"];
		_civs pushBack _civ;
		[_civ] call initCivilian;
		
		//got car?
		if((_start distance _end) > 550) then {
			_roadselect = _start nearRoads 50;
			
			if(count(_roadselect) > 0) then {	
				_roadsel = _roadselect select 0;
				_start = getPos _roadsel;
				_roadselect = _end nearRoads 50;			
				if(count(_roadselect) > 0) then {			
					_end = getPos (_roadselect select 0);
					
					_dirveh = [_start,_end] call BIS_fnc_DirTo;
					_vehtype = AIT_vehTypes_civ call BIS_Fnc_selectRandom;
					_veh = _vehtype createVehicle _start;
					_veh setDir _dirveh;
								
					_veh addEventHandler ["HandleDamage",{if (((_this select 1) find "wheel" != -1) and (_this select 4=="") and (!isPlayer driver (_this select 0))) then {0;} else {(_this select 2);};}]; //Stops civilians from losing their wheels all the time
					_civ moveInDriver _veh;
					_group addVehicle _veh;
				};
			};
		};

		_wp = _group addWaypoint [_end,0];
		_wp setWaypointType "MOVE";
		_wp setWaypointSpeed "LIMITED";
		_wp setWaypointCompletionRadius 10;
		_wp setWaypointTimeout [0, 4, 8];
		
		_wp = _group addWaypoint [_start,0];
		_wp setWaypointType "MOVE";
		_wp setWaypointSpeed "LIMITED";
		_wp setWaypointCompletionRadius 10;
		_wp setWaypointTimeout [0, 4, 8];
		
		_wp1 = _group addWaypoint [_start,0];
		_wp1 setWaypointType "CYCLE";
		_wp1 synchronizeWaypoint [_wp];

		_count = _count + 1;
		
		sleep 0.01;
	};
};

if(_stability > 10) then {
	_numNATO = server getVariable format["garrison%1",_town];
	_count = 0;
	_range = 150; //start in the middle and work our way out
	while {(spawner getVariable _town) and (_count < _numNATO)} do {
		_left = _numNATO - _count;
		_group = createGroup blufor;
				
		_groups pushBack _group;
		
		_start = [_posTown, _range-150, _range, 4, 0, 20, 0] call BIS_fnc_findSafePos;
				
		if(_left < 2) then {
			_civ = _group createUnit [AIT_NATO_Unit_PoliceCommander, _start, [],0, "NONE"];
			_civs pushBack _civ;
			_civ setBehaviour "SAFE";
			[_civ] call initPolice;
			_count = _count + 1;
		}else {
			_civ = _group createUnit [AIT_NATO_Unit_PoliceCommander, _start, [],0, "NONE"];
			_civs pushBack _civ;
			[_civ] call initPolice;
			_civ setBehaviour "SAFE";
			sleep 0.01;
			_start = [_start, 0, 15, 4, 0, 20, 0] call BIS_fnc_findSafePos;
			_civ = _group createUnit [AIT_NATO_Unit_Police, _start, [],0, "NONE"];
			_civs pushBack _civ;
			[_civ] call initPolice;
			_civ setBehaviour "SAFE";
			_count = _count + 2;
		};
		_group call initPolicePatrol;
		_range = _range + 150;
		
		sleep 0.01;
	};
};
sleep 1;
_numcrims = server getVariable format["numcrims%1",_town];
if(isNil "_numcrims") then {
	_numcrims = 0;
};
_time = server getVariable format ["timecrims%1",_town];
_leaderpos = server getVariable format["crimleader%1",_town];
_group = objNULL;

_skill = 0.7;
if(_time > 0) then {
	_skill = 0.7 + (0.3 * (_time / 7200));
	if(_skill > 0.95) then {
		_skill = 0.95;
	};
};

if ((typeName _leaderpos) == "ARRAY") then {
	//spawn the leader
	_group = createGroup east;		
	_group setBehaviour "CARELESS";	
	_spawnpos = [_leaderpos, 0, 20, 0, 0, 20, 0] call BIS_fnc_findSafePos;
	_type = AIT_CRIM_Units_Para call BIS_Fnc_selectRandom;
	_civ = _group createUnit [_type, _spawnpos, [],0, "NONE"];
	[_civ] joinSilent _group;
	_civs pushBack _civ;
	[_civ] call initCrimLeader;
	_civ setskill _skill;

	_wp = _group addWaypoint [_leaderpos,0];
	_wp setWaypointType "MOVE";
	_wp setWaypointSpeed "LIMITED";
	
	_wp = _group addWaypoint [_leaderpos,0];
	_wp setWaypointType "GUARD";
	_wp setWaypointFormation "LINE";
}else{	
	if(_numcrims > 0) then {
		_leaderpos = [(_shops + _houses) call BIS_Fnc_selectRandom, 0, 50, 1, 0, 20, 0] call BIS_fnc_findSafePos;
		_group = createGroup east;
		_group setBehaviour "CARELESS";	
		
		_wp = _group addWaypoint [_leaderpos,0];
		_wp setWaypointType "MOVE";
		_wp setWaypointSpeed "LIMITED";
		_wp setWaypointTimeout [0, 5, 10];
		
		_end = [(_shops + _houses) call BIS_Fnc_selectRandom, 0, 50, 1, 0, 20, 0] call BIS_fnc_findSafePos;
		
		_wp = _group addWaypoint [_end,0];
		_wp setWaypointType "MOVE";
		_wp setWaypointSpeed "LIMITED";
		_wp setWaypointTimeout [0, 5, 10];
		
		_wp = _group addWaypoint [_leaderpos,0];
		_wp setWaypointType "CYCLE";
		_wp setWaypointSpeed "LIMITED";
	}
};
_count = 0;
if !(isNull _group) then {
	_groups pushBack _group;
	while {_count < _numcrims} do {
		_spawnpos = [_leaderpos, 0, 20, 0, 0, 20, 0] call BIS_fnc_findSafePos;
		_types = AIT_CRIM_Units_Bandit;
		if(_time >= 3600) then {
			_types = AIT_CRIM_Units_Para;
		};
		_type = _types call BIS_Fnc_selectRandom;
		_civ = _group createUnit [_type, _spawnpos, [],0, "NONE"];
		_civs pushBack _civ;
		[_civ] call initCriminal;
		_count = _count + 1;
		_civ setskill _skill-0.2;
		
		[_civ] joinSilent _group;
		sleep 0.1;
	};
};
_count = 0;
while {(spawner getVariable _town) and (_count < _numVeh)} do {	
	_roadselect = _posTown nearRoads _mSize;
	_road = (_roadselect call BIS_Fnc_selectRandom);
	_pos = getPos _road;
	_vehtype = AIT_vehTypes_civ call BIS_Fnc_selectRandom;
	_pos = _pos findEmptyPosition [5,25,_vehtype];
	if (count _pos > 0) then {
		_roadscon = roadsConnectedto (_roads select 0);
		_dirveh = [_road, _roadscon select 0] call BIS_fnc_DirTo;
		_posVeh = [_pos, 3, _dirveh + 90] call BIS_Fnc_relPos;
	
		_veh = _vehtype createVehicle _pos;
		clearItemCargoGlobal _veh;
				
		_veh setDir _dirveh;
		_civs pushBack _veh;
					
		_veh addEventHandler ["GetIn",{
			_unit = _this select 2;
			if(blufor knowsAbout _unit > 1.4) then {
				_unit setCaptive false;			
			};
		}];
		sleep 0.1;
	};
	_count = _count + 1;	
};

sleep 1;

{_x setDamage 0} forEach _civs; //clear up any woopsies on spawn (to-do: spawn where they wont get hurt lol)

waitUntil {sleep 1;not (spawner getVariable _town)};

{deleteGroup _x} forEach _groups;
{
	_owner = _x getVariable "owner";
	if(isNil "_owner") then {
		deleteVehicle _x;
	};	
} forEach _civs;
{
	_x setVariable ["spawned",false,true];
}foreach _buildings;
