if (!isServer) exitwith {};

private _count = 0;

private _town = _this;
private _posTown = server getVariable _town;
private _groups = [];

private _mSize = 150;
if(_town in OT_capitals + OT_sprawling) then {//larger search radius
	_mSize = 300;
};

private _count = 0;
private _pop = server getVariable format["population%1",_town];
private _stability = server getVariable format ["stability%1",_town];
private _numVeh = 4;
if(_pop > 15) then {
	_numVeh = 2 + round(_pop * OT_spawnVehiclePercentage);
};
if(_numVeh <= 0 or count vehicles > 200) exitWith {[]};
while {(_count < _numVeh)} do {		
	private _start = [[[_posTown,_mSize]]] call BIS_fnc_randomPos;
	private _road = [_start] call BIS_fnc_nearestRoad;
	if (!isNull _road) then {	
		_pos = getPos _road;
		_vehtype = "";
		if(_pop > 600) then {
			_vehtype = OT_vehTypes_civ call BIS_Fnc_selectRandom;
		}else{
			_vehtype = [OT_vehTypes_civ,OT_vehWeights_civ] call BIS_Fnc_selectRandomWeighted;
		};		
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
				
				if((random 100) > 90 and (count allunits < 300)) then {
					_group = createGroup CIVILIAN;
					_groups pushback _group;
					_civ = _group createUnit [OT_civType_local, _pos, [],0, "NONE"];
					_civ setBehaviour "SAFE";					
					[_civ] call initCivilian;
					_civ moveInDriver _veh;
					
					_region  = server getVariable format["region_%1",_town];
					_dest = (server getVariable format["towns_%1",_region]) call BIS_fnc_selectRandom;
					_moveto = getpos([server getvariable _dest,OT_allHouses + OT_allShops + OT_offices] call getRandomBuilding);
					_wp = _group addWaypoint [_moveto,0];

					_wp setWaypointType "MOVE";
					_wp setWaypointSpeed "LIMITED";
					_wp setWaypointBehaviour "SAFE";
					_wp setWaypointCompletionRadius 60;
					_wp setWaypointStatements ["true","unassignvehicle this;moveout this;"]; 
				};
				_groups pushBack _veh;
			};
		};
	};	
	_count = _count + 1;
};
_groups