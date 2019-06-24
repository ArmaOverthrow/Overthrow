params ["_frompos","_ao","_attackpos",["_delay",0]];
if (_delay > 0) then {sleep _delay};
private _vehtype = OT_NATO_Vehicles_APC call BIS_fnc_selectRandom;
private _squadtype = OT_NATO_GroundForces call BIS_fnc_SelectRandom;
private _spawnpos = _frompos findEmptyPosition [15,100,_vehtype];
if(count _spawnpos == 0) then {
	_spawnpos = [_frompos,[5,25]] call SHK_pos_fnc_pos;
};
private _group1 = [_spawnpos, WEST, (configFile >> "CfgGroups" >> "West" >> OT_faction_NATO >> "Infantry" >> _squadtype)] call BIS_fnc_spawnGroup;
_group1 deleteGroupWhenEmpty true;
private _group2 = "";
private _tgroup = false;

sleep 0.5;
private _allunits = [];
private _veh = false;

//Transport
private _tgroup = creategroup blufor;

private _dir = _frompos getDir _ao;
private _pos = _frompos findEmptyPosition [15,100,_vehtype];
if(count _pos == 0) then {
	_pos = [_frompos,0,75,false,[0,0],[120,_vehtype]] call SHK_pos_fnc_pos;
};

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
	if(typename _tgroup isEqualTo "GROUP") then {
		_x moveInCargo _veh;
	};
	[_x] joinSilent _group1;
	_allunits pushback _x;
	_x setVariable ["garrison","HQ",false];
	_x setVariable ["VCOM_NOPATHING_Unit",true,false];
}foreach(units _group1);

{
	_x addCuratorEditableObjects [[_veh]+(units _group1),true];
} forEach allCurators;

_tgroup deleteGroupWhenEmpty true;

spawner setVariable ["NATOattackforce",(spawner getVariable ["NATOattackforce",[]])+[_group1],false];

sleep 15;

if((typename _tgroup) isEqualTo "GROUP") then {
	_veh setdamage 0;
	_dir = _attackpos getDir _frompos;
	_roads = _ao nearRoads 150;
	private _dropos = _ao;
	if(count _roads > 0) then {
		_dropos = getpos(_roads select (count _roads - 1));
	};
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
sleep 10;
_wp = _group1 addWaypoint [_attackpos,100];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointSpeed "FULL";

if((typename _tgroup) isEqualTo "GROUP") then {

	[_veh,_tgroup,_frompos] spawn {
		//Ejects crew from vehicles when they take damage or stay relatively still for too long (you know, like when they ram a tree for 4 hours)
		params ["_veh","_tgroup","_frompos"];
		private _done = false;
		private _stillfor = 0;
		private _lastpos = getpos _veh;
		while{sleep 10;!_done} do {
			if(isNull _veh) exitWith {};
			if(isNull _tgroup) exitWith {};
			if(!alive _veh) exitWith {};
			private _eject = false;
			if((damage _veh) > 0 && ((getpos _veh) select 2) < 2) then {
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
			if(_eject) then {
				while {(count (waypoints _tgroup)) > 0} do {
				 	deleteWaypoint ((waypoints _tgroup) select 0);
				};
				commandStop (driver _veh);
				{
					unassignVehicle _x;
					commandGetOut _x;
				}foreach((crew _veh) - (units _tgroup));
				_done = true;

				_wp = _tgroup addWaypoint [_frompos,0];
				_wp setWaypointType "MOVE";
				_wp setWaypointBehaviour "CARELESS";
				_wp setWaypointCompletionRadius 50;

				_wp = _tgroup addWaypoint [_frompos,0];
				_wp setWaypointType "SCRIPTED";
				_wp setWaypointCompletionRadius 50;
				_wp setWaypointStatements ["true","[vehicle this] call OT_fnc_cleanup"];
			};
		};
	};
};
