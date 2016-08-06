private ["_unit", "_bullet", "_TimeShot","_FrameRateCheck", "_Unit", "_Array2", "_Point", "_ArrayCheck", "_UnitGroup", "_CheckVariable1", "_CheckDistance"];
//An extra layer of suppression that will hopefully make AI go for cover better...
_unit = (_this select 0) select 0;

_bullet = (_this select 0) select 6;
_TimeShot = _unit getVariable "VCOM_FiredTime";
if ((diag_tickTime - _TimeShot) > 10) then 
{
	
	//If framerate is below 15 - exit this script.
	_FrameRateCheck = diag_fps;
	if (_FrameRateCheck <= 15) exitWith {};

	
	_unit setVariable ["VCOM_FiredTime",diag_tickTime,true];
	
	_pos = cursorTarget;
	if (isNull _pos) then 
	{
		if (isPlayer _Unit) then 
		{
			//Remember, screenToWorld is using UI coordinates! 
			_pos = screenToWorld [0.5,0.5];
		}
		else
		{
			_pos = assignedTarget _Unit;
			if (isNull _pos) then {_pos = getPosATL _Unit};
		};
	}
	else
	{
		_pos = getPosATL _pos;
	};
	
	_Point = _Unit call VCOMAI_ClosestEnemy;
	if (_Point isEqualTo [] || {isNil "_Point"}) exitWith {};
	
	_ArrayCheck = typeName _Point;
	if (_ArrayCheck isEqualTo "ARRAY") exitWith {};

	_UnitGroup = group _Point;
	
	
	{
			_CheckDistance = (_pos distance _x);
			if (_CheckDistance < 50) then 
			{
				_x setSuppression 1;
			};		
	} forEach units _UnitGroup;
	

	
};
