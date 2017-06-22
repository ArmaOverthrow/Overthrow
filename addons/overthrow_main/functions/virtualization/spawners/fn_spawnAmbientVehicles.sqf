if (!isServer) exitwith {};
sleep random 0.2;
private _count = 0;

params ["_town","_spawnid"];
private _posTown = server getVariable _town;
private _groups = [];

private _mSize = 300;
if(_town in OT_capitals + OT_sprawling) then {//larger search radius
	_mSize = 500;
};

private _count = 0;
private _pop = server getVariable format["population%1",_town];
private _stability = server getVariable format ["stability%1",_town];
private _numVeh = 4;
if(_pop > 15) then {
	_numVeh = 3 + round(_pop * OT_spawnVehiclePercentage);
};
if(_town == (server getVariable "spawntown")) then {
	_numVeh = 12;
};
if(_numVeh > 12) then {_numVeh = 12};
if(count(vehicles) > 200) then {_numVeh = 3};
while {(_count < _numVeh)} do {
	private _start = [[[_posTown,_mSize]]] call BIS_fnc_randomPos;
	_roads = _start nearRoads 75;
	if(count _roads > 0) then {
		_road = _roads select 0;
		_pos = getPos _road;
		_vehtype = "";
		if(_pop > 600) then {
			_vehtype = (OT_vehTypes_civ - OT_vehTypes_civignore) call BIS_Fnc_selectRandom;
		}else{
			_vehtype = [OT_vehTypes_civ,OT_vehWeights_civ] call BIS_Fnc_selectRandomWeighted;
		};
		if !(_vehtype in OT_vehTypes_civignore) then {
			_dirveh = 0;
			_roadscon = roadsConnectedto _road;
			if (count _roadscon == 2) then {
				_dirveh = [_road, _roadscon select 0] call BIS_fnc_DirTo;
				if(isNil "_dirveh") then {_dirveh = random 359};
				_posVeh = ([_pos, 6, _dirveh + 90] call BIS_Fnc_relPos) findEmptyPosition [0,15,_vehtype];

				if(count _posVeh > 0) then {
					_veh = _vehtype createVehicle _posVeh;
					_veh setVariable ["ambient",true,true];
					clearItemCargoGlobal _veh;
					_veh setFuel (0.2 + (random 0.5));

					_veh setDir _dirveh;

					if((random 100) > 90 and (count allunits < 300)) then {
						_group = createGroup CIVILIAN;
						_groups pushback _group;
						_civ = _group createUnit [OT_civType_local, _pos, [],0, "NONE"];
						_civ setBehaviour "SAFE";
						[_civ] call OT_fnc_initCivilian;
						_civ moveInDriver _veh;

						_region  = server getVariable format["region_%1",_town];
						_moveto = _posVeh;
						if(isNil "_region") then {
							_moveto = _posVeh call OT_fnc_getRandomRoadPosition;
						}else{
							_dest = (server getVariable format["towns_%1",_region]) call BIS_fnc_selectRandom;
							_moveto = _dest call OT_fnc_getRandomRoadPosition;
						};

						_wp = _group addWaypoint [_moveto,0];

						_wp setWaypointType "MOVE";
						_wp setWaypointSpeed "LIMITED";
						_wp setWaypointBehaviour "SAFE";
						_wp setWaypointCompletionRadius 60;
						_wp setWaypointStatements ["true","[vehicle this] spawn OT_fnc_cleanup;unassignVehicle this;[group this] spawn OT_fnc_cleanup;"];
					}else{
						if(_stability < 50 and (random 100) > 75) then {
							_veh setDamage [1,false]; //salvage wreck
						};
					};
					_groups pushBack _veh;
				};
			};
		};
	};
	sleep 0.2;
	_count = _count + 1;
};
spawner setvariable [_spawnid,(spawner getvariable [_spawnid,[]]) + _groups,false];
