_me = _this select 0;
_killer = _me getVariable "ace_medical_lastDamageSource";
if(isNil "_killer") then {_killer = _this select 1};

if(vehicle _killer != _killer) then {_killer = driver _killer};

if(_killer call unitSeen) then {
	_killer setVariable ["lastkill",time,true];
};
_town = (getpos _me) call nearestTown;

if(isPlayer _me) exitWith {};

_civ = _me getvariable "civ";
_garrison = _me getvariable "garrison";
_vehgarrison = _me getvariable "vehgarrison";
_polgarrison = _me getvariable "polgarrison";
_airgarrison = _me getvariable "airgarrison";
_criminal = _me getvariable "criminal";
_crimleader = _me getvariable "crimleader";
_mobster = _me getvariable "mobster";
_mobboss = _me getvariable "mobboss";

_standingChange = 0;

call {
	if(!isNil "_civ") exitWith {
		_standingChange = -10;
		[_town,-1] call stability;
	};
	if(!isNil "_mobboss") exitWith {
		_mobsterid = _garrison;
		server setVariable [format["mobleader%1",_mobsterid],false,true];
		_active = server getVariable ["activemobsters",[]];
		_t = 0;
		{
			if((_x select 1) == _mobsterid) exitWith {};
			_t = _t + 1;
		}foreach(_active);
		_active deleteAt _t;
		server setVariable ["activemobsters",_active,false];

		_standingChange = 50;
		[_killer,1500] call rewardMoney;

		format["The crime leader %1 is dead, camp is cleared",(getpos _me) call BIS_fnc_locationDescription] remoteExec ["notify_minor",0,true];
		deleteMarker format ["mobster%1",_mobsterid];
	};
	if(!isNil "_mobster") exitWith {
		_mobsterid = _me getVariable "garrison";
		_pop = server getVariable format["crimgarrison%1",_mobsterid];
		if(_pop > 0) then {
			server setVariable [format["crimgarrison%1",_mobsterid],_pop - 1,true];
		};
		_standingChange = 10;
		[_killer,150] call rewardMoney;
	};
	if(!isNil "_criminal") exitWith {
		_pop = server getVariable format["numcrims%1",_town];
		if(_pop > 0) then {
			server setVariable [format["numcrims%1",_town],_pop - 1,true];
		};
		if((random 100) > 50) then {
			[_town,1] call stability;
			format["%1 (+1 Stability)",_town] remoteExec ["notify_minor",0,false];
		};
		_standingChange = 1;
		[_killer,10] call rewardMoney;
	};
	if(!isNil "_crimleader") exitWith {
		[_town,10] call stability;
		format["%1 (+10 Stability)",_town] remoteExec ["notify_minor",0,false];

		_standingChange = 10;
		_bounty =  server getVariable [format["CRIMbounty%1",_town],0];
		if(_bounty > 0) then {
			[_killer,_bounty] call rewardMoney;
			if(isPlayer _killer) then {
				if(isMultiplayer) then {
					format["%1 has claimed the bounty in %2",name _killer,_town] remoteExec ["notify_minor",0,false];
				}else{
					format["You claimed the bounty in %1",_town] call notify_minor;
				};
			}else{
				if(side _killer == west) then {
					format["NATO has removed the bounty in %1",_town] remoteExec ["notify_minor",0,true];
				}else{
					format["The gang leader in %1 is dead",_town] remoteExec ["notify_minor",0,true];
				};
			};
			server setVariable [format["CRIMbounty%1",_town],0,true];
		};

		_leader = server getVariable [format["crimleader%1",_town],false];
		if (typename _leader == "ARRAY") then {
			server setVariable [format["crimleader%1",_town],false,true];
		};
	};
	if(!isNil "_polgarrison") exitWith {
		_pop = server getVariable format["police%1",_polgarrison];
		if(_pop > 0) then {
			server setVariable [format["police%1",_polgarrison],_pop - 1,true];
		};
		[_town,-1] call stability;
	};
	if(!isNil "_garrison" or !isNil "_vehgarrison" or !isNil "_airgarrison") then {
		if(!isNil "_garrison") then {
			_pop = server getVariable [format["garrison%1",_garrison],0];
			if(_pop > 0) then {
				_pop = _pop -1;
				server setVariable [format["garrison%1",_garrison],_pop,true];
			};
			if(_garrison in OT_allTowns) then {
				_town = _garrison;
			};
			if(isPlayer _killer) then {
				_standingChange = -1;
			};
			_townpop = server getVariable [format["population%1",_town],0];
			_stab = -1;
			if(_townpop < 350 and (random 100) > 50) then {
				_stab = -2;
			};
			if(_garrison in OT_allObjectives and _pop >= 0) then {
				if(_pop > 4) then {
					format["%1 garrison now %2",_garrison,_pop] remoteExec ["notify_minor",_killer,true];
				}else{
					format["%1 garrison has lost radio contact, NATO response incoming",_garrison,_pop] remoteExec ["notify_minor",_killer,true];
				};
			}else{
				[_town,_stab] call stability;
				_stability = server getvariable [format["stability%1",_town],0];
				if(_stability > 5) then{
					if(_stability > 10) then {
						format["%1 (%2 Stability)",_town,_stab] remoteExec ["notify_minor",_killer,false];
					}else{
						format["%1 has destabilized",_town,_stab] remoteExec ["notify_minor",_killer,false];
					};
				};
			};
		};

		if(!isNil "_vehgarrison") then {
			_vg = server getVariable format["vehgarrison%1",_vehgarrison];
			_vg deleteAt (_vg find (typeof _me));
			server setVariable [format["vehgarrison%1",_vehgarrison],_vg,false];
		};

		if(!isNil "_airgarrison") then {
			_vg = server getVariable format["airgarrison%1",_airgarrison];
			_vg deleteAt (_vg find (typeof _me));
			server setVariable [format["airgarrison%1",_airgarrison],_vg,false];
		};
	}else{
		if(side _me == west) then {
			[_town,-1] call stability;
		};
		if(side _me == east) then {
			[_town,1] call stability;
		};
	};
};

if((_killer call unitSeen) or (_standingChange < -9)) then {
	_killer setCaptive false;
	if(vehicle _killer != _killer) then {
		{
			_x setCaptive false;
		}foreach(units vehicle _killer);
	};
};
if(isPlayer _killer) then {
	if (_standingChange == -10) then {
		[_town,_standingChange,"You killed a civilian"] remoteExec ["standing",_killer,true];
	}else{
		[_town,_standingChange] remoteExec ["standing",_killer,true];
	};
};
