private ["_id","_town","_posTown","_groups","_numNATO","_pop","_count","_range"];
if (!isServer) exitwith {};

_count = 0;
_town = _this;
_posTown = server getVariable _town;

_groups = [];

_numNATO = server getVariable format["garrison%1",_town];
_count = 0;
_range = 300;
_pergroup = 4;
			
while {_count < _numNATO} do {
	_groupcount = 0;
	_group = createGroup blufor;				
	_groups pushBack _group;
	
	_start = [[[_posTown,_range]]] call BIS_fnc_randomPos;
	_civ = _group createUnit [AIT_NATO_Unit_PoliceCommander, _start, [],0, "NONE"];
	_civ setVariable ["garrison",_town,false];

	_civ setRank "CORPORAL";
	_civ setBehaviour "SAFE";
	[_civ,_town] call initPolice;
	_count = _count + 1;
	_groupcount = _groupcount + 1;
	
	while {(_groupcount < _pergroup) and (_count < _numNATO)} do {							
		_pos = [[[_start,50]]] call BIS_fnc_randomPos;
		
		_civ = _group createUnit [AIT_NATO_Unit_Police, _pos, [],0, "NONE"];
		_civ setVariable ["garrison",_town,false];

		_civ setRank "PRIVATE";
		[_civ,_town] call initPolice;
		_civ setBehaviour "SAFE";
		
		_groupcount = _groupcount + 1;
		_count = _count + 1;
		
	};				
	_group call initPolicePatrol;				
	_range = _range + 50;
	sleep 0.03;
};

{
	_cur = _x;
	{	
		_cur addCuratorEditableObjects [(units _x),true];				
	}foreach(_groups);				
} forEach allCurators;

_groups spawn {
	sleep 1;
	{	
		{					
			_x setDamage 0;							
		}foreach(units _x);							
	}foreach(_this);		
};
_groups