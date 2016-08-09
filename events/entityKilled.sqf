

_me = _this select 0;
_killer = _this select 1;
_town = (getpos _me) call nearestTown;

if(isPlayer _me) exitWith {	
	_myuid = getPlayerUID _me;
	[-10] remoteExec ["money",_me,true];
	{
		_uid = _x getVariable "player_uid";
		if(_uid == _myuid and _x != _me) then {
			deleteVehicle _x;
		};
	}foreach(allDeadMen);
};

_me remoteExec ["removeAllActions",0,true];

_garrison = _me getvariable "garrison";
_criminal = _me getvariable "criminal";
_crimleader = _me getvariable "crimleader";

_standingChange = 0;

if(!isNil "_criminal") then {
	[_town,1] call stability;
	_standingChange = 1;
	if(_killer call unitSeen) then {		
		_killer setCaptive false;
	};
}else{
	if(!isNil "_crimleader") then {
		[_town,5] call stability;
		if((_killer call unitSeen) || ((vehicle _killer) != _killer)) then {		
			_killer setCaptive false;
		};
		
		if(_killer call hasOwner) then {
			_owner = _killer getVariable "owner";
			if(isPlayer _owner) then {
				_killer = _owner;
			};
		};
		
		_standingChange = 10;
		_bounty =  server getVariable [format["CRIMbounty%1",_town],0];
		if(_bounty > 0) then {
			if(isPlayer _killer) then {
				[_bounty] remoteExec ["money",_killer,true];
				if(isMultiplayer) then {
					format["%1 has killed the gang leader in %2",name _killer,_town] remoteExec ["notify_minor",0,true];
				}else{
					format["You killed the gang leader in %2",_town] call notify_minor;
				};
			}else{
				if(side _killer == west) then {
					format["NATO has removed the gang leader in %2",_town] remoteExec ["notify_minor",0,true];
				}else{
					format["The gang leader in %2 is dead",_town] remoteExec ["notify_minor",0,true];
				};
			};
			server setVariable [format["CRIMbounty%1",_town],0,true];
		};		
	}else{
		if(!isNil "_garrison") then {
			_pop = server getVariable format["garrison%1",_garrison];
			if(_pop > 0) then {
				server setVariable [format["garrison%1",_garrison],_pop - 1,true];
			};
			if(_garrison in AIT_allTowns) then {
				_town = _garrison;
			};
			[_town,-2] call stability;
			_standingChange = -1;
			if((_killer call unitSeen) || ((vehicle _killer) != _killer)) then {		
				if(_killer call hasOwner) then {
					_killer setCaptive false;
					_owner = _killer getVariable "owner";
					if(isPlayer _owner) then {							
						if((_killer distance _owner) < 100) then {					
							_killer = _owner;	
							_owner setCaptive false;
						};							
					};				
				};
				if(isPlayer _killer) then {
					_standingChange = -1;
				};
			};
		}else{
			[_town,-1] call stability;
			if(_killer call hasOwner) then {
				_killer setCaptive false;
				_owner = _killer getVariable "owner";
				if(isPlayer _owner) then {							
					if((_killer distance _owner) < 100) then {					
						_killer = _owner;	
						_owner setCaptive false;
					};							
				};				
			};
			if(isPlayer _killer) then {
				_standingChange = -10;
			};
		};
	};
};

if((isPlayer _killer) and (_standingChange != 0)) then {
	[_town,_standingChange] remoteExec ["standing",_killer,true];
};