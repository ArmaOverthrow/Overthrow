_Unit = _this select 0;
_AttachObject = _this select 1;
_VCOM_GRENADETHROWN = _this select 2;

_GuessLocation = _Unit getHideFrom _NearestEnemy;		

if (isNull _NearestEnemy) exitWith
{
	//Throw grenades and seek for any kind of cover
	[_Unit,_VCOM_GRENADETHROWN] spawn VCOMAI_ThrowGrenade;
};

_coverObjectsClosest = [];

for "_i" from 0 to 20 do 
	{
		_coverObjectsClosest pushback (_coverObjects call BIS_fnc_selectRandom);
	};

	_Closestobject = _coverObjectsClosest call BIS_fnc_selectRandom;

	_BoundingArray = boundingBoxReal _Closestobject;
	_p1 = _BoundingArray select 0;
	_p2 = _BoundingArray select 1;
	_maxWidth = abs ((_p2 select 0) - (_p1 select 0));
	
	_coverObjectspos = [_GuessLocation, (_Closestobject distance _NearestEnemy) + 2, ([_GuessLocation, _Closestobject] call BIS_fnc_dirTo)] call BIS_fnc_relPos;