params ["_pos","_strength","_success","_fail","_params"];
private _numPlayers = count([] call CBA_fnc_players);
if(_numPlayers < 4) then {
	_strength = round(_strength * 0.5);
}else{
	if(_numPlayers > 5) then {
		_strength = round(_strength * 1.2);
	};
};
spawner setVariable ["NATOattackforce",[],false];
//determine possible vectors for non-infantry assets and distribute strength to each

private _isCoastal = false;
private _objectiveIsControlled = false;
private _airfieldIsControlled = false;

private _seaStrength = 0;
private _landStrength = 0;
private _airStrength = 0;

//Sea?
if(surfaceIsWater ([_pos,500,0] call BIS_fnc_relPos) or surfaceIsWater ([_pos,500,90] call BIS_fnc_relPos) or surfaceIsWater ([_pos,500,180] call BIS_fnc_relPos) or surfaceIsWater ([_pos,500,270] call BIS_fnc_relPos)) then {
	_isCoastal = true;
};

//Land?
private _town = _pos call nearestTown;
private _region = server getVariable format["region_%1",_town];
private _closestObjectivePos = [];
private _closestObjective = "";
private _dist = 20000;
{
	_p = _x select 0;
	_name = _x select 1;
	if([_p,_region] call CBA_fnc_inArea and !(_name in (server getvariable ["NATOabandoned",[]]))) then {
		_d = (_p distance _pos);
		if(_d < _dist and _d > 500) then {
			_dist = _d;
			_closestObjectivePos = _p;
			_closestObjective = _name;
		};
	};
}foreach(OT_NATOobjectives);

if (count _closestObjectivePos > 0) then {
	_objectiveIsControlled = true;
};

private _closestAirfieldPos = [];
private _closestAirfield = "";
private _dist = 20000;
{
	_p = _x select 0;
	_name = _x select 1;
	if(_name in OT_allAirports) then {
		_d = (_p distance _pos);
		if(_d < _dist and _d > 1500) then {
			_dist = _d;
			_closestAirfieldPos = _p;
			_closestAirfield = _name;
		};
	};
}foreach(OT_NATOobjectives);

if !(_closestAirfield in (server getvariable ["NATOabandoned",[]])) then {
	_airfieldIsControlled = true;
};

private _s = _strength;

if(_isCoastal) then {
	_seaStrength = round(random _s);
	_s = _s - _seaStrength;
};

if(_s > 0 and _objectiveIsControlled) then {
	_landStrength = round(random _s);
	_s = _s - _landStrength;
};

if(_s > 0) then {
	_airStrength = _s;
};


_numgroups = floor(_strength / 120);
_count = 0;
private _delay = 0;
while {_count < _numgroups} do {
	[[OT_NATO_HQPos,[0,100],random 360] call SHK_pos,_pos,_delay] spawn NATOAirSupport;		
	_count = _count + 1;
	_delay = _delay + 20;
};

//Ground units

//Send main force via HQ by air
private _dir = [_pos,OT_NATO_HQPos] call BIS_fnc_dirTo;	
private _ao = [_pos,[500,800],(_dir - 45) + random 90] call SHK_pos;

if(surfaceIsWater _ao) then {
	_ao = [_pos,[500,800],-(_dir + 45) - random 90] call SHK_pos;
};

if((_pos select 0) < 1000) then{
	_ao = [_pos,[500,800],90] call SHK_pos;
};
private _numgroups = 1+floor(_strength / 150);
private _count = 0;
if(_delay > 0) then {
	_delay = _delay + 10;
};
while {_count < _numgroups} do {
	[OT_NATO_HQPos,_ao,_pos,true,_delay] spawn NATOGroundForces;
	_ao = [_pos,[500,800],(_dir - 45) + random 90] call SHK_pos;
	if(surfaceIsWater _ao) then {
		_ao = [_pos,[500,800],-(_dir + 45) - random 90] call SHK_pos;
	};
	_count = _count + 1;
	_delay = _delay + 20;
};

if(_objectiveIsControlled) then {
	//send some units by ground from the closest objective
	_dir = [_pos,_closestObjectivePos] call BIS_fnc_dirTo;	
	_ao = [_pos,[500,800],(_dir - 45) + random 90] call SHK_pos;
	
	[_closestObjectivePos,_pos,_landStrength,0] spawn NATOGroundSupport;
		
	_numgroups = 1+floor(_landStrength / 250);
	_count = 0;
	_delay = 20;
	while {_count < _numgroups} do {
		[_closestObjectivePos,_ao,_pos,false,_delay] spawn NATOGroundForces;
		_ao = [_pos,[500,800],(_dir - 45) + random 90] call SHK_pos;		
		_count = _count + 1;
		_delay = _delay + 10;
	};
};

if(_airfieldIsControlled) then {
	//send some units by air from the closest airfield
	_dir = [_pos,_closestAirfieldPos] call BIS_fnc_dirTo;	
	_ao = [_pos,[400,600],(_dir - 45) + random 90] call SHK_pos;
	if(surfaceIsWater _ao) then {
		_ao = [_pos,[400,600],-(_dir + 45) - random 90] call SHK_pos;
	};
	_numgroups = floor(_airStrength / 120);
	_count = 0;
	_delay = 0;
	while {_count < _numgroups} do {
		[[_closestAirfieldPos,[0,100],random 360] call SHK_pos,_pos,_delay] spawn NATOAirSupport;			
		_count = _count + 1;
		_delay = _delay + 20;
	};
	_numgroups = floor(_airStrength / 200);
	_count = 0;
	_delay = 0;
	while {_count < _numgroups} do {
		[_closestAirfieldPos,_ao,_pos,true,_delay] spawn NATOGroundForces;
		_ao = [_pos,[400,600],(_dir - 45) + random 90] call SHK_pos;
		if(surfaceIsWater _ao) then {
			_ao = [_pos,[400,600],-(_dir + 45) - random 90] call SHK_pos;
		};
		_count = _count + 1;
		_delay = _delay + 20;
	};
};

_timeout = time + 800;

waitUntil {
	sleep 5;
	private _force = spawner getVariable["NATOattackforce",[]];
	(({alive leader _x} count _force) == 0) or (time > _timeout)
};

_timeout = time + 600;
_won = false;
while {sleep 5;time < _timeout and !_won} do {

	_alive = 0;
	_enemy = 0;
	{
		if((side _x == west) and (alive _x) and (_x getVariable ["garrison",""] == "HQ")) then {
			_alive = _alive + 1;		
		};
		if((side _x == resistance) and (alive _x) and !(_x getvariable ["ace_isunconscious",false])) then {		
			_enemy = _enemy + 1;		
		};
	}foreach(_pos nearEntities ["Man",350]);
	if(_alive > 0 and _enemy == 0) then {
		//Nato has won
		_params call _success;
		_won = true;
	};
	if(_alive == 0) exitWith{};
};
if !(_won) then {
	_params call _fail;
};

server setVariable ["NATOattacking","",true];