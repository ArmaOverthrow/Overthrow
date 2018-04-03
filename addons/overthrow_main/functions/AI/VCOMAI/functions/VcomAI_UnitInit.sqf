_Unit = _this select 0;

/*
if (VCOM_AIDEBUG isEqualTo 1) then 
{
	[_Unit] spawn 
	{
		_Unit = _this select 0;
		while {alive _Unit} do 
		{
			sleep 0.25;
			if (_Unit isEqualTo (vehicle _Unit)) then
			{
				if ((side _Unit) isEqualTo EAST) then 
				{
					_arrow = "Sign_Arrow_Direction_F" createVehicle [0,0,0];
					
					[_arrow] spawn 
					{
						_arrow = _this select 0;
						sleep 10;
						deletevehicle _arrow;
						MarkerArray = MarkerArray - [_arrow];
					};
					
					_arrow setPosASL (eyePos _Unit);
					_arrow setDir (getDir _Unit);
					MarkerArray = MarkerArray + [_arrow];
				};
				if ((side _Unit) isEqualTo WEST) then 
				{
					_arrow = "Sign_Arrow_Direction_Blue_F" createVehicle [0,0,0];
					
					[_arrow] spawn 
					{
						_arrow = _this select 0;
						sleep 10;
						deletevehicle _arrow;
						MarkerArray = MarkerArray - [_arrow];
					};
					
					
					_arrow setPosASL (eyePos _Unit);
					_arrow setDir (getDir _Unit);
					MarkerArray = MarkerArray + [_arrow];
				};
				if ((side _Unit) isEqualTo RESISTANCE) then 
				{
					_arrow = "Sign_Arrow_Direction_Blue_F" createVehicle [0,0,0];
					
					[_arrow] spawn 
					{
						_arrow = _this select 0;
						sleep 10;
						deletevehicle _arrow;
						MarkerArray = MarkerArray - [_arrow];
					};
					
					
					_arrow setPosASL (eyePos _Unit);
					_arrow setDir (getDir _Unit);
					MarkerArray = MarkerArray + [_arrow];
				};			
			};
		};
		_arrow = "Sign_Arrow_Pink_F" createVehicle [0,0,0];
		
		[_arrow] spawn 
		{
			_arrow = _this select 0;
			sleep 10;
			deletevehicle _arrow;
			MarkerArray = MarkerArray - [_arrow];
		};
		
		
		_arrow setPosASL (eyePos _Unit);
		_arrow setDir (getDir _Unit);
		MarkerArray = MarkerArray + [_arrow];
	};
};
*/

_Player = false;
if (isPlayer _Unit) then {_Player = true;};

//Determine if this AI should even execute new code
_UseAI = _Unit getVariable ["VCOM_NOAI",false];
if (isNil ("_UseAI")) then 
{
	_UseAI = false;
};
_Passarray = [_UseAI,_Player];
_Passarray