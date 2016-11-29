if (!isServer) exitwith {};

private _town = _this;
private _posTown = server getVariable _town;

private _groups = [];

			
private _numCRIM = server getVariable [format ["numcrims%1",_town],0];

if(_numCRIM > 0) then {
	private _time = server getVariable [format ["timecrims%1",_town],0];
	private _leaderpos = server getVariable [format["crimleader%1",_town],_posTown];
	if(typename _leaderpos != "ARRAY") then {_leaderpos = _posTown};
	private _group = objNULL;
	
	_skill = 0.7;
	if(_time > 0) then {
		_skill = 0.7 + (0.3 * (_time / 7200));
		if(_skill > 0.95) then {
			_skill = 0.95;
		};
	};				
	//Spawn stuff in			
	_count = 0;	
	private _group = createGroup east;				
	_groups pushback _group;
	if ((typeName _leaderpos) == "ARRAY") then {
		_start = [[[_leaderpos,40]]] call BIS_fnc_randomPos;
		
		_civ = _group createUnit [OT_CRIM_Unit, _start, [],0, "NONE"];
		[_civ] joinSilent nil;
		[_civ] joinSilent _group;
		_civ setskill _skill;
		if(_time > 1200) then {
			_civ setRank "MAJOR";
		}else{
			if(_time > 600) then {
				_civ setRank "CAPTAIN";
			}else{
				_civ setRank "LIEUTENANT";
			};
		};
		
		[_civ,_town] call initCrimLeader;
		_civ setBehaviour "SAFE";			
		
		_wp = _group addWaypoint [_leaderpos,0];
		_wp setWaypointType "GUARD";
	}else{
		_start = [[[_posTown,150]]] call BIS_fnc_randomPos;
		_group setBehaviour "CARELESS";	

		_wp = _group addWaypoint [_leaderpos,0];
		_wp setWaypointType "MOVE";
		_wp setWaypointSpeed "LIMITED";					
		_wp setWaypointTimeout [0, 5, 10];
		
		_end = [[[_posTown,150]]] call BIS_fnc_randomPos;
		
		_wp = _group addWaypoint [_end,0];
		_wp setWaypointType "MOVE";
		_wp setWaypointSpeed "LIMITED";
		_wp setWaypointTimeout [0, 5, 10];
		
		_wp = _group addWaypoint [_leaderpos,0];
		_wp setWaypointType "CYCLE";
		_wp setWaypointSpeed "LIMITED";
	};
	
	while {(_count < _numCRIM)} do {
		_start = [[[_leaderpos,40]]] call BIS_fnc_randomPos;
		
		_civ = _group createUnit [OT_CRIM_Unit, _start, [],0, "NONE"];
		[_civ] joinSilent nil;
		[_civ] joinSilent _group;
		if(_time > 1200) then {
			_civ setRank "LIEUTENANT";
		}else{
			if(_time > 600) then {
				_civ setRank "SERGEANT";
			}else{
				_civ setRank "CORPORAL";
			};
		};
		[_civ,_town] call initCriminal;
		_civ setBehaviour "SAFE";
		
		_count = _count + 1;
	};
};

_groups	