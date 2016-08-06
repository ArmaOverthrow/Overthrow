private ["_params","_town","_posTown","_active","_groups","_civs","_numCiv","_shops","_houses","_stability","_pop","_count","_mSize","_civTypes","_hour","_range","_found"];
if (!isServer) exitwith {};

_active = false;

_count = 0;
_id = _this select 0;
_posTown = _this select 1;
_town = _this select 3;

_civs = []; //Stores all civs for tear down

waitUntil{spawner getVariable _id};

while{true} do {
	//Do any updates here that should happen whether spawned or not
	
	//Main spawner
	if !(_active) then {
		if (spawner getVariable _id) then {
			_active = true;
			//Spawn stuff in
			
			_pop = server getVariable format["population%1",_town];
			_stability = server getVariable format ["stability%1",_town];
			
			if(_pop > 15) then {
				_numCiv = round(_pop * AIT_spawnCivPercentage);
				_numVeh = 2 + round(_pop * 0.01);
			}else {
				_numCiv = _pop;
			};
			_hour = date select 3;
			
			_civTypes = AIT_civTypes_locals;

			if(_pop > 600) then {
				_civTypes = _civTypes + AIT_civTypes_expats + AIT_civTypes_tourists;
			};

			if(_hour > 17 || _hour < 9) then {
				//spawn less people outside 9-5 hours
				_numCiv = round(_numCiv * 0.5);
			};			
			_count = 0;
			
			_done = [];
			
			while {(spawner getVariable _id) and (_count < _numCiv)} do {
				_pos = [_posTown,"House"] call getRandomBuildingPosition;
				_group = createGroup civilian;
				_civ = _group createUnit [_civTypes call BIS_fnc_selectRandom, _pos, [],0, "NONE"];
				_civs pushBack _civ;
				[_civ] call initCivilian;			
				_count = _count + 1;
				sleep 0.1;
			};
			{
				_x addCuratorEditableObjects [_civs,true];
			} forEach allCurators;
			
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
					deleteGroup group _x;
					deleteVehicle _x;
				};				
			}foreach(_civs);
			_civs = [];
		};
	};
	sleep 1;
};