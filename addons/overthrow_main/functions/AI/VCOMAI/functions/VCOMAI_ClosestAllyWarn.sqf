//Created on ???
// Modified on : 9/7/14 - Added radio check.   9/10/14 - Added PRIVATE commandArtilleryFire - 9/10/17, rewrote script.

private _Unit = _this select 0;
private _UnitGroup = (group _Unit);
if (_UnitGroup getVariable ["VCOM_CALLINGHELP",false]) exitWith {};
_UnitGroup setVariable ["VCOM_CALLINGHELP",true];

_UnitGroup spawn {sleep 300;_this setVariable ["VCOM_CALLINGHELP",false];};

private _Killer = _this select 1;
private _DeathPosition = getpos _Killer;

//If this gets attached to a player, then exit before doing anything
if (isPlayer _Unit) exitWith {if (VCOM_AIDEBUG isEqualTo 1) then {systemChat format ["Exited ClosestAllyWarn1a..: %1",_UnitGroup];};};
if !((side _UnitGroup) in VCOM_SideBasedMovement) exitWith {if (VCOM_AIDEBUG isEqualTo 1) then {systemChat format ["Exited ClosestAllyWarn1..: %1",_UnitGroup];};};

//Check to see if this unit should be moving to support others or not
//Check to see if this unit is garrisoned. If so, don't do anything
//Check to see if unit has radio. If the unit does not have a radio, then it will not move to support
private _CheckStatus = assignedItems _Unit;

if ((_Unit getVariable ["VCOM_NOPATHING_Unit",false]) || {(_Unit getVariable ["VCOM_GARRISONED",false])} || {(_Unit getVariable ["VCOM_NOAI",false])} || {!("ItemRadio" in _CheckStatus)}) exitWith {if (VCOM_AIDEBUG isEqualTo 1) then {systemChat format ["Exited ClosestAllyWarn2..: %1",_UnitGroup];};};

private _ArrayOrg = _Unit call VCOMAI_FriendlyArray;
_ArrayOrg = _ArrayOrg - ArtilleryArray;
{if ((_x distance _Unit) < 600) then {(group _x) setVariable ["VCOM_CALLINGHELP",true];_x spawn {sleep 300;(group _this) setVariable ["VCOM_CALLINGHELP",false];};};} foreach _ArrayOrg;


private _Array2 = _Killer call VCOMAI_FriendlyArray;
_Array2 = _Array2 - ArtilleryArray;
{
	if (_x distance _Killer > 501) then {_Array2 = _Array2 - [_x];};
} foreach _Array2;


//Lets get a rough estimate of how many enemies we are facing.


if (VCOM_AIDEBUG isEqualTo 1) then
{
	systemChat format ["Man Down...: %1",_UnitGroup];
};	
sleep (30 + (random 30));
if (VCOM_AIDEBUG isEqualTo 1) then
{
	systemChat format ["Group is attempting to call for help...: %1",_UnitGroup];
};

private _EnemyCount = count _Array2;
private _RespondCount = 0;
private _aliveCount = {alive _x} count (units _UnitGroup);
if (_aliveCount > 0) then
{
	{
		if (_RespondCount < _EnemyCount) then
		{

			private _CheckStatus2 = assignedItems _x;
			

			if (!(isNil "_CheckStatus2") && {!(_x getVariable ["VCOM_NOPATHING_Unit",false])} && {!(_x getVariable ["VCOM_GARRISONED",false])} && {"ItemRadio" in _CheckStatus2} && {!((group _x) getVariable ["VCOM_MOVINGTOSUPPORT",false])}) then 
			{


						private _group	= group _x;
						if ((count (waypoints _group)) < 2) then 
						{

							private _WaypointCheck = _group call VCOMAI_Waypointcheck;
							if (count _WaypointCheck < 1) then 
							{
							

								if ((_x distance _Unit) <= VCOM_Unit_AIWarnDistance) then 
								{

											_x setbehaviour "AWARE";
											(group _x) setVariable ["VCOM_MOVINGTOSUPPORT",true];
											if (!(vehicle _x isEqualTo _x)) then
											{
													_RespondCount = _RespondCount + count (crew (vehicle _x));
													private _Driver = (driver (vehicle _x));
													//systemchat format ["_RespondCountDRIVER %1 GROUP: %2",[_EnemyCount,_RespondCount],(group _x)];
													_waypoint2 = (group _Driver) addwaypoint[_DeathPosition,15,150];
													_waypoint2 setwaypointtype "MOVE";
													_waypoint2 setWaypointSpeed "NORMAL";
													_waypoint2 setWaypointBehaviour "AWARE";												
											}
											else
											{
													_RespondCount = _RespondCount + (count (units (group _x)));
													//systemchat format ["_RespondCount %1 GROUP: %2",[_EnemyCount,_RespondCount],(group _x)];
													_waypoint2 = (group _x) addwaypoint[_DeathPosition,15,150];
													_waypoint2 setwaypointtype "MOVE";
													_waypoint2 setWaypointSpeed "NORMAL";
													_waypoint2 setWaypointBehaviour "AWARE";

														private _Driver = Driver (vehicle _x);
														_waypoint2 = (group _Driver) addwaypoint[_DeathPosition,15,150];
														_waypoint2 setwaypointtype "MOVE";
														_waypoint2 setWaypointSpeed "NORMAL";
														_waypoint2 setWaypointBehaviour "AWARE";											
											};


											(group _x) spawn 
											{
												sleep 300;
												_this setVariable ["VCOM_MOVINGTOSUPPORT",false];
											};
											
										if (VCOM_AIDEBUG isEqualTo 1) then
										{
											[_x,"Warned of Combat!",120,20000] remoteExec ["3DText",0];
										};												
								
								};
							};
	
						};
						
						


	
			
			};	
		};
	} foreach _ArrayOrg;	
};
