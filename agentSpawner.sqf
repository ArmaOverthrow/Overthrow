if (!isServer) exitwith {};

private["_players","_playersalive","_town","_posPlayer","_posTown","_distance","_pop","_group","_count","_numCiv","_type"],;


diag_log format["-- AGENTSPAWNER initialise ------------------------"];

waitUntil{not isNil "AIT_economyInitDone"};
waitUntil{not isNil "AIT_NATOInitDone"};
sleep 1;
_tiempo = time;

if(!isServer) exitWith{};
private ["_towns","_townNames","_workerAgents","_sizeX","_sizeY","_name","_pos","_mSize","_pop"];

_townNames = [];
_workerAgents = [];

diag_log format["-- AGENTSPAWNER ready and waiting for players -----"];

while {true} do {
	if (time - _tiempo >= 0.5) then {sleep 0.1} else {sleep 0.5 - (time - _tiempo)};
	_tiempo = time;
	_players = playableUnits;
	
	if(!isMultiplayer) then
	{
		_players = [player];
	};
	
		
	{
		_town = _x;		
		_posTown = server getVariable _town;
						
		_playersalive = false;
		{
			if(isPlayer _x && alive _x) then {
				_posPlayer = getpos _x;
				if((_posTown distance _posPlayer) < AIT_spawnDistance) exitWith {_playersalive = true};
			}			
		}foreach(_players);
			
		if !(spawner getVariable _town) then {
			if(_playersalive) then {
				[_town] spawn spawnCiv;				
			};			
		}else{
			if(!_playersalive) then {
				spawner setVariable [_town,false,true];
			}
		}
	}foreach(AIT_allTowns);
};

