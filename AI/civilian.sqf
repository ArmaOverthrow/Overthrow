private ["_unit","_group","_hour","_home","_onCivKilled","_onCivFiredNear","_hometown"];

_unit = _this select 0;

removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeGoggles _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeVest _unit;

(group _unit) allowFleeing 1;

_home = nearestBuilding _unit;

_clothes = AIT_clothes_locals;
_buildings = AIT_allHouses + AIT_allShops + AIT_offices + AIT_portBuildings;
if((typeof _unit) in AIT_civTypes_expats) then {
	_clothes = AIT_clothes_expats;
};

if((typeof _home) in AIT_portBuildings) then {
	_clothes = [AIT_clothes_port];
	_buildings = AIT_portBuildings;
};

_unit forceAddUniform (_clothes call BIS_fnc_selectRandom);

_group = group _unit;
_hour = date select 3;

if !(leader _group == _unit) exitWith {};

_group setBehaviour "SAFE";

if(_hour > 6 and _hour < 19) then {
	//Walk to a shop and back again
	_dest = getpos([getpos _unit,_buildings] call getRandomBuilding);
		
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
		_pos = ([_home] call BIS_fnc_buildingPositions) call BIS_fnc_selectRandom;
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