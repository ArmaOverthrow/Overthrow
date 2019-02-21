private ["_Unit", "_coverObjects", "_startingdistance", "_class", "_return", "_parents", "_BoundingArray", "_p1", "_p2", "_maxWidth", "_maxLength", "_GroupLeader", "_unit", "_NearestEnemy", "_GuessLocation", "_coverObjectsClosest", "_Closestobject", "_coverObjectspos", "_arrow", "_UnitGroup", "_OriginalSpeed", "_WaitTime","_WeakListFinal"];

_Unit = _this select 0;
if !((vehicle _Unit) isEqualTo _Unit) exitWith {};

waitUntil {VCOM_CurrentlyMoving < VCOM_CurrentlyMovingLimit};

	VCOM_CurrentlyMoving = VCOM_CurrentlyMoving + 1;
	
	_VCOM_MovedRecentlyCover = _this select 1;
	_VCOM_GRENADETHROWN = _this select 2;
	_VCOM_InCover = _this select 3;
	_VCOMAI_StartedInside = _this select 4;
	
	//Let's find the nearest enemy to his unit.
	_NearestEnemy = _Unit call VCOMAI_ClosestEnemy;
	_DistanceCheck = _NearestEnemy distance _Unit;
	if (isNil "_NearestEnemy" || {(typeName _NearestEnemy isEqualTo "ARRAY")} || {isNil "_Unit"} || {!(alive _NearestEnemy)} || {(_DistanceCheck) > 2000}) exitWith {_Unit forcespeed -1;VCOM_CurrentlyMoving = VCOM_CurrentlyMoving - 1;};
	
	
	
	_MoveToPos = (getpos _Unit);
	_VCOM_GARRISONED = _Unit getVariable ["VCOM_GARRISONED",false];
	_CoverPos = [_Unit,_MoveToPos,_VCOM_GARRISONED,_VCOM_MovedRecentlyCover,false,_VCOMAI_StartedInside,_NearestEnemy] call VCOMAI_FindCoverPos;
	
	if !(isNil "_CoverPos") then
	{
		//Lets us know where they were told to move!
		if (VCOM_AIDEBUG isEqualTo 1) then
		{
			_arrow = "Sign_Sphere200cm_F" createVehicle [0,0,0];
			_arrow setpos _CoverPos;
			_arrow spawn 
			{
				_Counter = 0;
				_Position = getpos _this;
				_NewPos2 = _Position select 2;						
				while {_Counter < 60} do
				{
					_NewPos2 = _NewPos2 + 0.1;
					_this setpos [_Position select 0,_Position select 1,_NewPos2];
					_Counter = _Counter + 1;
					sleep 0.5;
				};
				deletevehicle _this;
			};
		};
	
		_WaitTime = diag_ticktime + 35;
		_Unit doWatch ObjNull;
		_Unit disableAI "TARGET";
		_Unit disableAI "AUTOTARGET";																									
		_Unit disableAI "SUPPRESSION";				
		_Unit disableAI "AUTOCOMBAT";				
		While {alive _Unit && diag_ticktime < _WaitTime && (_Unit distance _CoverPos) > 3} do 
		{
					_Unit forcespeed -1;
					_Unit domove _CoverPos;
			sleep 4;		
		};
		_Unit forcespeed 0;
		_Unit doWatch _NearestEnemy;
		_Unit enableAI "AUTOTARGET";
		_Unit enableAI "TARGET";		
		_Unit enableAI "SUPPRESSION";				
		_Unit enableAI "AUTOCOMBAT";				
	}
	else
	{
		_Unit doMove _MoveToPos;
	};
	VCOM_CurrentlyMoving = VCOM_CurrentlyMoving - 1;