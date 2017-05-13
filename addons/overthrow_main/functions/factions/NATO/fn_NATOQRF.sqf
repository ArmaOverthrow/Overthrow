params ["_pos","_strength","_success","_fail","_params","_garrison"];
private _numPlayers = count([] call CBA_fnc_players);

if(_numPlayers > 3) then {
	_strength = round(_strength * 1.5);
};
private _diff = server getVariable ["OT_difficulty",1];
if(_diff == 0) then {
	_strength = round(_strength * 0.5);
};
if(_diff == 2) then {
	_strength = round(_strength * 2);
};

spawner setVariable ["NATOattackforce",[],false];
//determine possible vectors and distribute strength to each
private _town = _pos call OT_fnc_nearestTown;
private _region = server getVariable format["region_%1",_town];

_ground = [];
_air = [];
_abandoned = server getvariable ["NATOabandoned",[]];
{
	_x params ["_obpos","_name","_pri"];
	if !(_name in _abandoned) then {
		if([_pos,_obpos] call OT_fnc_regionIsConnected) then {
			_ground pushback _x;
		};
		if(_x in OT_airportData) then {
			_air pushback _x;
		};
	};
}foreach([OT_objectiveData + OT_airportData,[],{_pos distance (_x select 0)},"ASCEND"] call BIS_fnc_SortBy);
diag_log format["Overthrow: NATO QRF spend is %1",_strength];

if(_strength > 250 and (count _air) > 0) then {
	//Send CAS
	_obpos = (_air select 0) select 0;
	_name = (_air select 0) select 1;
	[[_obpos,[0,100],random 360] call SHK_pos,_pos,10] spawn OT_fnc_NATOAirSupport;
	diag_log format["Overthrow: NATO Sent CAS from %1",_name];
};

//Send ground support
if(count _ground > 0) then {
	_obpos = (_ground select 0) select 0;
	_name = (_ground select 0) select 1;
	_send = 100;
	if(_strength > 500) then {
		_send = 300;
	};
	if(_strength > 1000) then {
		_send = 500;
	};
	[_obpos,_pos,_send,0] spawn OT_fnc_NATOGroundSupport;
	diag_log format["Overthrow: NATO Sent ground support from %1",_name];
};

{
	_x params ["_obpos","_name","_pri"];

	_dir = [_pos,_obpos] call BIS_fnc_dirTo;
	_ao = [_pos,_dir] call OT_fnc_getAO;
	[_obpos,_ao,_pos,false,10] spawn OT_fnc_NATOGroundForces;
	diag_log format["Overthrow: NATO Sent ground forces from %1",_name];
	_strength = _strength - 150;
	if((_obpos inArea _region) and _strength >= 150) then {
		_ao = [_pos,_dir] call OT_fnc_getAO;
		[_obpos,_ao,_pos,false,30] spawn OT_fnc_NATOGroundForces;
		_strength = _strength - 150;
		diag_log format["Overthrow: NATO Sent extra ground forces from %1",_name];
	};
	if(_strength <=0) exitWith {};
}foreach(_ground);

if(_strength >= 75) then {
	{
		_x params ["_obpos","_name","_pri"];

		_dir = [_pos,_obpos] call BIS_fnc_dirTo;
		_ao = [_pos,_dir] call OT_fnc_getAO;
		[_obpos,_ao,_pos,true,0] spawn OT_fnc_NATOGroundForces;
		diag_log format["Overthrow: NATO Sent ground forces by air from %1",_name];
		_strength = _strength - 75;

		if(_pri > 600 and _strength >= 75) then {
			_ao = [_pos,_dir] call OT_fnc_getAO;
			[_obpos,_ao,_pos,true,30] spawn OT_fnc_NATOGroundForces;
			_strength = _strength - 75;
			diag_log format["Overthrow: NATO Sent extra ground forces by air from %1",_name];
		};

		if(_strength <=0) exitWith {};
	}foreach(_air);
};


private _isCoastal = false;
private _seaAO = [];

//Sea?

call {
	private _p = [_pos,500,0] call BIS_fnc_relPos;
	if(surfaceIsWater _p) exitWith {
		_isCoastal = true;
		_seaAO = _p;
	};
	_p = [_pos,500,90] call BIS_fnc_relPos;
	if(surfaceIsWater _p) exitWith {
		_isCoastal = true;
		_seaAO = _p;
	};
	_p = [_pos,500,180] call BIS_fnc_relPos;
	if(surfaceIsWater _p) exitWith {
		_isCoastal = true;
		_seaAO = _p;
	};
	_p = [_pos,500,270] call BIS_fnc_relPos;
	if(surfaceIsWater _p) exitWith {
		_isCoastal = true;
		_seaAO = _p;
	};
};

diag_log format["Overthrow: Attack start on %1",_pos];
private _delay = 0;

if(_isCoastal and !(OT_NATO_Navy_HQ in _abandoned) and (random 100) > 70) then {
	private _numgroups = 1;
	if(_strength > 100) then {_numgroups = 2};
	if(_strength > 200) then {_numgroups = 3};

	private _p = getMarkerPos OT_NATO_Navy_HQ;
	private _count = 0;
	while {_count < _numgroups} do {
		diag_log format["Overthrow: NATO Sent navy support from %1",OT_NATO_Navy_HQ];
		[[_p,[0,100],random 360] call SHK_pos,_seaAO,_delay] spawn OT_fnc_NATOSeaSupport;
		_count = _count + 1;
		_delay = _delay + 20;
	};
};

sleep 300; //Give NATO some time to get their shit together

private _timeout = time + 800;

waitUntil {
	sleep 5;
	private _force = spawner getVariable["NATOattackforce",[]];
	private _numalive = 0;
	private _numin = 0;
	{
		_numalive = _numalive + ({alive _x} count (units _x));
		_numin = _numin + ({alive _x and _x distance _pos < 150} count (units _x));
		{
			if(vehicle _x != _x) then {
				if(((vehicle _x) isKindOf "Air") and (position _x select 2) < 4) then {
					//Downed heli
					doGetout _x;
				}
			};
		}foreach(units _x);
	}foreach(_force);
	(_numalive < 4) or (time > _timeout) or (_numin > 4)
};

private _force = spawner getVariable["NATOattackforce",[]];
{
	_target = leader _x;
	{
		if((side _x == resistance or captive _x) and (alive _x) and !(_x getvariable ["ace_isunconscious",false])) then {
			_x reveal [_target,3];
		};
	}foreach(allunits);
}foreach(_force);

_timeout = time + 1200;
_won = false;

private _alive = 0;
private _enemy = 0;
private _alivein = 0;
private _enemyin = 0;
private _natowin = false;

while {sleep 5;time < _timeout and !_won} do {
	_alive = 0;
	_enemy = 0;
	_alivein = 0;
	_enemyin = 0;
	{
		_g = (_x getVariable ["garrison",""]);
		if(typename _g != "STRING") then {_g = "HQ"};
		if(_x distance _pos < 1000) then {
			if((side _x == west) and (alive _x) and (_g == "HQ")) then {
				_alive = _alive + 1;
				if(_x distance _pos < 300) then {
					_alivein = _alivein + 1;
				};
			};
			if((side _x == resistance or captive _x) and (alive _x) and !(_x getvariable ["ace_isunconscious",false])) then {
				_enemy = _enemy + 1;
				if(_x distance _pos < 400) then {
					_enemyin = _enemyin + 1;
				};
			};
		};
	}foreach(allunits);
	if(_natowin and (_alivein < _enemy)) then {
		_natowin = false;
	};

	if(_natowin) exitWith {
		//Nato has won
		_params call _success;

		//Recover resources
		server setVariable ["NATOresources",round(_strength * 0.5),true];
		{
			if(side _x == west) then {
				if(count (units _x) > 0) then {
					_lead = (units _x) select 0;
					if((_lead getVariable ["garrison",""]) == "HQ") then {
						if((vehicle _lead) != _lead) then {
							[vehicle _lead] spawn OT_fnc_cleanup;
						}else{
							if((getpos _lead) call OT_fnc_inSpawnDistance) then {
								{
									_x setVariable ["garrison",_garrison,true];
								}foreach(units _x);
							}else{
								[_x] call OT_fnc_cleanup;
							};
						};
					};
				}else{
					deleteGroup _x;
				};
			}
		}foreach(allgroups);
		{
			if(side _x == west) then {
				if(_x getVariable ["garrison",""] == "HQ") then {
					[_x] spawn OT_fnc_cleanup;
				};
			}
		}foreach(vehicles);
		_won = true;
	};
	if(_alivein > _enemy) then {
		sleep 30; //Buffer zone
		_natowin = true;
	};
	//diag_log format["Overthrow: Win/Loss BLU %1  RES %2",_alive,_enemy];
	if(_alive < 4) exitWith{};
};
if !(_won) then {
	_params call _fail;
	//Nato gets pushed back
	server setVariable ["NATOresources",-_strength,true];
	server setVariable ["NATOresourceGain",0,true];
};

server setVariable ["NATOattacking","",true];
