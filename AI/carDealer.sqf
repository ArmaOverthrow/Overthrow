private ["_unit","_group","_hour","_home","_onCivKilled","_onCivFiredNear","_hometown"];

_unit = _this select 0;

removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeGoggles _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeVest _unit;

_unit forceAddUniform (AIT_clothes_carDealers call BIS_fnc_selectRandom);

_group = group _unit;
_hour = date select 3;
_home = nearestBuilding _unit;
_hometown = (getpos _unit) call nearestTown;

_group setBehaviour "CARELESS";

_unit setSkill 0.5;

_unit setvariable ["owner","self"];

_onCivKilled = _unit addEventHandler ["killed",{
	_me = _this select 0;
	removeAllActions _me;
	
	_killer = _this select 1;
	_town = _hometown;
	_pop = server getVariable format["population%1",_town];
	server setVariable [format["population%1",_town],_pop - 1,true];
	
	[_town,-5] call stability;

	if(_killer == _me) then {
		//was probably hit by a vehicle so we need to find the nearest player driver and blame him
		
	}else{
		if(isPlayer _killer) then {
			_killer setCaptive false;			
			[_town,-20] remoteExec ["standing",_killer,true];
			
			//reveal you to the local garrison
			{
				_garrison = _x getvariable "garrison";
				if !(isNil "_garrison") then {
					if((side _x == west) and (_garrison == _town)) then {
						_x reveal [_killer,1.5];
						_x setCombatMode "RED";
						_x setBehaviour "COMBAT";					
						
						_group = group _x;
						if(leader _group == _x) then {
							_group setCombatMode "RED";
							_group setSpeedMode "NORMAL";
							_group setBehaviour "COMBAT";
							
							while {(count (waypoints _group)) > 0} do {deleteWaypoint ((waypoints _group) select 0)};
							_wp = _group addWaypoint [getpos _killer,0];
							_wp setWaypointType "SAD";
							_wp setWaypointBehaviour "STEALTH";
						}
					};
				};				
			}foreach(allUnits);
		};
	};
}];