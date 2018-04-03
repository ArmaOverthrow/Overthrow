//Function that executes on AI when they are hit.
//Updated on 08/17/17 @ 1725

private _Unit = _this select 0;

//If the unit got hit recently, ignore this.
if (_Unit getVariable ["Vcom_GHit",false]) exitWith {};
_Unit setVariable ["VCOM_GHit",true];
_Unit spawn {sleep 30;_this setVariable ["VCOM_GHit",false];};

if (isPlayer _Unit) exitWith {};
if ((vehicle _Unit) != _Unit) exitWith {};

//Lay down
_Unit setUnitPos "DOWN";_Unit spawn {sleep 30; _this setUnitPos "MIDDLE";sleep 30;_this setUnitPos "AUTO";};

if ((random 100) < 5) then
{
	_unit setUnconscious true;
	_unit spawn {sleep 15;_this setUnconscious false;};
	
};

//[_Unit,false,false,false,false] spawn VCOMAI_MoveToCover;
if (VCOM_AIDEBUG isEqualTo 1) then
{
	[_Unit,"I am hit!",30,20000] remoteExec ["3DText",0];
};