

_me = _this select 0;
_killer = _this select 1;
_town = (getpos _me) call nearestTown;

_garrison = _me getvariable "garrison";
if(!isNil "_garrison") then {
	_pop = server getVariable format["garrison%1",_garrison];
	if(_pop > 0) then {
		server setVariable [format["garrison%1",_garrison],_pop - 1,true];
	};
	if(_garrison in AIT_allTowns) then {
		_town = _garrison;
	};	
};
_standingChange = 0;
if(side _me == west) then {
	[_town,-2] call stability;
	_standingChange = -1;
	if(((west knowsAbout _killer) > 0) || ((vehicle _killer) != _killer)) then {		
		_killer setCaptive false;
	};
};
if(side _me == east) then {
	[_town,1] call stability;
	_standingChange = 1;
	if(((west knowsAbout _killer) > 1.5) || ((vehicle _killer) != _killer)) then {		
		_killer setCaptive false;
	};
};
if(side _me == civilian) then {
	[_town,-1] call stability;
	_standingChange = -10;
	_killer setCaptive false;
};

if(isPlayer _killer and _standingChange != 0) then {
	[_t,_standingChange] remoteExec ["standing",_killer,true];
};