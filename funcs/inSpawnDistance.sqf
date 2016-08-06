private ["_pos","_players","_posPlayer","_playersalive"];

_pos = _this;


if((typeName _pos) == "STRING") then {
	_pos = server getVariable _town;
}; 
if((typeName _pos) == "OBJECT") then {
	_pos = getPos _pos;
}; 

_return = false;

//So zeus spawns, a'la ALiVE
if !(isNull curatorCamera) then {
	if(((getpos curatorCamera) distance _pos) < AIT_spawnDistance) exitWith {_return = true};
};

if !(_return) then {	
	_players = allUnits;
	{
		if(alive _x && (isPlayer _x || _x call hasOwner)) then {
			_posPlayer = getpos _x;
			if((_pos distance _posPlayer) < AIT_spawnDistance) exitWith {_return = true};
		}			
	}foreach(_players);
};

_return