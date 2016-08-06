private ["_pos","_players","_posPlayer","_playersalive"];

_pos = _this;

//So zeus spawns, a'la ALiVE
if(!isNull(curatorCamera)) then {
	if(((getpos curatorCamera) distance _pos) < AIT_spawnDistance) exitWith {true};
};

_players = playableUnits;
	
if(!isMultiplayer) then
{
	_players = [player];
};

if((typeName _pos) == "STRING") then {
	_pos = server getVariable _town;
}; 
if((typeName _pos) == "OBJECT") then {
	_pos = getPos _pos;
}; 
_playersalive = false;
{
	if(isPlayer _x && alive _x) then {
		_posPlayer = getpos _x;
		if((_pos distance _posPlayer) < AIT_spawnDistance) exitWith {_playersalive = true};
	}			
}foreach(_players);

_playersalive;