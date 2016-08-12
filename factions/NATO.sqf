if (!isServer) exitwith {};

private ["_name","_pos","_garrison","_airports","_need","_townPos","_current","_stability","_police","_civ","_units","_move","_NATObusy","_abandoned"];

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
server setVariable ["NATOabandoned",_abandoned,false];
server setVariable ["garrisonHQ",1000,false];
{
	_airports pushBack text _x;
}foreach (nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["Airport"], 50000]);

//Find military objectives
{
	_name = text _x;// Get name
	_pos=getpos _x;
	
	//if its in the whitelist, within the NATO home region, or an airport, NATO lives here
	if((_name in AIT_NATOwhitelist) || ([_pos,AIT_NATOregion] call fnc_isInMarker) || (_name in _airports)) then {	
	
		AIT_NATOobjectives pushBack [_pos,_name];
		
		_mrk = createMarker [_name,_pos];
		_mrk setMarkerShape "ICON";
		_mrk setMarkerType "hd_objective";
		_mrk setMarkerColor "ColorBlue";
		_mrk setMarkerAlpha 0;
		
		_garrison = floor(4 + random(8));
		if(_name in AIT_NATO_priority) then {
			_garrison = floor(16 + random(8));
		};
		server setVariable [format ["garrison%1",_name],_garrison,false];
		
	};
	if(_name == AIT_NATO_HQ) then {
		AIT_NATO_HQPos = getpos _x;
	};
	
	
}foreach (nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["NameLocal","Airport"], 50000]);

{
	_garrison = floor(8 + random(6));
	if(_x in AIT_NATO_priority) then {
		_garrison = floor(12 + random(6));
	};
		
	//_x setMarkerText format ["%1",_garrison];
	_x setMarkerAlpha 0;
	server setVariable [format ["garrison%1",_x],_garrison,false];
	
}foreach (AIT_NATO_control);

{
	_town = _x;
	_garrison = 0;	
	_stability = server getVariable format ["stability%1",_town];
	_population = server getVariable format ["population%1",_town];
	if(_stability > 10) then {
		_max = round(_population / 30);
		if(_max < 4) then {_max = 4};
		_garrison = 2+round((1-(_stability / 100)) * _max);
		if(_town in AIT_NATO_priority) then {
			_garrison = round(_garrison * 2);
		};
	};
	server setVariable [format ["garrison%1",_x],_garrison,false];
	server setVariable [format ["garrisonadd%1",_x], 0,false];
	
}foreach (AIT_allTowns);
publicVariable "AIT_NATOobjectives";
AIT_NATOInitDone = true;
publicVariable "AIT_NATOInitDone";
sleep 10;

while {true} do {	
	_abandoned = server getVariable "NATOabandoned";
	{		
		_town = _x;
		_townPos = server getVariable _town;
		_current = server getVariable format ["garrison%1",_town];;	
		_stability = server getVariable format ["stability%1",_town];
		_population = server getVariable format ["population%1",_town];
		if(_stability > 10 and !(_town in _abandoned)) then {
			_max = round(_population / 40);
			if(_max < 4) then {_max = 4};
			_garrison = 2+round((1-(_stability / 100)) * _max);
			if(_town in AIT_NATO_priority) then {
				_garrison = round(_garrison * 2);
			};
			_need = _garrison - _current;
			if(_need < 0) then {_need = 0};
			if(_need > 1) then {				
				server setVariable [format ["garrisonadd%1",_x], 2,false];
				server setVariable [format ["garrison%1",_x],_current+2,false];
			};			
		}else{
			server setVariable [format ["garrison%1",_town],0,false];
			if(!(_town in _abandoned)) then {
				_town spawn NATOattack;				
				_abandoned pushback _town;
				server setVariable ["NATOabandoned",_abandoned,false];
			}
		};
		sleep 0.1;
	}foreach (AIT_allTowns);
	sleep AIT_NATOwait + round(random AIT_NATOwait);	
};

