

_me = _this select 0;
_killer = _this select 1;
_killer setVariable ["lastkill",time,true];
_town = (getpos _me) call nearestTown;

if(isPlayer _me) exitWith {};

_garrison = _me getvariable "garrison";
_vehgarrison = _me getvariable "vehgarrison";
_airgarrison = _me getvariable "airgarrison";
_criminal = _me getvariable "criminal";
_crimleader = _me getvariable "crimleader";
_mobster = _me getvariable "mobster";
_mobboss = _me getvariable "mobboss";

_standingChange = 0;

call {
	if(!isNil "_mobboss") exitWith {
		_mobsterid = _me getVariable "garrison";	
		server setVariable [format["mobleader%1",_mobsterid],false,true];
		_active = server getVariable ["activemobsters",[]];
		_t = 0;
		{
			_t = _t + 1;
			if(_x select 1 == _mobsterid) exitWith {};
		}foreach(_active);
		_active deleteAt _t;
		server setVariable ["activemobsters",_active,false];
		
		_standingChange = 50;
		[_killer,1500] call rewardMoney;
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
		};
		_standingChange = 1;
		[_killer,10] call rewardMoney;
	};
	if(!isNil "_crimleader") exitWith {
		[_town,10] call stability;
		
		if(_killer call hasOwner) then {
			_owner = _killer getVariable "owner";
			if(isPlayer _owner) then {
				_killer = _owner;
			};
		};
		
		_standingChange = 10;
		_bounty =  server getVariable [format["CRIMbounty%1",_town],0];
		if(_bounty > 0) then {
			[_killer,_bounty] call rewardMoney;
			if(isPlayer _killer) then {
				if(isMultiplayer) then {
					format["%1 has claimed the bounty in %2",name _killer,_town] remoteExec ["notify_minor",0,true];
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

		_leader = server getVariable [format["crimleader%1",_x],false];
		if (typename _leader == "ARRAY") then {		
			server setVariable [format["crimleader%1",_town],false,true];
		};
	};
	
	if(!isNil "_garrison" or !isNil "_vehgarrison" or !isNil "_airgarrison") exitWith {
		if(!isNil "_garrison") then {
			_pop = server getVariable format["garrison%1",_garrison];			
			if(_pop > 0) then {
				server setVariable [format["garrison%1",_garrison],_pop - 1,true];
			};
			if(_garrison in OT_allTowns) then {
				_town = _garrison;
				_townpop = server getVariable [format["population%1",_town],0];
				_stab = -1;
				if(_townpop < 350 and (random 100) > 50) then {
					_stab = -2;
				};
				[_town,_stab] call stability;
			};
			if(isPlayer _killer) then {
				_standingChange = -1;
			}
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
		if(isPlayer _killer) then {
		
			if(isPlayer _killer) then {
				
			};
		};
	};
	_standingChange = -10;
};

if(captive _killer and ((_killer call unitSeen) or ((vehicle _killer) != _killer))) then {
	_killer setCaptive false;				
};
if(isPlayer _killer) then {
	if (_standingChange != 0) then {
		[_town,_standingChange] remoteExec ["standing",_killer,true];
	};
};	