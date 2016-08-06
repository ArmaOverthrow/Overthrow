

_me = _this select 0;
_killer = _this select 1;
_town = (getpos _me) call nearestTown;

if(isPlayer _me) exitWith {
	[-10] remoteExec ["money",_me,true];
};

_me remoteExec ["removeAllActions",0,true];

_garrison = _me getvariable "garrison";
_criminal = _me getvariable "criminal";
_crimleader = _me getvariable "crimleader";

_standingChange = 0;

if(!isNil "_criminal") then {
	[_town,1] call stability;
	_standingChange = 1;
	if(((east knowsAbout _killer) > 1.5) || ((vehicle _killer) != _killer)) then {		
		_killer setCaptive false;
	};
}else{
	if(!isNil "_crimleader") then {
		[_town,5] call stability;
		_standingChange = 10;
		if(((east knowsAbout _killer) > 1.5) || ((vehicle _killer) != _killer)) then {		
			_killer setCaptive false;
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
			if(((west knowsAbout _killer) > 0) || ((vehicle _killer) != _killer)) then {		
				_killer setCaptive false;
			};
		}else{
			if(side _killer == east or isPlayer _killer) then {
				[_town,-1] call stability;
				_standingChange = -10;
				_killer setCaptive false;
			}
		};
	};
};

if((isPlayer _killer) and (_standingChange != 0)) then {
	[_town,_standingChange] remoteExec ["standing",_killer,true];
};