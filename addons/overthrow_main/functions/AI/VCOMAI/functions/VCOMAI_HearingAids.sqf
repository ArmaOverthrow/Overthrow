//Helps the AI recognize people firing from a better distance
_unit = (_this select 0) select 0;
if ((behaviour _unit) isEqualTo "COMBAT") exitWith {};

_weapon = (_this select 0) select 1;

if (_weapon isEqualTo "Put" || {_weapon isEqualTo "Throw"}) exitwith {};

//Check if unit has suppressor on weapon.
_ItemList = weaponsitems _unit;
_Return = true;

if (((_ItemList select 0) select 1) isEqualTo "") then {_Return = false;};

//systemchat format ["%1",_Sup];
if !(_Return) then 
{
	
	if !(side _unit in VCOM_SideBasedMovement) exitWith {};
	
	_bullet = (_this select 0) select 6;
	
	
	_TimeShot = _unit getVariable ["VCOM_FiredTimeHearing",0];
	
	if ((diag_tickTime - _TimeShot) > 20) then 
	{
		_Array1 = _unit call VCOMAI_EnemyArray;
		
		{
			if ((_x distance _unit) < VCOM_HEARINGDISTANCE && !(_x getVariable "VCOMAI_ShotsFired") && (count ((group _Unit) call VCOMAI_Waypointcheck)) <= 0) then
			{
				_x setVariable ["VCOMAI_ShotsFired",true,true];
				_kv = _x knowsAbout _unit;
				_x reveal [_unit,(_kv + 0.5)];
				if (VCOM_AIDEBUG isEqualTo 1) then
				{
					[_x,"What was that? +0.5 to knowsAbout",10,20000] remoteExec ["3DText",0];
				};					
			};
		} foreach _Array1;
		
		_Unit setVariable ["VCOM_FiredTimeHearing",diag_tickTime,false];
	};
}
else
{

				if (VCOM_AIDEBUG isEqualTo 1) then
				{
					[_unit,"I am sneaky snake...",10,20000] remoteExec ["3DText",0];
				};	

};