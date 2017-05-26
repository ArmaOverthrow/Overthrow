private _quiet = false;
if(count _this > 0) then {_quiet = _this select 0};

if(OT_saving) exitWith {
	if !(_quiet) then {
		"Please wait, save still in progress" remoteExec ["OT_fnc_notifyMinor",0,false];
	};
};

if((count alldeadmen) > 300) exitWith {
	if !(_quiet) then {
		"Too many dead bodies, please clean first" remoteExec ["OT_fnc_notifyMinor",0,false];
	};
};

OT_saving = true;
publicVariable "OT_saving";

if !(_quiet) then {
	"Persistent Saving..." remoteExec ["OT_fnc_notifyMinor",0,false];
};
sleep 0.1;
waitUntil {!isNil "OT_NATOInitDone"};

private _data = [];
//get all server data
{
	if !(_x == "StartupType" or _x == "recruits" or _x == "squads" or (_x select [0,11]) == "resgarrison") then {
		_val = server getVariable _x;
		if(typename _val == "ARRAY") then {
			//Copy the array
			_old = _val;
			_val = [];
			{
				_val pushback _x;
			}foreach(_old);
			if(_x == "natoabandoned") then {
				_val deleteAt (_val find (server getvariable ["NATOattacking",""]))
			};
		};
		_data pushback [_x,server getVariable _x];
	};
}foreach(allVariables server);

_poses = [];
{
	_poses pushback [_x,buildingpositions getVariable _x];
}foreach(allVariables buildingpositions);
_data pushback ["buildingpositions",_poses];

_civs = [];
{
	_civs pushback [_x,OT_civilians getVariable _x];
}foreach(allVariables OT_civilians);
_data pushback ["civilians",_civs];

//get all online player data
{
	_uid = getPlayerUID _x;
	_me = _x;
	_val = "";
	_d = [];
	_all = [];
	{
		if(_x != "ot_loaded" and _x != "morale" and _x != "player_uid" and _x != "sa_tow_actions_loaded" and _x != "hiding" and _x != "randomValue" and _x != "saved3deninventory" and (_x select [0,11]) != "MissionData" and (_x select [0,4]) != "ace_" and (_x select [0,4]) != "cba_" and (_x select [0,4]) != "bis_") then {
			_all pushback _x;
			_val = _me getVariable _x;
			if !(isNil "_val") then {
				if(typename _val != "CODE") then {
					_d pushback [_x,_val];
				};
			};
		};
	}foreach(allVariables _me);
	_data pushback [_uid,_d];
}foreach([] call CBA_fnc_players);

private _vehicles = [];

_count = 10001;
{
	if(!(_x isKindOf "Man") and (alive _x) and (_x call OT_fnc_hasOwner) and (typeof _x != OT_flag_IND)) then {
		_owner = _x call OT_fnc_getOwner;
		_s = _x call OT_fnc_unitStock;

		if(typeof _x == OT_item_safe) then {
			_s pushback ["money",_x getVariable ["money",0]];
			_s pushback ["password",_x getVariable ["password",""]];
		};
		_params = [typeof _x,getposatl _x,[vectorDir _x,vectorUp _x],_s,_owner,_x getVariable ["name",""],_x getVariable ["OT_init",""]];
		if(_x isKindOf "AllVehicles") then {
			_ammo = [];
			_veh = _x;
			{
				_ammo pushback [_x,_veh ammo _x];
			}foreach(_x weaponsTurret [0]);
			_params pushback [fuel _x,getAllHitPointsDamage _x,_x call ace_refuel_fnc_getFuel,_x getVariable ["OT_locked",false],_ammo];
		};
		_vehicles pushback _params;
	};
	if(_count > 2000) then {
		if !(_quiet) then {
			"Persistent Saving... please wait" remoteExec ["OT_fnc_notifyMinor",0,false];
		};
		_count = 0;
		sleep 0.01;
	};
	_count = _count + 1;
}foreach((allMissionObjects "Static") + vehicles);

sleep 0.2;
_data pushback ["vehicles",_vehicles];

private _warehouse = [];
{
	_var = warehouse getVariable _x;
	if (!isNil "_var") then {
		_warehouse pushback _var;
	};
}foreach(allvariables warehouse);
_data pushback ["warehouse",_warehouse];

private _recruits = [];
{
	_do = true;
	_unitorpos = _x select 2;
	_d = [_x select 0,_x select 1,_x select 2,_x select 3,_x select 4,_x select 5];
	if(count _x > 6) then {
		_d set [6,_x select 6];
	}else{
		_d set [6,0];
	};
	if(typename _unitorpos == "OBJECT") then {
		if(alive _unitorpos) then {
			_d set [4,getUnitLoadout _unitorpos];
			_d set [2,getpos _unitorpos];
			_d set [6,_unitorpos getVariable ["OT_xp",0]];
		}else{
			_do = false;
		};
	};
	if(_do) then {
		_recruits pushback _d;
	};
}foreach(server getVariable ["recruits",[]]);

_data pushback ["recruits",_recruits];

private _squads = [];
{
	_do = true;
	_x params ["_owner","_cls","_group"];
	if(typeName _group == "GROUP") then {
		if(count units _group == 0) then {_do = false};
		if(({alive _x} count units _group) == 0) then {_do = false};
		if(_do) then {
			_units = [];
			{
				if(alive _x) then {
					_units pushback [typeof _x,position _x,getUnitLoadout _x];
				};
			}foreach(units _group);
			_squads pushback [getplayeruid player,_cls,"",_units,groupId _group];
		};
	};
}foreach(server getVariable ["squads",[]]);

_data pushback ["squads",_squads];

{
	_pos = _x select 0;
	_code = format["fob%1",_pos];
	_group = spawner getvariable [format["resgarrison%1",_code],grpNull];
	if !(isNull _group) then {
		_soldiers = [];
		{
			if(alive _x) then {
				if(vehicle _x == _x) then {
					_soldiers pushback [typeof _x,getUnitLoadout _x];
				}else{
					_veh = vehicle _x;
					if(someAmmo _veh and (typeof _veh == "I_HMG_01_high_F")) then {
						_soldiers pushback ["HMG",[]];
					};
					if(someAmmo _veh and (typeof _veh == "I_GMG_01_high_F")) then {
						_soldiers pushback ["GMG",[]];
					};
				};
			};
		}foreach(units _group);
		if(count _soldiers > 0) then {
			_data pushback [format["resgarrison%1",_code],_soldiers];
		};
	};
}foreach(server getVariable ["bases",[]]);

{
	_pos = server getvariable _x;
	_code = _x;
	_group = spawner getvariable [format["resgarrison%1",_code],grpNull];
	if !(isNull _group) then {
		_soldiers = [];
		{
			if(alive _x) then {
				if(vehicle _x == _x) then {
					_soldiers pushback [typeof _x,getUnitLoadout _x];
				}else{
					_veh = vehicle _x;
					if(someAmmo _veh and (typeof _veh == "I_HMG_01_high_F")) then {
						_soldiers pushback ["HMG",[]];
					};
					if(someAmmo _veh and (typeof _veh == "I_GMG_01_high_F")) then {
						_soldiers pushback ["GMG",[]];
					};
				};
			};
		}foreach(units _group);
		if(count _soldiers > 0) then {
			_data pushback [format["resgarrison%1",_code],_soldiers];
		};
	};
}foreach(OT_allObjectives);

_data pushback ["timedate",date];

{
	_data pushback [format["loadout%1",getplayeruid _x],getUnitLoadout _x];
}foreach([] call CBA_fnc_players);

profileNameSpace setVariable [OT_saveName,_data];
if (isDedicated) then {
	if !(_quiet) then {
		"Saving to dedicated server.. not long now" remoteExec ["OT_fnc_notifyMinor",0,false];;
	};
	sleep 0.01;
	saveProfileNamespace
};

if !(_quiet) then {
	"Persistent Save Completed" remoteExec ["OT_fnc_notifyGood",0,false];
};

OT_saving = false;
publicVariable "OT_saving";
