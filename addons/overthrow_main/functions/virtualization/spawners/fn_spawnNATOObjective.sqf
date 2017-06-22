params ["_posTown","_name","_spawnid"];
sleep random 0.2;

private _count = 0;
private _groups = [];

_numNATO = server getVariable format["garrison%1",_name];
if(_name in (server getVariable ["NATOabandoned",[]])) exitWith {[]};
if(isNil "_numNATO") then {
	//New objective was added
	_numNATO = 2 + round(random 6);
	server setVariable [format["garrison%1",_name],_numNATO,true];
};

//Make sure the first group spawned in at a comms base are a sniper, spotter, AA specialist and AA assistant
_count = 0;
if(_name in OT_allComms) then {
	_group = createGroup blufor;
	_group deleteGroupWhenEmpty true;
	_groups pushBack _group;

	_start = _posTown findEmptyPosition [0,50];
	_civ = _group createUnit [OT_NATO_Unit_Sniper, _start, [],0, "NONE"];
	_civ setVariable ["garrison",_name,false];
	_civ setRank "CAPTAIN";
	[_civ,_name] call OT_fnc_initSniper;
	_civ setBehaviour "SAFE";

	_count = _count + 1;
	sleep 0.2;

	if(_count < _numNATO) then {
		_start = _posTown findEmptyPosition [0,50];
		_civ = _group createUnit [OT_NATO_Unit_Spotter, _start, [],0, "NONE"];
		_civ setVariable ["garrison",_name,false];
		_civ setRank "CAPTAIN";
		_civ setVariable ["VCOM_NOPATHING_Unit",true,false];
		[_civ,_name] call OT_fnc_initSniper;
		_civ setBehaviour "SAFE";
		_count = _count + 1;
		sleep 0.2;
	};

	if(_count < _numNATO) then {
		_group = createGroup blufor;
		_groups pushBack _group;
		_start = _posTown findEmptyPosition [0,50];
		_civ = _group createUnit [OT_NATO_Unit_AA_spec, _start, [],0, "NONE"];
		_civ setVariable ["garrison",_name,false];
		_civ setRank "CAPTAIN";
		_civ setVariable ["VCOM_NOPATHING_Unit",true,false];
		[_civ,_name] call OT_fnc_initMilitary;
		_civ setBehaviour "SAFE";
		_count = _count + 1;
		sleep 0.2;
		_wp = _group addWaypoint [_posTown,0];
		_wp setWaypointType "GUARD";
		_wp setWaypointBehaviour "SAFE";
		_wp setWaypointSpeed "LIMITED";

	};

	if(_count < _numNATO) then {
		_start = _posTown findEmptyPosition [0,50];
		_civ = _group createUnit [OT_NATO_Unit_AA_ass, _start, [],0, "NONE"];
		_civ setVariable ["garrison",_name,false];
		_civ setRank "CAPTAIN";
		_civ setVariable ["VCOM_NOPATHING_Unit",true,false];
		[_civ,_name] call OT_fnc_initMilitary;
		_civ setBehaviour "SAFE";
		_count = _count + 1;
		sleep 0.2;
	};

}else{
	//put up a flag
	_flag =  OT_flag_NATO createVehicle _posTown;
	_groups pushback _flag;
};

//Garrison any buildings
if(_numNATO > 0) then {
	_garrisongroup = creategroup blufor;
	_garrisongroup deleteGroupWhenEmpty true;
	_groups pushback _garrisongroup;
	private _buildings = nearestObjects [_posTown, OT_garrisonBuildings, 250];
	{
		private _building = _x;
		private _type = typeof _x;

		call {
			if((damage _building) > 0.95) exitWith {};
			if 	((_type == "Land_Cargo_HQ_V1_F") or (_type == "Land_Cargo_HQ_V2_F") or (_type == "Land_Cargo_HQ_V3_F") or (_type == "Land_Cargo_HQ_V4_F")) exitWith {
				_veh = createVehicle [OT_NATO_HMG, (_building buildingPos 8), [],0, "CAN_COLLIDE"];
				_veh setPosATL [(getPos _building select 0),(getPos _building select 1),(getPosATL _veh select 2)];
				_veh setDir (getDir _building);

				createVehicleCrew _veh;
				_groups pushback _veh;
				{
					[_x] joinSilent _garrisongroup;
					_x setVariable ["garrison",_name,false];
				}foreach(crew _veh);
				_numNATO = _numNATO - 1;
			};

			if 	((_type == "Land_Cargo_Patrol_V1_F") or (_type == "Land_Cargo_Patrol_V2_F") or (_type == "Land_Cargo_Patrol_V3_F") or (_type == "Land_Cargo_Patrol_V4_F")) exitWith {
				_ang = (getDir _building) - 190;
				_p = [_building buildingPos 1, 2.3, _ang] call BIS_Fnc_relPos;
				_veh = createVehicle [OT_NATO_HMG, _p, [], 0, "CAN_COLLIDE"];
				_veh setPosATL _p;
				_veh setDir (getDir _building) - 180;

				createVehicleCrew _veh;
				_groups pushback _veh;
				{
					[_x] joinSilent _garrisongroup;
					_x setVariable ["garrison",_name,false];
				}foreach(crew _veh);
				_numNATO = _numNATO - 1;
			};


			_veh = createVehicle [OT_NATO_HMG, (_building buildingPos 11), [], 0, "CAN_COLLIDE"];
			createVehicleCrew _veh;
			_groups pushback _veh;
			{
				[_x] joinSilent _garrisongroup;
				_x setVariable ["garrison",_name,false];
			}foreach(crew _veh);
			_numNATO = _numNATO - 1;

			sleep 0.2;

			_veh = createVehicle [OT_NATO_HMG, (_building buildingPos 13), [], 0, "CAN_COLLIDE"];
			createVehicleCrew _veh;
			_groups pushback _veh;
			{
				[_x] joinSilent _garrisongroup;
				_x setVariable ["garrison",_name,false];
			}foreach(crew _veh);
			_numNATO = _numNATO - 1;
		};

		if(_numNATO <= 0) exitWith {};
	}foreach(_buildings);
};

sleep 0.2;
_range = 100;
_groupcount = 0;
while {_count < _numNATO} do {
	_start = _posTown findEmptyPosition [0,100];
	_group = createGroup blufor;
	_group deleteGroupWhenEmpty true;
	_groups pushBack _group;
	_groupcount = 1;

	_civ = _group createUnit [OT_NATO_Unit_TeamLeader, _start, [],0, "NONE"];
	_civ setVariable ["garrison",_name,false];
	_civ setRank "CAPTAIN";
	_civ setVariable ["VCOM_NOPATHING_Unit",true,false];
	[_civ,_name] call OT_fnc_initMilitary;
	_civ setBehaviour "SAFE";
	{
		_x addCuratorEditableObjects[[_civ],false];
	}foreach(allcurators);

	_count = _count + 1;
	while {(_count < _numNATO) and (_groupcount < 8)} do {
		_start = _start findEmptyPosition [0,50];

		_civ = _group createUnit [OT_NATO_Units_LevelOne call BIS_fnc_selectRandom, _start, [],0, "NONE"];
		_civ setVariable ["garrison",_name,false];
		_civ setRank "LIEUTENANT";
		_civ setVariable ["VCOM_NOPATHING_Unit",true,false];
		[_civ,_name] call OT_fnc_initMilitary;
		_civ setBehaviour "SAFE";

		_count = _count + 1;
		_groupcount = _groupcount + 1;
	};
	_group call OT_fnc_initMilitaryPatrol;
	_range = _range + 50;
	sleep 0.2;
};


_pos = [];
_dir = 0;
_terminal = nearestobjects [_posTown,OT_airportTerminals,350];
if(count _terminal > 0) then {
	_tp = getpos (_terminal select 0);
	_dir = getdir (_terminal select 0);
	_dist = 35;
	if(typeof (_terminal select 0) == "Land_Hangar_F") then {
		_dir = _dir + 180;
		_dist = 50;
	};
	_pos = [_tp,_dist,_dir] call BIS_fnc_relPos;
	_pos = [_pos,100,_dir-90] call BIS_fnc_relPos;
}else{
	_dir = 80;
	_pos = [_posTown,20,_dir] call BIS_fnc_relPos;
	_pos = [_pos,130,_dir-90] call BIS_fnc_relPos;
};
_airgarrison = server getVariable [format["airgarrison%1",_name],[]];
{
	_vehtype = _x;

	_pos = [_pos,42,_dir+90] call BIS_fnc_relPos;

	_veh =  _vehtype createVehicle _pos;
	_veh setVariable ["airgarrison",_name,false];

	_veh setDir _dir;
	sleep 0.2;
	_groups pushback _veh;
}foreach(_airgarrison);

_vehgarrison = server getVariable [format["vehgarrison%1",_name],[]];
_pos = [];
_road = objNull;
{
	_vgroup = creategroup blufor;
	_groups pushback _vgroup;
	_vehtype = _x;
	_dir = 0;
	_got = false;
	if(_vehtype in OT_staticWeapons) then {
		_pos = _posTown findEmptyPosition [10,100,_vehtype];
		if(count _pos > 0) then {
			_dir = [_posTown,_pos] call BIS_fnc_dirTo;
			_p = [_pos,1.5,_dir] call BIS_fnc_relPos;
			_veh =  OT_NATO_Sandbag_Curved createVehicle _p;
			_veh setpos _p;
			_veh setDir (_dir-180);
			_groups pushback _veh;
			_p = [_pos,-1.5,_dir] call BIS_fnc_relPos;
			_veh =  OT_NATO_Sandbag_Curved createVehicle _p;
			_veh setpos _p;
			_veh setDir (_dir);
			_groups pushback _veh;
		};
	}else{
		_pos = [_posTown, 10, 100, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
		_dir = random 360;
	};
	if(count _pos > 0) then {
		_veh =  _vehtype createVehicle _pos;
		_veh setpos _pos;
		_veh setVariable ["vehgarrison",_name,false];

		_veh setDir _dir;
		if(random 100 < 99) then {
			createVehicleCrew _veh;
		};
		sleep 0.2;
		_groups pushback _veh;
		{
			[_x] joinSilent _vgroup;
			_x setVariable ["garrison","HQ",false];
		}foreach(crew _veh);
		_vgroup call OT_fnc_initMilitaryPatrol;
	};
}foreach(_vehgarrison);

//HVTs
{
	_x params ["_id","_loc","_status"];
	if(_loc == _name and _status == "") then {
		_group = createGroup blufor;
		_groups pushBack _group;
		_pos = [_posTown, 10, 100, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
		_civ = _group createUnit [OT_NATO_Unit_HVT, _pos, [],0, "NONE"];
		_civ setVariable ["garrison","HQ",false];
		_civ setVariable ["hvt",true,true];
		_civ setVariable ["hvt_id",_id,true];
		_civ setVariable ["NOAI",true,true];
		_civ setRank "COLONEL";
		_civ setBehaviour "SAFE";
		sleep 0.2;

		//His empty APC
		_vpos = _posTown findEmptyPosition [10,100,OT_NATO_Vehicle_HVT];
		_veh =  OT_NATO_Vehicle_HVT createVehicle _vpos;
		_veh setpos _vpos;
		_veh setVariable ["vehgarrison","HQ",false];

		_groups pushback _veh;

		_wp = _group addWaypoint [_pos, 50];
		_wp setWaypointType "GUARD";
	};
}foreach(OT_NATOhvts);

spawner setvariable [_spawnid,_groups,false];
