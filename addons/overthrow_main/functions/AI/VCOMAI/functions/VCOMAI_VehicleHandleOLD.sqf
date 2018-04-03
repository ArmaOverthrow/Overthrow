
private ["_Unit", "_myNearestEnemy", "_UnitSide", "_UnitGroup", "_GroupUnits", "_Vehicle", "_CargoList", "_waypoint0", "_ClosestUnit", "_ResetWaypoint","_GroupArray"];
//Created on ???
// Modified on : 8/19/14 - 8/3/15 - 9/1/15

_Unit = _this select 0;

_myNearestEnemy = _this select 1;
if (isNil "_myNearestEnemy" || {_myNearestEnemy isEqualTo []}) exitWith {};

_UnitSide = side _Unit;

_UnitGroup = group _Unit;
_GroupUnits = units _UnitGroup;
_Vehicle = (vehicle _Unit);
_CargoList = assignedCargo _Vehicle;





	
	if ((_myNearestEnemy distance _Unit) < 600) then 
	{
	
	if !((count _CargoList) isEqualTo 0) then
	{
		_GroupArray = [];

		
		{
						if !((group _x) in _GroupArray) then
						{
							_GroupArray pushback (group _x);
						};
		
		} foreach _CargoList;
			
			if ((getPos _Vehicle select 2) < 3) then 
			{
				{
					{
							
							if (!(_x isEqualTo (assignedDriver (vehicle _x))) && {!(_x isEqualTo (assignedGunner (vehicle _x)))} && {!(_x isEqualTo (assignedCommander  (vehicle _x)))}) then
							{
									[_x] orderGetIn false;
									(group _x) leaveVehicle (vehicle _x);
									unassignVehicle _x;
									commandGetOut _x;
									//_x action ["eject", _Vehicle];
									(driver _Vehicle) land "GET OUT";
									_Vehicle land "GET OUT";
									
									if (leader _x isEqualTo _x) then 
									{
											_waypoint2 = (group _x) addwaypoint[_myNearestEnemy,15];
											_waypoint2 setwaypointtype "MOVE";
											_waypoint2 setWaypointSpeed "NORMAL";
											_waypoint2 setWaypointBehaviour "AWARE";
									};											
									
							};
				
					} foreach units _x;
				} foreach _GroupArray;
			}
			else
			{
				(driver _Vehicle) land "GET OUT";
				_Vehicle land "GET OUT";
				//waitUntil {(getPos _Vehicle select 2) < 15;};
				//_Vehicle engineOn false;
				waitUntil {(getPos _Vehicle select 2) < 2.5;};
				{
					{
							if (!(_x isEqualTo (assignedDriver (vehicle _x))) && {!(_x isEqualTo (assignedGunner (vehicle _x)))} && {!(_x isEqualTo (assignedCommander  (vehicle _x)))}) then
							{					
									[_x] orderGetIn false;			
									(group _x) leaveVehicle (vehicle _x);									
									unassignVehicle _x;
									commandGetOut _x;
									
									if (leader _x isEqualTo _x) then 
									{
											_waypoint2 = (group _x) addwaypoint[_myNearestEnemy,15];
											_waypoint2 setwaypointtype "MOVE";
											_waypoint2 setWaypointSpeed "NORMAL";
											_waypoint2 setWaypointBehaviour "AWARE";
									};									
									
									//_x action ["eject", _Vehicle];
							};
					} foreach units _x;
				} foreach _GroupArray;
				
			};
		};
	};

if ((count (waypoints _UnitGroup)) < 2) then
{


	if ((count (units _UnitGroup)) > 1) then
	{
			[_Unit,false,false,_Unit getvariable ["VCOMAI_StartedInside",false],false] spawn VCOMAI_FlankManeuver;
			
		
		_GroupLeader = leader _Unit;
		
		if (_GroupLeader isEqualTo _Unit) then
		{
		
			_index = currentWaypoint _UnitGroup;
			_WPPosition = getWPPos [_UnitGroup,_index];
			_Unit doMove _WPPosition;
		
		
		
		}
		else
		{
		
			_Unit doFollow _GroupLeader;
		
		
		};
	};

	
	
			_index = currentWaypoint _UnitGroup;
			_WPPosition = getWPPos [_UnitGroup,_index];
			_Unit doMove _WPPosition;
		
	
};