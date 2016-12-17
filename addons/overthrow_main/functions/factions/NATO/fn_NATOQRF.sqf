params ["_pos","_strength","_success","_fail","_params"];
private _numPlayers = count([] call CBA_fnc_players);
if(_numPlayers < 3) then {
	_strength = round(_strength * 0.4);
}else{
	if(_numPlayers < 6) then {
		_strength = round(_strength * 0.7);
	}else{
		if(_numPlayers > 10) then {
			_strength = round(_strength * 1.5);
		};
	}
};
private _diff = server getVariable ["OT_difficulty",1];
if(_diff == 0) then {
	_strength = round(_strength * 0.5);
};
if(_diff == 2) then {
	_strength = round(_strength * 2);
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

if(OT_NATO_Navy_HQ in (server getvariable ["NATOabandoned",[]])) then {
	_isCoastal = false;
};

//Land?
private _town = _pos call OT_fnc_nearestTown;
private _region = server getVariable format["region_%1",_town];
private _closestObjectivePos = [];
private _closestObjective = "";
private _dist = 20000;
{
	_p = _x select 0;
	_name = _x select 1;
	if(_p inArea _region and !(_name in (server getvariable ["NATOabandoned",[]]))) then {
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

if (_closestAirfield != "") then {
	if !(_closestAirfield in (server getvariable ["NATOabandoned",[]])) then {
		_airfieldIsControlled = true;
	};
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
diag_log format["Overthrow: Attack start on %1 (sea:%2 land:%3 air:%4)",_pos,_seaStrength,_landStrength,_airStrength];

if(_seaStrength > 0) then {
	private _numgroups = 1;
	if(_seaStrength > 50) then {_numgroups = 2};
	if(_seaStrength > 150) then {_numgroups = 3};
	private _delay = 0;
	private _p = getMarkerPos OT_NATO_Navy_HQ;
	private _count = 0;
	while {_count < _numgroups} do {
		diag_log format["Overthrow: Sending sea support %1",_p];
		[[_p,[0,100],random 360] call SHK_pos,_pos,_delay] spawn OT_fnc_NATOSeaSupport;
		_count = _count + 1;
		_delay = _delay + 20;
	};
};

_numgroups = 1;
if(_airStrength < 60) then {_numgroups = 0};
if(_airStrength > 1000) then {_numgroups = 2};
_count = 0;
private _delay = 0;
while {_count < _numgroups} do {
	diag_log format["Overthrow: Sending HQ air support %1",OT_NATO_HQPos];
	[[OT_NATO_HQPos,[0,100],random 360] call SHK_pos,_pos,_delay] spawn OT_fnc_NATOAirSupport;
	_count = _count + 1;
	_delay = _delay + 20;
};

//Ground units

//Send main force via HQ by air
private _dir = [_pos,OT_NATO_HQPos] call BIS_fnc_dirTo;
private _ao = [_pos,_dir] call OT_fnc_getAO;

private _max = 5;
if(_numPlayers < 3 or _diff == 0) then {
	_max = 3;
};
if(_numPlayers > 10 or _diff > 1) then {
	_max = 7;
};
private _numgroups = 1+floor(_strength / 100);
if(_numgroups > _max) then {
	_numgroups = _max;
};
private _count = 0;
if(_delay > 0) then {
	_delay = _delay + 10;
};
while {_count < _numgroups} do {
	diag_log format["Overthrow: Sending HQ ground forces %1",_ao];
	[OT_NATO_HQPos,_ao,_pos,true,_delay] spawn OT_fnc_NATOGroundForces;
	_ao = [_pos,_dir] call OT_fnc_getAO;
	_count = _count + 1;
	_delay = _delay + 20;
};

if(_objectiveIsControlled) then {
	//send some units by ground from the closest objective
	_dir = [_pos,_closestObjectivePos] call BIS_fnc_dirTo;
	_ao = [_pos,_dir] call OT_fnc_getAO;

	[_closestObjectivePos,_pos,_landStrength,0] spawn OT_fnc_NATOGroundSupport;

	_numgroups = 1+floor(_landStrength / 250);
	if(_numgroups > 2) then {
		_numgroups = 2;
	};
	_count = 0;
	_delay = 20;
	while {_count < _numgroups} do {
		diag_log format["Overthrow: Sending ground forces %1",_closestObjectivePos];
		[_closestObjectivePos,_ao,_pos,false,_delay] spawn OT_fnc_NATOGroundForces;
		_ao = [_pos,_dir] call OT_fnc_getAO;
		_count = _count + 1;
		_delay = _delay + 10;
	};
};

if(_airfieldIsControlled) then {
	//send some units by air from the closest airfield
	_dir = [_pos,_closestAirfieldPos] call BIS_fnc_dirTo;
	_ao = [_pos,_dir] call OT_fnc_getAO;
	_numgroups = 1;
	if(_airStrength < 60) then {_numgroups = 0};
	_count = 0;
	_delay = 0;
	while {_count < _numgroups} do {
		diag_log format["Overthrow: Sending Air support %1",_closestAirfieldPos];
		[[_closestAirfieldPos,[0,100],random 360] call SHK_pos,_pos,_delay] spawn OT_fnc_NATOAirSupport;
		_count = _count + 1;
		_delay = _delay + 20;
	};
	_numgroups = floor(_strength / 150);
	if(_numgroups > 2) then {
		_numgroups = 2;
	};
	_count = 0;
	_delay = 0;
	while {_count < _numgroups} do {
		[_closestAirfieldPos,_ao,_pos,true,_delay] spawn OT_fnc_NATOGroundForces;
		_ao = [_pos,_dir] call OT_fnc_getAO;
		_count = _count + 1;
		_delay = _delay + 20;
	};
};

sleep 200; //Give NATO some time to get their shit together

private _timeout = time + 800;

waitUntil {
	sleep 5;
	private _force = spawner getVariable["NATOattackforce",[]];
	private _numalive = 0;
	private _numin = 0;
	{
		_numalive = _numalive + ({alive _x} count (units _x));
		_numin = _numin + ({alive _x and _x distance _pos < 150} count (units _x));
	}foreach(_force);
	(_numalive < 4) or (time > _timeout) or (_numin > 4)
};

_timeout = time + 1200;
_won = false;
while {sleep 5;time < _timeout and !_won} do {

	_alive = 0;
	_enemy = 0;
	{
		if(_x distance _pos < 1000) then {
			_g = (_x getVariable ["garrison",""]);
			if(typename _g != "STRING") then {_g = "HQ"};
			if((side _x == west) and (alive _x) and (_g == "HQ")) then {
				_alive = _alive + 1;
			};
			if((side _x == resistance) and (alive _x) and !(_x getvariable ["ace_isunconscious",false])) then {
				_enemy = _enemy + 1;
			};
		};
	}foreach(allunits);
	if(_alive > 0 and _enemy == 0) exitWith {
		//Nato has won
		_params call _success;

		//Recover resources
		server setVariable ["NATOresources",round(_strength * 0.5),true];
		{
			if(side _x == west) then {
				_lead = (units _x) select 0;
				if(_lead getVariable ["garrison",""] == "HQ") then {
					if(vehicle _lead != _lead) then {
						[vehicle _lead] spawn OT_fnc_cleanup;
					};
					[_x] spawn OT_fnc_cleanup;
				};
			}
		}foreach(allgroups);
		_won = true;
	};
	diag_log format["Overthrow: Win/Loss BLU %1  RES %2",_alive,_enemy];
	if(_alive < 4) exitWith{};
};
if !(_won) then {
	_params call _fail;
	//Nato gets pushed back
	server setVariable ["NATOresources",-_strength,true];
	server setVariable ["NATOresourceGain",0,true];
};

server setVariable ["NATOattacking","",true];
