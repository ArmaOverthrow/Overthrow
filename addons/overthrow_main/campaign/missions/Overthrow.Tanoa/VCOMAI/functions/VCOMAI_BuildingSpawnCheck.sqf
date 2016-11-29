private ["_dgn_returnvariable", "_Position", "_Array","_VCOMAI_StartedInside"];

_dgn_returnvariable = false;

_Position = getposATL _this;
_Array = lineIntersectsObjs [_Position,[_Position select 0,_Position select 1,(_Position select 2) + 10], objnull, objnull, true, 4];
{
	if (_x isKindof "Building") then {_dgn_returnvariable = true;};
} foreach _Array;

_Array = lineIntersectsObjs [_Position,[_Position select 0,_Position select 1,(_Position select 2) - 10], objnull, objnull, true, 4];
{
	if (_x isKindof "Building") then {_dgn_returnvariable = true;};
} foreach _Array;

if (_dgn_returnvariable) then 
{
	_VCOMAI_StartedInside = true;
	_this setvariable ["VCOMAI_StartedInside",true];
}
else
{
	_VCOMAI_StartedInside = false;	
};


_VCOMAI_StartedInside