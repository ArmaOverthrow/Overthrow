private ["_unit","_group","_hour","_home","_onCivKilled","_onCivFiredNear","_hometown"];

_unit = _this select 0;

removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeGoggles _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeVest _unit;

_clothes = AIT_clothes_locals;
if((typeof _unit) in AIT_civTypes_expats) then {
	_clothes = AIT_clothes_expats;
};

_unit forceAddUniform (_clothes call BIS_fnc_selectRandom);

_group = group _unit;
_hour = date select 3;
_home = nearestBuilding _unit;
_hometown = (getpos _unit) call nearestTown;
_unit setVariable ["hometown",_hometown,true];
_group setBehaviour "CARELESS";

if(_hour > 6 and _hour < 19) then {
	//Walk to a shop and back again
	_dest = getpos([getpos _unit,AIT_allHouses + AIT_allShops] call getRandomBuilding);
	
	_dest = [_dest, 0, 60, 0.2, 0, 0, 0] call BIS_fnc_findSafePos;
	
	_wp = _group addWaypoint [_dest,0];
	_wp setWaypointType "MOVE";
	_wp setWaypointSpeed "LIMITED";
	_wp setWaypointCompletionRadius 40;
	_wp setWaypointTimeout [0, 4, 8];
	
	_wp = _group addWaypoint [getpos _unit,0];	
	_wp setWaypointType "MOVE";
	_wp setWaypointSpeed "LIMITED";
	_wp setWaypointCompletionRadius 10;	
	_wp setWaypointTimeout [20, 40, 80];
	
	_wp = _group addWaypoint [getpos _unit,0];
	_wp setWaypointType "CYCLE";
}else{
	//Lull around home
	_idx = 0;
	while{true} do {
		_pos = _home buildingPos _idx;
		if((_pos select 0) > 0) then {
			_wp = _group addWaypoint [_pos,0];
			_wp setWaypointType "MOVE";
			_wp setWaypointSpeed "LIMITED";
			_wp setWaypointTimeout [10, 20, 40];
		}else{
			[] exitWith {};
		}
	};
	_wp = _group addWaypoint [getpos _unit,0];
	_wp setWaypointType "CYCLE";
	_wp setWaypointTimeout [20, 40, 80];
};

_unit setSkill 0.5;

_onCivKilled = _unit addEventHandler ["killed",{
	_me = _this select 0;
	removeAllActions _me;
	
	_killer = _this select 1;
	_t = (getpos _me) call nearestTown;
	_pop = server getVariable format["population%1",_t];
	server setVariable [format["population%1",_t],_pop - 1,true];
	
	if(_killer == _me) then {
		//was probably hit by a vehicle so we need to find the nearest player driver and blame him
		
	}else{
		if(isPlayer _killer) then {
			_killer setCaptive false;			
			[_t,-10] remoteExec ["standing",_killer,true];
			
			//reveal you to the local garrison
			{
				_garrison = _x getvariable "garrison";
				if !(isNil "_garrison") then {
					if((side _x == west) and (_garrison == _t)) then {
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