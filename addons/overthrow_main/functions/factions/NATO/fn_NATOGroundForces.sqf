params ["_frompos","_ao","_attackpos","_byair",["_delay",0]];
if (_delay > 0) then {sleep _delay};
private _vehtype = OT_NATO_Vehicle_Transport call BIS_fnc_selectRandom;
if(_byair) then {
	_vehtype = OT_NATO_Vehicle_AirTransport call BIS_fnc_selectRandom;
};
private _squadtype = OT_NATO_GroundForces call BIS_fnc_SelectRandom;
private _spawnpos = _frompos;
private _group1 = [_spawnpos, WEST, (configFile >> "CfgGroups" >> "West" >> OT_faction_NATO >> "Infantry" >> _squadtype)] call BIS_fnc_spawnGroup;
_group1 deleteGroupWhenEmpty true;
private _group2 = "";
private _tgroup = false;
if !(_byair) then {
	sleep 0.2;
	_squadtype = OT_NATO_GroundForces call BIS_fnc_SelectRandom;
	_group2 = [_spawnpos, WEST, (configFile >> "CfgGroups" >> "West" >> OT_faction_NATO >> "Infantry" >> _squadtype)] call BIS_fnc_spawnGroup;
	_group2 deleteGroupWhenEmpty true;
};
sleep 0.5;
private _allunits = [];
private _veh = false;


//Transport
private _tgroup = creategroup blufor;

private _pos = _frompos findEmptyPosition [15,100,_vehtype];
if(count _pos == 0) then {
	_pos = [_frompos,0,75,false,[0,0],[120,_vehtype]] call SHK_pos_fnc_pos;
};

private _dir = [_frompos,_ao] call BIS_fnc_dirTo;

_veh = _vehtype createVehicle _pos;
_veh setVariable ["garrison","HQ",false];
clearWeaponCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
clearItemCargoGlobal _veh;
clearBackpackCargoGlobal _veh;

_veh setDir (_dir);
_tgroup addVehicle _veh;
createVehicleCrew _veh;
{
	[_x] joinSilent _tgroup;
	_x setVariable ["garrison","HQ",false];
	_x setVariable ["NOAI",true,false];
}foreach(crew _veh);
_allunits = (units _tgroup);
sleep 1;

{
	_x addCuratorEditableObjects [[_veh],true];
} forEach allCurators;

_tgroup deleteGroupWhenEmpty true;

{
	if(typename _tgroup isEqualTo "GROUP") then {
		_x moveInCargo _veh;
	};
	[_x] joinSilent _group1;
	_allunits pushback _x;
	_x setVariable ["garrison","HQ",false];
	_x setVariable ["VCOM_NOPATHING_Unit",true,false];

	[_x] call OT_fnc_initMilitary;

}foreach(units _group1);

{
	_x addCuratorEditableObjects [units _group1,true];
} forEach allCurators;

spawner setVariable ["NATOattackforce",(spawner getVariable ["NATOattackforce",[]])+[_group1],false];

if !(_byair) then {
	{
		if(typename _tgroup isEqualTo "GROUP") then {
			_x moveInCargo _veh;
		};
		[_x] joinSilent _group2;
		_x setVariable ["VCOM_NOPATHING_Unit",true,false];
		_allunits pushback _x;
		_x setVariable ["garrison","HQ",false];
		[_x] call OT_fnc_initMilitary;
		
	}foreach(units _group2);
	{
		_x addCuratorEditableObjects [units _group2,true];
	} forEach allCurators;
	spawner setVariable ["NATOattackforce",(spawner getVariable ["NATOattackforce",[]])+[_group2],false];
};

sleep 15;
if(_byair && _tgroup isEqualType grpNull) then {
	_wp = _tgroup addWaypoint [_frompos,0];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointSpeed "FULL";
	_wp setWaypointCompletionRadius 150;
	_wp setWaypointStatements ["true",format["(vehicle this) flyInHeight %1;",75+random 50]];

	_wp = _tgroup addWaypoint [_ao,0];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointStatements ["true","(vehicle this) AnimateDoor ['Door_rear_source', 1, false];"];
	_wp setWaypointCompletionRadius 50;
	_wp setWaypointSpeed "FULL";

	_wp = _tgroup addWaypoint [_ao,0];
	_wp setWaypointType "SCRIPTED";
	_wp setWaypointStatements ["true","[vehicle this,75] spawn OT_fnc_parachuteAll"];
	_wp setWaypointTimeout [5,5,5];

	_wp = _tgroup addWaypoint [_ao,0];
	_wp setWaypointType "SCRIPTED";
	_wp setWaypointBehaviour "CARELESS";
	_wp setWaypointStatements ["true","(vehicle this) AnimateDoor ['Door_rear_source', 0, false];"];
	_wp setWaypointTimeout [20,20,20];
}else{
	if(typename _tgroup isEqualTo "GROUP") then {
		_veh setdamage 0;
		_dir = [_attackpos,_frompos] call BIS_fnc_dirTo;
		_roads = _ao nearRoads 150;
		private _dropos = _ao;

		//Try to make sure drop position is on a bigger road
		{
			private _pos = getpos _c;
			if(isOnRoad _pos) exitWith {_dropos = _pos};
		}foreach(_roads);

		_move = _tgroup addWaypoint [_dropos,0];
		_move setWaypointBehaviour "CARELESS";
		_move setWaypointType "MOVE";

		_move = _tgroup addWaypoint [_dropos,0];
		_move setWaypointTimeout [30,30,30];
		_move setWaypointType "TR UNLOAD";
		_move setWaypointCompletionRadius 50;

		_wp = _tgroup addWaypoint [_frompos,0];
		_wp setWaypointType "MOVE";
		_wp setWaypointBehaviour "CARELESS";
		_wp setWaypointCompletionRadius 25;

		_wp = _tgroup addWaypoint [_frompos,0];
		_wp setWaypointType "SCRIPTED";
		_wp setWaypointCompletionRadius 25;
		_wp setWaypointStatements ["true","[vehicle this] call OT_fnc_cleanup"];
	};
};
sleep 10;

_wp = _group1 addWaypoint [_attackpos,100];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointSpeed "FULL";

if(typename _tgroup isEqualTo "GROUP") then {

	[_veh,_tgroup,_frompos,_byair] spawn {
		//Ejects crew from vehicles when they take damage or stay relatively still for too long (you know, like when they ram a tree for 4 hours)
		params ["_veh","_tgroup","_frompos","_byair"];
		private _done = false;
		private _stillfor = 0;
		private _lastpos = getpos _veh;
		while{sleep 10;!_done} do {
			if(isNull _veh) exitWith {};
			if(isNull _tgroup) exitWith {};
			if(!alive _veh) exitWith {};
			private _eject = false;
			if((damage _veh) > 0.5 && ((getpos _veh) select 2) < 2) then {
				//Vehicle damaged (and on the ground)
				_eject = true;
			};
			if((getpos _veh) distance _lastpos < 0.5) then {
				_stillfor = _stillfor + 10;
				if(_stillfor > 60) then {
					//what are you doing? gtfo
					_eject = true;
				};
			}else{
				_stillfor = 0;
			};
			if(_eject) exitWith {
				while {(count (waypoints _tgroup)) > 0} do {
				 	deleteWaypoint ((waypoints _tgroup) select 0);
				};
				commandStop (driver _veh);
				{
					unassignVehicle _x;
					commandGetOut _x;
				}foreach(crew _veh);
				_done = true;

				_wp = _tgroup addWaypoint [_frompos,0];
				_wp setWaypointType "MOVE";
				_wp setWaypointBehaviour "CARELESS";
				_wp setWaypointCompletionRadius 50;

				_wp = _tgroup addWaypoint [_frompos,0];
				_wp setWaypointType "SCRIPTED";
				_wp setWaypointCompletionRadius 50;
				_wp setWaypointStatements ["true","this call OT_fnc_cleanup"];
			};
			if(_byair && (_veh getVariable ["OT_deployedTroops",false])) exitWith {
				while {(count (waypoints _tgroup)) > 0} do {
					deleteWaypoint ((waypoints _tgroup) select 0);
				};

				sleep 5;

				_wp = _tgroup addWaypoint [_frompos,50];
				_wp setWaypointType "MOVE";
				_wp setWaypointBehaviour "SAFE";
				_wp setWaypointSpeed "FULL";

				waitUntil{sleep 10;(alive _veh && (_veh distance _frompos) < 150) || !alive _veh};

				if(alive _veh) then {
					while {(count (waypoints _tgroup)) > 0} do {
						deleteWaypoint ((waypoints _tgroup) select 0);
					};
					_veh land "LAND";
					waitUntil{sleep 10;(getpos _veh)#2 < 2};
				};
				_veh call OT_fnc_cleanup;
				_tgroup call OT_fnc_cleanup;
			};


		};
	};
};

if !(_byair) then {
	_wp = _group2 addWaypoint [_attackpos,100];
	_wp setWaypointType "SAD";
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointSpeed "FULL";
};
