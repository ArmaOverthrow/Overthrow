private ["_Unit", "_MovePosition", "_NearestEnemy", "_TypeListFinal", "_TypeList", "_Type", "_type", "_BoundingArray", "_p1", "_p2", "_maxWidth", "_maxLength", "_maxHeight", "_ClosestCover", "_GuessLocation", "_coverObjectspos","_WeakListFinal","_MovePos"];

_Unit = _this select 0;
_MovePos = _this select 1;
_VCOM_GARRISONED = _this select 2;
_VCOM_MovedRecentlyCover = _this select 3;
_VCOMAI_ActivelyClearing = _this select 4;
_VCOMAI_StartedInside = _this select 5;
_NearestEnemy = _this select 6;

if (_VCOM_MovedRecentlyCover || {_VCOMAI_ActivelyClearing} || {_VCOMAI_StartedInside} || {_VCOM_GARRISONED}) exitWith {};


//systemchat format ["E %1",_Unit];

if (isNil "_NearestEnemy") exitWith {};


_WeakListFinal = [];
_ClosestCover = [];
_TypeListFinal = [];
_MovePosition = [_MovePos,10 + (random 10),(direction _Unit)] call BIS_fnc_relPos;
_TypeList = nearestObjects [_MovePosition, [], 30];
_Roads = _MovePosition nearRoads 30;
{
	_Type = typeOf _x;
	if !(_type in ["#crater","#crateronvehicle","#soundonvehicle","#particlesource","#lightpoint","#slop","#mark","HoneyBee","Mosquito","HouseFly","FxWindPollen1","ButterFly_random","Snake_random_F","Rabbit_F","FxWindGrass2","FxWindLeaf1","FxWindGrass1","FxWindLeaf3","FxWindLeaf2"]) then
	{
		if (!(_x isKindOf "Man") && {!(_x isKindOf "Bird")} && {!(_x isKindOf "BulletCore")} && {!(_x isKindOf "Grenade")} && {!(_x isKindOf "WeaponHolder")} && {(_x distance _Unit > 5)}) then
		{
			_BoundingArray = boundingBoxReal _x;
			_p1 = _BoundingArray select 0;
			_p2 = _BoundingArray select 1;
			_maxWidth = abs ((_p2 select 0) - (_p1 select 0));
			_maxLength = abs ((_p2 select 1) - (_p1 select 1));
			_maxHeight = abs ((_p2 select 2) - (_p1 select 2));
			if (_maxWidth > 2 && _maxLength > 2 && _maxHeight > 2) then
			{
				if (_type isEqualTo "") then 
				{
					_WeakListFinal pushback _x
				} 
				else
				{
					_TypeListFinal pushback _x;
				};
			};
		};
	};
} foreach ((_TypeList) - (_Roads));
//systemchat format ["List: %1",count ((_TypeList) - (_Roads))];


if (_TypeListFinal isEqualTo [] && _WeakListFinal isEqualTo []) exitWith {};
//_ClosestCover = [_TypeListFinal,_this] call VCOMAI_ClosestObject;
if !(_TypeListFinal isEqualTo []) then {_ClosestCover = _TypeListFinal call BIS_fnc_selectRandom;} else {_ClosestCover = _WeakListFinal call BIS_fnc_selectRandom;};


if (isNil "_ClosestCover") exitWith {};

_GuessLocation = [];
if (_NearestEnemy isEqualTo [0,0,0]) then {_GuessLocation = getpos _Unit} else {if (typeName _NearestEnemy isEqualTo "ARRAY") then {_GuessLocation = _NearestEnemy;} else {_GuessLocation = getpos _NearestEnemy;};};

_coverObjectspos = [_GuessLocation, (_ClosestCover distance _NearestEnemy) + 2, ([_GuessLocation, _ClosestCover] call BIS_fnc_dirTo)] call BIS_fnc_relPos;
_coverObjectspos