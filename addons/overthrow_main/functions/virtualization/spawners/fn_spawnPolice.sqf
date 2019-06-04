private ["_town","_posTown","_groups","_group","_numNATO","_pop","_count","_range"];
if (!isServer) exitwith {};
sleep random 0.2;


_count = 0;
params ["_town","_spawnid"];
private _abandoned = server getVariable ["NATOabandoned",[]];
if !(_town in _abandoned) exitWith {};

_posTown = server getVariable [format["policepos%1",_town],server getVariable _town];

_groups = [];

private _soldier = "Police" call OT_fnc_getSoldier;

_numNATO = server getVariable [format["police%1",_town],0];
_count = 0;
_range = 15;
_pergroup = 4;

while {_count < _numNATO} do {
	_groupcount = 0;
	_group = createGroup resistance;
	_group setVariable ["VCM_TOUGHSQUAD",true,true];
	_group setVariable ["VCM_NORESCUE",true,true];
	_groups pushBack _group;

	_start = [[[_posTown,_range]]] call BIS_fnc_randomPos;

	while {(_groupcount < _pergroup) && (_count < _numNATO)} do {
		_pos = [[[_start,20]]] call BIS_fnc_randomPos;

		_civ = [_soldier,_pos,_group,false] call OT_fnc_createSoldier;
		sleep 0.3;

		[_civ] joinSilent _group;
		_civ setRank "SERGEANT";
		[_civ,_town] spawn OT_fnc_initPolice;
		_civ setBehaviour "SAFE";

		_groupcount = _groupcount + 1;
		_count = _count + 1;
		sleep 0.5;
	};
	[_group,_posTown,100,6] call CBA_fnc_taskPatrol;
	_range = _range + 50;
};



spawner setvariable [_spawnid,(spawner getvariable [_spawnid,[]]) + _groups,false];
