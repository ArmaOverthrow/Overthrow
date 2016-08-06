if (!isServer) exitwith {};

_leaderpos = objNULL;

waitUntil{not isNil "AIT_economyInitDone"};

{
	_town = _x;
	_posTown = server getVariable _town;
	_mSize = 300;
	if(_town in AIT_capitals) then {
		_mSize = 800;
	};
	_garrison = 0;	
	_stability = server getVariable format ["stability%1",_town];
	server setVariable [format["crimnew%1",_town],false,true];
	server setVariable [format["crimadd%1",_town],0,true];
	if(_stability < 10) then {
		_garrison = 2+round((1-(_stability / 10)) * 6);				
		_building = (nearestObjects [_posTown, AIT_crimHouses, _mSize]) call BIS_Fnc_selectRandom;
		if(isNil "_building") then {
			_leaderpos = [_posTown, 0, 6, 0, 0, 40, 0] call BIS_fnc_findSafePos;
		}else{
			_leaderpos = [getpos _building, 0, 6, 0, 0, 40, 0] call BIS_fnc_findSafePos;
		};
		
		server setVariable [format["crimleader%1",_town],_leaderpos,true];
	}else{
		server setVariable [format["crimleader%1",_town],false,true];
	};
	server setVariable [format ["numcrims%1",_x],_garrison,true];
	server setVariable [format ["timecrims%1",_x],0,true];
}foreach (AIT_allTowns);

AIT_CRIMInitDone = true;
publicVariable "AIT_CRIMInitDone";

_sleeptime = 0;

while {true} do {
	{			
		_town = _x;
		_posTown = server getVariable _town;
		_mSize = 300;
		if(_town in AIT_capitals) then {
			_mSize = 800;
		};
		_stability = server getVariable format ["stability%1",_town];
		if((_stability < 30) || (_town in (server getvariable "NATOabandoned"))) then {
			_time = server getVariable format ["timecrims%1",_town];
			_num = server getVariable format ["numcrims%1",_town];
			
			_leaderpos = server getVariable format["crimleader%1",_town];
			if ((typeName _leaderpos) == "ARRAY") then {
				server setVariable [format ["timecrims%1",_x],_time+_sleeptime,true];
				if(((random 100) > 80) and _num < 20) then {
					server setVariable [format ["numcrims%1",_x],_num + 1,true];
				};
			}else{
				if((random (30-_stability)) > 10) then {
					_building = (nearestObjects [_posTown, AIT_crimHouses, _mSize]) call BIS_Fnc_selectRandom;
					if(isNil "_building") then {
						_leaderpos = [_posTown, 0, 6, 0, 0, 40, 0] call BIS_fnc_findSafePos;
					}else{
						_leaderpos = [getpos _building, 0, 6, 0, 0, 40, 0] call BIS_fnc_findSafePos;
					};	
					server setVariable [format["crimnew%1",_town],_leaderpos,true];
					server setVariable [format ["crimadd%1",_x],4,true];
					server setVariable [format ["timecrims%1",_x],0,true];
				}
			};			
		};
		sleep 0.1;
	}foreach (AIT_allTowns);
	_sleeptime = AIT_CRIMwait + round(random AIT_CRIMwait);
	sleep _sleeptime;
};

