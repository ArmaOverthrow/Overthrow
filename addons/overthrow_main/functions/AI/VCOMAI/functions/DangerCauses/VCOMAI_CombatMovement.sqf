//Created on 8/14/14
// Modified on : 8/3/16: Resolved AI getting stuck when no enemies existed, or enemies were far away.

private ["_Unit", "_VCOM_MovedRecently", "_VCOM_VisuallyCanSee", "_NearestEnemy", "_intersections"];
	
	_Unit = _this select 0;
	_VCOM_MovedRecently = _this select 1;
	_VCOM_VisuallyCanSee = _this select 2;
	_VCOM_MovedRecentlyCover = _this select 3;
	
	////systemchat format ["M %1",_Unit];	
	//_NearestEnemy = _Unit call VCOMAI_ClosestEnemy;
	_NearestEnemy = _Unit findNearestEnemy _Unit;
	_DistanceCheck = _NearestEnemy distance _Unit;
	//if (isNil "_NearestEnemy" || {_VCOM_MovedRecentlyCover} || {(typeName _NearestEnemy isEqualTo "ARRAY")} || {isNil "_Unit"} || {!(alive _NearestEnemy)} || {(_NearestEnemy distance _Unit) > 5000}) exitWith {};
	if (isNil "_NearestEnemy" || {(typeName _NearestEnemy isEqualTo "ARRAY")} || {isNil "_Unit"} || {!(alive _NearestEnemy)} || {(_DistanceCheck) > 2000}) exitWith {_Unit forcespeed -1;};
	
	
		//This will tell the AI to regroup if they have wandered too far.
		_ReturnedFriendly = [units (group _Unit),_Unit] call VCOMAI_ClosestObject;
		if (isNil "_ReturnedFriendly") then {_ReturnedFriendly = [0,0,0]};
		if (_ReturnedFriendly distance _Unit > 30 && !(_ReturnedFriendly isEqualTo [0,0,0])) then 
		{
			_Unit doMove (getpos _ReturnedFriendly);_Unit forcespeed -1;
			if (VCOM_AIDEBUG isEqualTo 1) then
			{
				[_Unit,"I wandered too far :(. Returning to group.",15,20000] remoteExec ["3DText",0];
			};						
		
		};
		
	//_intersections = lineIntersectsSurfaces [eyePos _Unit,eyepos _NearestEnemy,_Unit,_NearestEnemy, true, 1];
	_cansee = [_Unit, "VIEW"] checkVisibility [eyePos _Unit, eyePos _NearestEnemy];
	//systemchat format ["%1:,%2 -> %3",_unit,_cansee,_DistanceCheck];
	//hintsilent format ["%2: %1",_cansee,_Unit];
	//If the enemy is REALLY close, JUST OPEN FIRE!
	//if ((count _intersections) isEqualTo 0 && ((_DistanceCheck) < 50)) exitwith 
	
	if (_cansee > 0 && {(_DistanceCheck) < 25}) exitwith 
	{
			_VCOM_VisuallyCanSee = true;
			_Unit forceSpeed 0;
			_Unit setUnitPos "AUTO";
			_Unit doSuppressiveFire _NearestEnemy;
			if (VCOM_AIDEBUG isEqualTo 1) then
			{
				[_Unit,"Enemy is close! Fire fire fire!",15,20000] remoteExec ["3DText",0];
			};					
			_VCOM_VisuallyCanSee
			
	};
	

	if (_VCOM_MovedRecentlyCover) exitwith {};
	if (_DistanceCheck < 100) then {_Unit forcespeed 0.7;};
	
	if (_cansee > 0 && ((_DistanceCheck) < 500)) exitwith 
	{
			_VCOM_VisuallyCanSee = true;
			_Unit setUnitPos "AUTO";
			_Unit doSuppressiveFire _NearestEnemy;
			_VCOM_VisuallyCanSee
	};
	
	
	if (_VCOM_MovedRecently) exitWith {};
	
	
	if (_cansee > 0 && ((_DistanceCheck) < 1000)) then 
	{
			_VCOM_VisuallyCanSee = true;
			_Unit setUnitPos "AUTO";
			_Unit doSuppressiveFire _NearestEnemy;
			//systemchat "SUPPRESSIVE!";
	}
	else
	{
			_VCOM_VisuallyCanSee = false;
			//_Unit spawn {sleep 10;if !(_Unit getVariable "VCOM_VisuallyCanSee") then {_Unit forceSpeed -1;};};
	};
//};