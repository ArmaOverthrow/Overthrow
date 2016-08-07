private ["_id","_params","_town","_posTown","_active","_groups","_civs","_numCiv","_shops","_houses","_stability","_pop","_count","_mSize","_civTypes","_hour","_range","_found"];
if (!isServer) exitwith {};

_active = false;

_count = 0;
_id = _this select 0;
_posTown = _this select 1;
_town = _this select 3;

_civs = []; //Stores all civs for tear down

waitUntil{spawner getVariable _id};

_mSize = 380;
if(_town in AIT_capitals + AIT_sprawling) then {//larger search radius
	_mSize = 700;
};

while{true} do {
	//Do any updates here that should happen whether spawned or not
	
	//Main spawner
	if !(_active) then {
		if (spawner getVariable _id) then {
			_active = true;
			//Spawn stuff in
			
			_pop = server getVariable format["population%1",_town];
			_stability = server getVariable format ["stability%1",_town];
			_numVeh = 2;
			if(_pop > 15) then {
				_numVeh = 2 + round(_pop * AIT_spawnVehiclePercentage);
			};
			while {(spawner getVariable _id) and (_count < _numVeh)} do {	
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
							_civs pushBack _veh;
										
							_veh addEventHandler ["GetIn",{						
								_unit = _this select 2;						
								_v = _this select 0;
								_v setVariable ["owner",_unit,true];
								_v setVariable ["stolen",true,true];
								if(blufor knowsAbout _unit > 1.4) then {
									_unit setCaptive false;
								};
							}];
							sleep 0.05;
						};
					};
				};
				_count = _count + 1;	
			};

			sleep 1;
			{
				_x setDamage 0;
			}foreach(_civs);			
		};
	}else{
		if (spawner getVariable _id) then {
			//Do updates here that should happen only while spawned
			//...
		}else{			
			_active = false;
			//Tear it all down
			{
				if !(_x call hasOwner) then {
					deleteVehicle _x;
				};				
			}foreach(_civs);
			_civs = [];
		};
	};
	sleep 1;
};