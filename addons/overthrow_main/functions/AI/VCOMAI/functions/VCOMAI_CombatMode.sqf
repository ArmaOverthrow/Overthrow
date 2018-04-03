//VCOMAI_CombatMode

_Unit = _this select 0;


_NearestEnemy = _Unit call VCOMAI_ClosestEnemy;
if (isNil "_NearestEnemy") exitwith {};

_VCOMAI_LastCStance = _this select 1;
_TimeShot = _Unit getVariable ["VCOM_FiredTime",0];

if ((diag_tickTime - _TimeShot) > 120 && {((_NearestEnemy distance _Unit) > 1000)}) then 
{
	_Unit setBehaviour (_VCOMAI_LastCStance);
};