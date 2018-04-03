private ["_list", "_position"];
_list = _this select 0;
_object = _this select 1;
//[_list,_object] call VCOMAI_ClosestObject;
////systemchat format ["%1",_object];


_position = [0,0,0];
if (isNil ("_object")) exitWith {};
if (isNil ("_list")) exitWith {};
if (TypeName _object isEqualTo "OBJECT") then {_position = getPosWorld _object;};
if (TypeName _object isEqualTo "STRING") then {_position = getMarkerPos _object;};
if (TypeName _object isEqualTo "ARRAY") then {_position = _object;};

_DistanceArray = [];

{
	if !(isNil "_x") then
	{
		_CompareObjectPos = [0,0,0];
		if (TypeName _x isEqualTo "OBJECT") then {_CompareObjectPos = getPosWorld _x;};
		if (TypeName _x isEqualTo "STRING") then {_CompareObjectPos = getMarkerPos _x;};
		if (TypeName _x isEqualTo "ARRAY") then {_CompareObjectPos = _x;};
		_NewObjectDistance = _CompareObjectPos distance _position;
		_DistanceArray pushback [_NewObjectDistance,_x];
	};
} foreach _list;

_DistanceArray sort true;

_ClosestObject = ((_DistanceArray select 0) select 1);

if (isNil "_ClosestObject") exitWith {};
_ClosestObject