private ["_town","_posTown","_groups","_group","_numNATO","_pop","_count","_range"];
if (!isServer) exitwith {};
sleep random 0.2;
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

while {_count < _numNATO} do {
	_groupcount = 0;
	_group = createGroup west;
	_group deleteGroupWhenEmpty true;
	_groups pushBack _group;

	_home = _town call OT_fnc_getRandomRoadPosition;
	_civ = _group createUnit [OT_NATO_Unit_PoliceCommander, _home, [],0, "NONE"];

	_civ setVariable ["garrison",_town,false];
	[_civ] joinSilent _group;
	_civ setRank "CORPORAL";
	_civ setBehaviour "SAFE";
	[_civ,_town] call OT_fnc_initGendarm;

	_pos = _home findEmptyPosition [0,50];

	_civ = _group createUnit [OT_NATO_Unit_Police, _pos, [],0, "NONE"];
	_civ setVariable ["garrison",_town,false];
	[_civ] joinSilent _group;
	_civ setRank "PRIVATE";
	[_civ,_town] call OT_fnc_initGendarm;
	_civ setBehaviour "SAFE";

	sleep 0.2;
	_group call OT_fnc_initGendarmPatrol;
	_range = _range + 50;
	_count = _count + 2;
};



spawner setvariable [_spawnid,(spawner getvariable [_spawnid,[]]) + _groups,false];
