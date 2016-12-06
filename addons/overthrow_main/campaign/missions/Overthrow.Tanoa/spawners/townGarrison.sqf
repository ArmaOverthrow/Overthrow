private ["_town","_posTown","_groups","_group","_numNATO","_pop","_count","_range"];
if (!isServer) exitwith {};

_count = 0;
params ["_town","_spawnid"];

private _abandoned = server getVariable ["NATOabandoned",[]];
if (_town in _abandoned) exitWith {};

_posTown = server getVariable _town;

_groups = [];

_numNATO = server getVariable format["garrison%1",_town];
_count = 0;
private _range = 350;
if(_town in OT_capitals) then {
	_range = 900;
};
_pergroup = 4;

while {_count < _numNATO} do {
	_groupcount = 0;
	_group = createGroup west;
	_groups pushBack _group;

	_home = [_posTown,[0,_range]] call SHK_pos;
	_building = [_home,OT_allHouses+OT_allShops+OT_offices] call OT_fnc_getRandomBuilding;
	if(typename _building != "BOOL") then {_home = position _building};
	_roads = _home nearRoads 100;
	if(count _roads > 0) then {_home = position (_roads select 0)};
	_civ = _group createUnit [OT_NATO_Unit_PoliceCommander, _home, [],0, "NONE"];
	sleep 0.1;
	_civ setVariable ["garrison",_town,false];
	[_civ] joinSilent _group;
	_civ setRank "CORPORAL";
	_civ setBehaviour "SAFE";
	[_civ,_town] call initGendarm;
	_count = _count + 1;
	_groupcount = _groupcount + 1;

	while {(_groupcount < _pergroup) and (_count < _numNATO)} do {
		_pos = [[[_home,50]]] call BIS_fnc_randomPos;

		_civ = _group createUnit [OT_NATO_Unit_Police, _pos, [],0, "NONE"];
		_civ setVariable ["garrison",_town,false];
		[_civ] joinSilent _group;
		_civ setRank "PRIVATE";
		[_civ,_town] call initGendarm;
		_civ setBehaviour "SAFE";

		_groupcount = _groupcount + 1;
		_count = _count + 1;
		sleep 0.1;
	};
	_group call initGendarmPatrol;
	_range = _range + 50;
};



spawner setvariable [_spawnid,(spawner getvariable [_spawnid,[]]) + _groups,false];
