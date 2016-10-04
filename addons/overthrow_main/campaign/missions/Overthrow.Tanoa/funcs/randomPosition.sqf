private ["_position","_distance","_direction","_bestPositions"];

_position = _this select 0;
_distance = _this select 1;

_direction = random 360;
_position = _position getPos [_distance, _direction];

if(surfaceIsWater [_position select 0,_position select 1]) then
{
    // handy! http://forums.bistudio.com/showthread.php?93897-selectBestPlaces-(do-it-yourself-documentation)
    _bestPositions = selectbestplaces [[_position select 0,_position select 1],200,"(1 + houses)",10,1];

    _position = _bestPositions select 0;
    _position = _position select 0;
    _position pushback 0;
};

_position