//Created on ???
// Modified on : 9/7/14 - Added radio check.   9/10/14 - Added PRIVATE commandArtilleryFire

private ["_Unit","_Wall","_Direction","_Killer","_UnitSide","_NoFlanking","_GrabVariable","_CheckStatus","_Array1","_NoFlanking2","_CheckStatus2","_GrabVariable2","_CombatStance","_group","_index","_WaypointIs","_waypoint0"];

_Unit = _this select 0;

_Unit spawn
{
sleep 8;
private ["_Wall"];
	_Direction = 0;
	for "_i" from 0 to 1 step 1 do
	{
		_Wall = "Land_InvisibleBarrier_F" createvehiclelocal (getpos _this);
		_Wall disableCollisionWith _this;		
		_Wall setDir _Direction;
		_Wall setposATL (getposATL _this);		
		
		
		//[[_Wall],"DisableCollisionALL"] call BIS_fnc_MP;
		[_Wall] remoteExec ["DisableCollisionALL",0];
		_Wall disableCollisionWith player;
		
		_Wall spawn {sleep 120;deletevehicle _this;};
		_Direction = 90;
	};
};


if !(side _unit in VCOM_SideBasedMovement) exitWith {};


_Killer = _this select 1;

//If this gets attached to a player, then exit before doing anything
if (isPlayer _Unit) exitWith {};

//Let's pull the units group side
_UnitSide = side (group _Unit);

//If the unit is in the ArtilleryArray, then remove it
if (_Unit in ArtilleryArray) then {ArtilleryArray = ArtilleryArray - [_Unit];};

//Check to see if this unit should be moving to support others or not
//Check to see if this unit is garrisoned. If so, don't do anything
//Check to see if unit has radio. If the unit does not have a radio, then it will not move to support
_NoFlanking = _Unit getVariable "VCOM_NOPATHING_Unit";
_GrabVariable = _Unit getVariable "VCOM_GARRISONED";
_CheckStatus = assignedItems _Unit;

if (_NoFlanking || {_GrabVariable} || {!("ItemRadio" in _CheckStatus)}) exitWith {};

_Array1 = _Unit call VCOMAI_FriendlyArray;
_Array1 = _Array1 - ArtilleryArray;
{
	_NoFlanking2 = _x getVariable ["VCOM_NOPATHING_Unit",false];
	if !(_NoFlanking2) then 
	{
		_CheckStatus2 = assignedItems _x;
		if ("ItemRadio" in _CheckStatus2) then 
			{
				
				_GrabVariable2 = _x getVariable ["VCOM_GARRISONED",false];
				
				
				if !(_GrabVariable2) then 
				{
					_group	= group _x;
					if ((count (waypoints _group)) < 2) then 
					{
						
						_WaypointCheck = _group call VCOMAI_Waypointcheck;
						if (count _WaypointCheck < 1) then 
						{
						
							if ((_x distance _Unit) <= (_x getVariable "VCOM_Unit_AIWarnDistance") ) then 
							{
										_x setbehaviour "COMBAT";
										_x setVariable ["VCOM_MOVINGTOSUPPORT",true,false];
										_x spawn 
										{
											sleep 30;
											_this setVariable ["VCOM_MOVINGTOSUPPORT",false,false];
										};
							
						};
					};

					};
				};
			};
		};
} forEach _Array1;