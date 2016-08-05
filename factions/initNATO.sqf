if (!isServer) exitwith {};

private ["_name","_pos","_garrison","_airports","_need","_townPos","_current","_stability","_police","_civ","_units","_move","_NATObusy","_abandoned"];

waitUntil{not isNil "AIT_economyInitDone"};

AIT_NATOobjectives = [];
_airports = [];

_NATObusy = false;
_abandoned = [];
{
	_stability = server getVariable format ["stability%1",_x];
	if(_stability < 11) then {
		_abandoned pushback _x;
	};
}foreach (AIT_allTowns);
server setVariable ["NATOabandoned",_abandoned,true];

{
	_airports pushBack _x;
}foreach (nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["Airport"], 50000]);

//Find military objectives
{
	_name = text _x;// Get name
	_pos=getpos _x;
	
	//if its in the whitelist, within the NATO home region, or an airport, NATO lives here
	if((_name in AIT_NATOwhitelist) || ([_pos,AIT_NATOregion] call fnc_isInMarker) || (_name in _airports)) then {	
	
		AIT_NATOobjectives pushBack _name;

		_garrison = floor(4 + random(8));
		if(_name in AIT_NATO_priority) then {
			_garrison = floor(16 + random(8));
		};
		server setVariable [format ["garrison%1",_name],_garrison,true];
	};
	if(_name == AIT_NATO_HQ) then {
		AIT_NATO_HQPos = getpos _x;
	};
	
}foreach (nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["NameLocal","Airport"], 50000]);

{
	_garrison = floor(4 + random(4));
	if(_x in AIT_NATO_priority) then {
		_garrison = floor(16 + random(8));
	};
		
	//_x setMarkerText format ["%1",_garrison];
	_x setMarkerAlpha 0;
	server setVariable [format ["garrison%1",_x],_garrison,true];
	
}foreach (AIT_NATO_control);

{
	_town = _x;
	_garrison = 0;	
	_stability = server getVariable format ["stability%1",_town];
	if(_stability > 10) then {
		_garrison = 4+round((1-(_stability / 100)) * 8);
		if(_town in AIT_NATO_priority) then {
			_garrison = round(_garrison * 2);
		};
	};
	server setVariable [format ["garrison%1",_x],_garrison,true];
	
}foreach (AIT_allTowns);

AIT_NATOInitDone = true;
publicVariable "AIT_NATOInitDone";
sleep 10;

while {true} do {	
	{	
		_town = _x;
		_townPos = server getVariable _town;
		_current = server getVariable format ["garrison%1",_town];;	
		_stability = server getVariable format ["stability%1",_town];
		if(_stability > 10 and !(_town in _abandoned)) then {
			_garrison = 4+round((1-(_stability / 100)) * 8);
			if(_town in AIT_NATO_priority) then {
				_garrison = round(_garrison * 2);
			};
			_need = _garrison - _current;
			if(_need < 0) then {_need = 0};
			if(_need > 1) then {
				//send a heli with reinforcements
				if(_townPos call inSpawnDistance) then {
					_spawnpos = AIT_NATO_HQPos findEmptyPosition [0,100,AIT_NATO_Vehicle_PoliceHeli];
					
					_veh =  AIT_NATO_Vehicle_PoliceHeli createVehicle _spawnpos;
					_veh setDir 180;
					_group = creategroup blufor;	
										
					_units = [];
					_start = [_spawnpos, 0, 15, 1, 0, 20, 0] call BIS_fnc_findSafePos;
					_civ = _group createUnit [AIT_NATO_Unit_PoliceHeliPilot, _start, [],0, "NONE"];
					_units pushBack _civ;
					
					_start = [_spawnpos, 0, 15, 4, 1, 20, 0] call BIS_fnc_findSafePos;
					_civ = _group createUnit [AIT_NATO_Unit_PoliceHeliCoPilot, _start, [],0, "NONE"];
					_units pushBack _civ;
					
					_police = [];
					
					_group addVehicle _veh;
					
					sleep(2);
										
					_start = [getPos _veh, 30, 90, 5, 0, 20, 0] call BIS_fnc_findSafePos;
					_groups = [_group];
					
					_civ = _group createUnit [AIT_NATO_Unit_PoliceCommander, _start, [],0, "NONE"];					
					_police pushBack _civ;
					_civ setBehaviour "SAFE";
					sleep 0.01;
					_start = [_start, 0, 15, 4, 0, 20, 0] call BIS_fnc_findSafePos;
					_civ = _group createUnit [AIT_NATO_Unit_Police, _start, [],0, "NONE"];
					_police pushBack _civ;
					_civ setBehaviour "SAFE";
					
					if((_stability < 40) and (random 100) > 75) then {
						//Send some military dudes
						_start = [_start, 0, 15, 4, 0, 20, 0] call BIS_fnc_findSafePos;
						_civ = _group createUnit [AIT_NATO_Unit_PoliceMedic, _start, [],0, "NONE"];
						_police pushBack _civ;
						_civ setBehaviour "SAFE";
						
						_start = [_start, 0, 15, 4, 0, 20, 0] call BIS_fnc_findSafePos;
						_civ = _group createUnit [AIT_NATO_Units_PoliceSupport call BIS_fnc_selectRandom, _start, [],0, "NONE"];
						_police pushBack _civ;
						_civ setBehaviour "SAFE";
					};
					
					_dest = _townPos;

					_move = _group addWaypoint [_dest,75];
					_move setWaypointType "UNLOAD";
					_move setWaypointTimeout [20,20,20];
					
					_group setVariable ["transport",_police,true];					
					_group setVariable ["heli",_veh,true];	
					_move setWaypointStatements ["true","_p = (group this) getVariable 'transport';_g = creategroup blufor;_p joinSilent grpNull;_p joinSilent _g;_g call initPolicePatrol;{[_x] call initPolice;}foreach(_p);"];					
					
					_move = _group addWaypoint [AIT_NATO_HQPos,20];
					_move setWaypointType "LOITER";	
					_move setWaypointSpeed "FULL";
					
					_move = _group addWaypoint [AIT_NATO_HQPos,0];
					_move setWaypointType "SCRIPTED";					
					_move setWaypointStatements ["true","deleteVehicle ((group this) getVariable 'heli');deleteGroup (group this);{deleteVehicle _x}foreach(thisList);"];

				};	
				server setVariable [format ["garrison%1",_x],_current + 2,true];
				_NATObusy = true;
			};
			
		}else{
			server setVariable [format ["garrison%1",_town],0,true];
			if(!(_town in _abandoned)) then {
				format["NATO has abandoned %1",_town] remoteExec ["notify",0,true];
				_abandoned pushback _town;
				server setVariable ["NATOabandoned",_abandoned,true];
			}
		};
		sleep 0.1;
	}foreach (AIT_allTowns);
	sleep 200 + round(random 600);	
};

