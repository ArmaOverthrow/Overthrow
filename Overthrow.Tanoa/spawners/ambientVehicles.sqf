private ["_town","_count","_pop","_stability","_numVeh","_start","_road","_vehtype","_dirveh","_roadscon","_mSize","_posTown","_groups"];
if (!isServer) exitwith {};

_count = 0;

_town = _this;
_posTown = server getVariable _town;
_groups = [];

_mSize = 380;
if(_town in AIT_capitals + AIT_sprawling) then {//larger search radius
	_mSize = 700;
};

_count = 0;
_pop = server getVariable format["population%1",_town];
_stability = server getVariable format ["stability%1",_town];
_numVeh = 2;
if(_pop > 15) then {
	_numVeh = 2 + round(_pop * AIT_spawnVehiclePercentage);
};
while {(_count < _numVeh)} do {		
	_start = [[[_posTown,_mSize]]] call BIS_fnc_randomPos;
	_road = [_start] call BIS_fnc_nearestRoad;
	if (!isNull _road) then {		
		_pos = getPos _road;
		_vehtype = AIT_vehTypes_civ call BIS_Fnc_selectRandom;
		_dirveh = 0;
		_roadscon = roadsConnectedto _road;
		if (count _roadscon == 2) then {
			_dirveh = [_road, _roadscon select 0] call BIS_fnc_DirTo;
			if(isNil "_dirveh") then {_dirveh = random 359};
			_posVeh = ([_pos, 6, _dirveh + 90] call BIS_Fnc_relPos) findEmptyPosition [0,15,_vehtype];
			
			if(count _posVeh > 0) then {
				_veh = _vehtype createVehicle _posVeh;
				clearItemCargoGlobal _veh;
						
				_veh setDir _dirveh;
				
				if((random 100) > 80) then {
					_group = createGroup CIVILIAN;
					_civ = _group createUnit [AIT_civType_local, _pos, [],0, "NONE"];
					_civ setBehaviour "SAFE";
					[_civ] call initCivilian;
					_civ moveInDriver _veh;
					
					_region  = server getVariable format["region_%1",_town];
					_dest = (server getVariable format["towns_%1",_region]) call BIS_fnc_selectRandom;
					_moveto = getpos([server getvariable _dest,AIT_allHouses + AIT_allShops + AIT_offices] call getRandomBuilding);
					_wp = _group addWaypoint [_moveto,0];

					_wp setWaypointType "MOVE";
					_wp setWaypointSpeed "LIMITED";
					_wp setWaypointBehaviour "SAFE";
					_wp setWaypointCompletionRadius 60;
					_wp setWaypointStatements ["true","unassignvehicle this;moveout this;(group this) call civilianGroup;[vehicle this] execVM 'funcs\cleanup.sqf'"]; 
				}else{
					_groups pushBack _veh;
				};
				sleep 0.1;
			};
		};
	};
	_count = _count + 1;	
};
_groups