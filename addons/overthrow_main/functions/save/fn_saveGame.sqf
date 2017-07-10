private _quiet = false;
if(count _this > 0) then {_quiet = _this select 0};

if(OT_saving) exitWith {
	if !(_quiet) then {
		"Please wait, save still in progress" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
	};
};

if((count alldeadmen) > 300) exitWith {
	if !(_quiet) then {
		"Too many dead bodies, please clean first" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
	};
};

OT_saving = true;
publicVariable "OT_saving";

if !(_quiet) then {
	"Persistent Saving..." remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};
sleep 0.2;
waitUntil {!isNil "OT_NATOInitDone"};
if !(_quiet) then {
	"Step 1/11 - Saving game state" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};
private _data = [];
//get all server data
{
	if !(_x == "StartupType" or _x == "recruits" or _x == "squads" or (_x select [0,11]) == "resgarrison" or (_x select [0,4]) == "ace_" or (_x select [0,4]) == "cba_" or (_x select [0,4]) == "bis_") then {
		_val = server getVariable _x;
		if !(isNil "_val") then {
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
			_data pushback [_x,_val];
		};
	};
}foreach(allVariables server);
if !(_quiet) then {
	"Step 2/11 - Saving buildings" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};
_poses = [];
{
	if((_x select [0,4]) != "ace_" and (_x select [0,4]) != "cba_" and (_x select [0,4]) != "bis_") then {
		_poses pushback [_x,buildingpositions getVariable _x];
	};
}foreach(allVariables buildingpositions);
_data pushback ["buildingpositions",_poses];
if !(_quiet) then {
	"Step 3/11 - Saving civilians" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};
_civs = [];
{
	if((_x select [0,4]) != "ace_" and (_x select [0,4]) != "cba_" and (_x select [0,4]) != "bis_") then {
		_civs pushback [_x,OT_civilians getVariable _x];
	};
}foreach(allVariables OT_civilians);
_data pushback ["civilians",_civs];

if !(_quiet) then {
	"Step 4/11 - Saving player data" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};
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

private _tocheck = (allMissionObjects "Static") + vehicles;
private _tosave = count _tocheck;
if !(_quiet) then {
	format["Step 5/11 - Saving vehicles (%1 to save)",_tosave] remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};
private _vehicles = [];

_count = 0;
private _saved = 0;
{
	_saved = _saved + 1;
	if(!(_x isKindOf "Man") and (alive _x) and (_x call OT_fnc_hasOwner) and (typeof _x != OT_flag_IND)) then {
		_owner = _x call OT_fnc_getOwner;
		_s = _x call OT_fnc_unitStock;

		if(typeof _x == OT_item_safe) then {
			_s pushback ["money",_x getVariable ["money",0]];
			_s pushback ["password",_x getVariable ["password",""]];
		};
		_params = [typeof _x,getposatl _x,[vectorDir _x,vectorUp _x],_s,_owner,_x getVariable ["name",""],_x getVariable ["OT_init",""]];
		if(_x isKindOf "AllVehicles") then {
			if !(_x getVariable ["OT_garrison",false]) then {
				_ammo = [];
				_veh = _x;
				{
					_ammo pushback [_x,_veh ammo _x];
				}foreach(_x weaponsTurret [0]);
				_attached = _x getVariable ["OT_attachedClass",""];
				_att = [];
				if(_attached != "") then {
					_wpn = _veh getVariable ["OT_attachedClass",objNUll];
					if(!isNull _wpn) then {
						if(alive _wpn) then {
							//get attached ammo (if applicable)
							_am = [];
							{
								_am pushback [_x,_wpn ammo _x];
							}foreach(_wpn weaponsTurret [0]);
							_att = [_attached,_am];
						};
					};
				};
				_params pushback [fuel _x,getAllHitPointsDamage _x,_x call ace_refuel_fnc_getFuel,_x getVariable ["OT_locked",false],_ammo,_att];
			};
		};
		_vehicles pushback _params;
	};
	if(_count > 200) then {
		if !(_quiet) then {
			format["Step 5/11 - Saving vehicles (%1 to save)",_tosave - _saved] remoteExecCall ["OT_fnc_notifyAndLog",0,false];
		};
		_count = 0;
		sleep 0.2;
	};
	_count = _count + 1;
}foreach(_tocheck);
_tocheck = [];

sleep 0.2;
_data pushback ["vehicles",_vehicles];

if !(_quiet) then {
	"Step 6/11 - Saving warehouse" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};
private _warehouse = [];
{
	_var = warehouse getVariable _x;
	if (!isNil "_var") then {
		if((_x select [0,4]) != "ace_" and (_x select [0,4]) != "cba_" and (_x select [0,4]) != "bis_") then {
			_warehouse pushback _var;
		};
	};
}foreach(allvariables warehouse);
_data pushback ["warehouse",_warehouse];
if !(_quiet) then {
	"Step 7/11 - Saving recruits" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};
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

if !(_quiet) then {
	"Step 8/11 - Saving squads" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};
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
if !(_quiet) then {
	"Step 9/11 - Saving bases" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};
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
if !(_quiet) then {
	"Step 10/11 - Saving garrisons" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};
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
if !(_quiet) then {
	"Step 11/11 - Saving loadouts" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};
{
	_data pushback [format["loadout%1",getplayeruid _x],getUnitLoadout _x];
}foreach([] call CBA_fnc_players);

profileNameSpace setVariable [OT_saveName,_data];
if (isDedicated) then {
	if !(_quiet) then {
		"Saving to dedicated server.. not long now" remoteExecCall ["OT_fnc_notifyAndLog",0,false];;
	};
	sleep 0.01;
	saveProfileNamespace
};

if !(_quiet) then {
	"Persistent Save Completed" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};

OT_saving = false;
publicVariable "OT_saving";
