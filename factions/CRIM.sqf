if (!isServer) exitwith {};

_leaderpos = objNULL;
if((server getVariable "StartupType") == "NEW") then {
	{
		_town = _x;
		_posTown = server getVariable _town;
		_mSize = 300;
		if(_town in AIT_capitals) then {
			_mSize = 800;
		};
		_garrison = 0;	
		_stability = server getVariable format ["stability%1",_town];
		server setVariable [format["crimnew%1",_town],false,false];
		server setVariable [format["crimadd%1",_town],0,false];
		if(_stability < 17) then {
			_garrison = 2+round((1-(_stability / 10)) * 6);				
			_building = [_posTown, AIT_crimHouses] call getRandomBuilding;
			if(isNil "_building") then {
				_leaderpos = [[[_posTown,_mSize]]] call BIS_fnc_randomPos;
			}else{
				_leaderpos = getpos _building;
			};
			
			server setVariable [format["crimleader%1",_town],_leaderpos,false];
		}else{
			server setVariable [format["crimleader%1",_town],false,false];
		};
		server setVariable [format ["numcrims%1",_x],_garrison,false];
		server setVariable [format ["timecrims%1",_x],0,false];
	}foreach (AIT_allTowns);
};
AIT_CRIMInitDone = true;
publicVariable "AIT_CRIMInitDone";

_sleeptime = 0;

while {true} do {
	if(count allPlayers > 0) then {
		{	
			
			_town = _x;
			_posTown = server getVariable _town;
			_mSize = 300;
			if(_town in AIT_capitals) then {
				_mSize = 800;
			};
			_stability = server getVariable format ["stability%1",_town];
			if((_stability < 30) || (_town in (server getvariable "NATOabandoned"))) then {
				_time = server getVariable [format ["timecrims%1",_town],0];
				_num = server getVariable [format ["numcrims%1",_town],0];
				
				_leaderpos = server getVariable [format["crimleader%1",_town],false];
				if ((typeName _leaderpos) == "ARRAY") then {
					server setVariable [format ["timecrims%1",_x],_time+_sleeptime,false];
					if(((random 100) > 80) and _num < 20) then {
						server setVariable [format ["numcrims%1",_x],_num + 1,false];
					};
				}else{
					if((random 100) > 90) then {
						//New leader spawn
						_building = [_posTown, AIT_crimHouses] call getRandomBuilding;
						if(isNil "_building") then {
							_leaderpos = [[[_posTown,50]]] call BIS_fnc_randomPos;
						}else{
							_leaderpos = getpos _building;
						};	
						server setVariable [format["crimnew%1",_town],_leaderpos,false];
						server setVariable [format ["crimadd%1",_x],4,false];
						server setVariable [format ["timecrims%1",_x],0,false];
					}
				};			
			};
			sleep 0.1;
		}foreach (AIT_allTowns);
	};
	
	{
		if(side _x == east and count (units _x) == 0) then {
			deleteGroup _x;
		};
	}foreach(allGroups);
	
	_sleeptime = AIT_CRIMwait + round(random AIT_CRIMwait);
	sleep _sleeptime;
};

