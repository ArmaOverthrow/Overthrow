private ["_unit", "_bullet", "_TimeShot","_FrameRateCheck", "_Unit", "_Array2", "_Point", "_ArrayCheck", "_UnitGroup", "_CheckVariable1", "_CheckDistance"];
//An extra layer of suppression that will hopefully make AI go for cover better...
//If framerate is below 20 - exit this script.
_FrameRateCheck = diag_fps;
if (_FrameRateCheck <= VCOM_FPSFreeze) exitWith {};

_unit = (_this select 0) select 0;

if (VCOM_CurrentlySuppressing < VCOM_CurrentlySuppressingLimit) then
{
	VCOM_CurrentlySuppressing = VCOM_CurrentlySuppressing + 1;
	_TimeShot = _unit getVariable "VCOM_FiredTime";
	if ((diag_tickTime - _TimeShot) > 25) then 
	{
		

	
		
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
				_Kn = _unit knowsAbout _x;
				if (_CheckDistance < 4 && (_Kn > 3.5)) then 
				{
					if (VCOM_Suppression) then
					{
						if (isPlayer _x) then {remoteExec ["PSup",_x];}
						else
						{
							_x setCustomAimCoef VCOM_SuppressionVar;
							_x spawn {sleep 8; _this setCustomAimCoef 1;};
						};
					};
					if (VCOM_Adrenaline) then
					{
						_x setAnimSpeedCoef VCOM_AdrenalineVar;
						_x spawn {sleep 8; _this setAnimSpeedCoef 1;};
					};
					if (VCOM_AIDEBUG isEqualTo 1) then
					{
						[_x,"I am suppressed!",30,20000] remoteExec ["3DText",0];
					};		
					
				};		
		} forEach units _UnitGroup;
		
	
		
	};
	VCOM_CurrentlySuppressing = VCOM_CurrentlySuppressing - 1;
};