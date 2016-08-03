_unit = _this select 0;

_unit setSkill 0;

_onCivKilled = _unit addEventHandler ["killed",{
	_me = _this select 0;
	_killer = _this select 1;
	_town = (getpos _me) call nearestTown;
	_pop = server getVariable format["population%1",_town];
	server setVariable [format["population%1",_town],_pop - 1,true];
	
	_stability = server getVariable format["stability%1",_town];
	server setVariable [format["stability%1",_town],_stability - 1,true];

	if(_killer == _me) then {
		//was probably hit by a vehicle so we need to find the nearest player driver and blame him
		
	}else{
		if(isPlayer _killer) then {
			_standing = player getVariable format["rep%1",_town];
			_killer setVariable [format["rep%1",_town],_standing - 10,true];
			_killer setCaptive false;
			
			format["Standing (%1) -10",_town] remoteExec ["notify",_killer,true];
		};
	};
}];

_onCivFiredNear = _unit addEventHandler["FiredNear",{
	//Make civilians be scared when shots are fired
	_me = _this select 0;
	_group = group _me;
	_group setBehaviour "Combat";
	_group setSpeedMode "Normal";
	
	_index = currentWaypoint group player;
	deleteWaypoint [_group, _index];
	_group allowFleeing 1;
}];