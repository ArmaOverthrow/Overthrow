params [["_user",objNull],["_quiet", false],["_autoSave",false]];

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

if (isNil "OT_NATOInitDone") exitWith {
	if !(_quiet) then {
		"NATO Init process is not done, wait a bit and try again" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
	};
};

missionNameSpace setVariable ["OT_saving",true,true];

{
	_x setVariable ["OT_newplayer",false,true];
} forEach ([] call CBA_fnc_players);

OT_autoSave_last_time = time + (OT_autoSave_time*60);

if !(_quiet) then {
	"Persistent Saving..." remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};

if !(_quiet) then {
	"Step 1/11 - Saving game state" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};

// Save game array
private _data = [];

// get all server data
private _server = (allVariables server select {

	private _val = server getVariable _x;
	if (isNil "_val") then {
		false
	} else {

		_x = toLower _x;
		!(_x in ["startuptype","recruits","squads"])
		&& {(_x select [0,11]) != "resgarrison"}
		&& {(_x select [0,9]) != "seencache"}
		&& {!((_x select [0,4]) in ["ace_","cba_","bis_"])}
		&& {!((_x select [0,7]) in ["@attack","@counte","@assaul"])}
	};
}) apply {
	private _val = server getVariable _x;

	// copy array, we might modify them
	if(_val isEqualType []) then {_val = +_val;};

	// dont abondon current attacks
	if(_x isEqualTo "natoabandoned") then {
		_val deleteAt (_val find (server getvariable ["NATOattacking",""]))
	};

	[_x,_val]
};

if !(_quiet) then {
	"Step 2/11 - Saving buildings" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};

private _prefixFilter = { !((toLower _x select [0,4]) in ["ace_","cba_","bis_","____"]) };

private _poses = (allVariables buildingpositions select _prefixFilter) apply {
	[_x,buildingpositions getVariable _x]
};
_data pushback ["buildingpositions",_poses];

if !(_quiet) then {
	"Step 3/11 - Saving civilians" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};

private _civs = (allVariables OT_civilians select _prefixFilter) apply {
	[_x,OT_civilians getVariable _x]
};
_data pushback ["civilians",_civs];

if !(_quiet) then {
	"Step 4/11 - Saving player data" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};

//get all online player data
{
	[_x] call OT_fnc_savePlayerData;
}foreach([] call CBA_fnc_players);

private _players = (allVariables players_NS) apply {
	[_x, players_NS getVariable _x];
};
_data pushBack ["players",_players];

private _cfgVeh = configFile >> "CfgVehicles";
private _tocheck = ((allMissionObjects "Static") + vehicles) select {
	(alive _x)
	&& {(typeof _x != OT_flag_IND)}
	&& {!(typeOf _x isKindOf ["Man", _cfgVeh])}
	&& {(_x call OT_fnc_hasOwner) or (_x getVariable ["OT_forceSaveUnowned", false])}
	&& {(_x getVariable["OT_garrison",false]) isEqualTo false}
};

private _tosave = count _tocheck;
if !(_quiet) then {
	format["Step 5/11 - Saving vehicles (%1 to save)",_tosave] remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};

private _count = 0;
private _saved = 0;
private _vehicles = (_tocheck) apply {
	_saved = _saved + 1;
	_count = _count + 1;
	if(!_quiet && {_count % 200 == 0}) then {
		format["Step 5/11 - Saving vehicles (%1 to save)",_tosave - _saved] remoteExecCall ["OT_fnc_notifyAndLog",0,false];
	};

	private _s = _x call OT_fnc_unitStock;
	private _type = typeOf _x;

	if(_type == OT_item_safe) then {
		_s pushback ["money",_x getVariable ["money",0]];
		_s pushback ["password",_x getVariable ["password",""]];
	};
	private _simCheck = if (dynamicSimulationEnabled _x) then {
		true
	}else{
		if (simulationEnabled _x) then {
			true
		}else{
			false
		};
	};
	private _params = [
/* 0 */		_type,
/* 1 */		[getPosWorld _x,_simCheck, 1],		// 1 stands for the new posWorld format
/* 2 */		[vectorDir _x,vectorUp _x],
/* 3 */		_s,
/* 4 */		["", _x call OT_fnc_getOwner] select (_x call OT_fnc_hasOwner),		// Save an empty string if the object doesn't have an owner (yet)
/* 5 */		_x getVariable ["name",""],
/* 6 */		_x getVariable ["OT_init",""]
	];

	if ((_type isKindOf ["AllVehicles", _cfgVeh] && !(_x getVariable ["OT_garrison",false])) or {_type isEqualTo OT_item_Storage}) then {
		private _veh = _x;
		private _ammo = (_x weaponsTurret [0]) apply {
			[_x,_veh ammo _x];
		};
		private _attachedClass = _veh getVariable ["OT_attachedClass",""];
		private _attached = _veh getVariable ["OT_attachedWeapon",objNull];
		private _att = [];

		//get attached ammo (if applicable)
		if(!(_attachedClass isEqualTo "") && { alive _attached }) then {
			_att = [_attachedClass,(_attached weaponsTurret [0]) apply { [_x,_attached ammo _x] }];
		};
/* 7 */		_params set [7, [fuel _x,getAllHitPointsDamage _x,_x call ace_refuel_fnc_getFuel,_x getVariable ["OT_locked",false],_ammo,_att]];
	};

	// If the house is player-built, save some extra variables
	if (_x getVariable ["OT_house_isPlayerBuilt", false]) then {
/* 8 */		_params set [8, [_x getVariable ["OT_house_isLeased", false]]];
	};
	_params
};
_data pushback ["vehicles",_vehicles];

if !(_quiet) then {
	"Step 6/11 - Saving warehouse" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};

private _warehouse = [2]; //First element is save version
_warehouse append ((allVariables warehouse) select {((toLower _x select [0,5]) isEqualTo "item_")} apply {
	warehouse getVariable _x
});
_data pushback ["warehouse",_warehouse];

if !(_quiet) then {
	"Step 7/11 - Saving recruits" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};

private _recruits = ((server getVariable ["recruits",[]]) select {
	!((_x select 2) isEqualType objNull)
	|| { alive (_x select 2) }
}) apply {
	private _d = _x select [0,7];
	if(count _x == 6) then { _d pushBack 0 };

	_x params ["","","_unitOrPos"];
	if(_unitOrPos isEqualType objNull) then {
		_d set [4,getUnitLoadout _unitOrPos];
		_d set [2,getPosATL _unitOrPos];
		_d set [6,_unitOrPos getVariable ["OT_xp",0]];
	};

	_d
};
_data pushback ["recruits",_recruits];

if !(_quiet) then {
	"Step 8/11 - Saving squads" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};

private _squads = ((server getVariable ["squads",[]]) select {
	_x params ["_owner","_cls","_group"];
	_group isEqualType grpNull
	&& { count units _group > 0 }
	&& { ({alive _x} count units _group) > 0 }
}) apply {
	_x params ["_owner","_cls","_group"];
	_units = [];
	{
		if(alive _x) then {
			_units pushback [typeof _x,position _x,getUnitLoadout _x];
		};
	}foreach(units _group);
	[_owner,_cls,"Not a group, pls recreate",_units,groupId _group]
};
_data pushback ["squads",_squads];

if !(_quiet) then {
	"Step 9/11 - Saving bases" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};

private _getGroupSoldiers = {
	(units _this select {
		private _veh = vehicle _x;
		alive _x && { _veh isEqualTo _x || {(someAmmo _veh && toLower typeOf _veh in ["i_hmg_01_high_f","i_gmg_01_high_f"])} }
	}) apply {
		if(vehicle _x isEqualTo _x) then {
			[typeof _x,getUnitLoadout _x];
		}else{
			if(typeof vehicle _x == "I_HMG_01_high_F") then {["HMG",[]]} else {["GMG",[]]};
		};
	};
};

{
	_x params ["_pos"];
	private _code = format["fob%1",_pos];
	private _group = spawner getvariable [format["resgarrison%1",_code],grpNull];
	if !(isNull _group) then {
		private _soldiers = _group call _getGroupSoldiers;
		if(count _soldiers > 0) then {
			_server pushback [format["resgarrison%1",_code],_soldiers];
		};
	};
}foreach(server getVariable ["bases",[]]);

if !(_quiet) then {
	"Step 10/11 - Saving garrisons" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};

{
	_pos = _x select 0;
	_code = _x select 1;
	private _group = spawner getvariable [format["resgarrison%1",_code],grpNull];
	if !(isNull _group) then {
		private _soldiers = _group call _getGroupSoldiers;
		if(count _soldiers > 0) then {
			_server pushback [format["resgarrison%1",_code],_soldiers];
		};
	};
}foreach(OT_objectiveData + OT_airportData);

_data pushBack ["server",_server];
_data pushback ["timedate",date];
_data pushback ["autosave",[OT_autoSave_time,OT_autoSave_last_time]];
_data pushBack ["recruitables",OT_Recruitables];
_data pushBack ["policeLoadout",OT_Loadout_Police];

if !(_quiet) then {
	"Step 11/11 - Exporting" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};

profileNameSpace setVariable [OT_saveName,_data];
if (isDedicated) then {
	if !(_quiet) then {
		"Saving to dedicated server.. not long now" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
	};
	saveProfileNamespace;
};

if !(_quiet) then {
	"Persistent Save Completed" remoteExecCall ["OT_fnc_notifyAndLog",0,false];
};

if (!_autoSave && !(_user isEqualTo objNull)) then {
	[_data] remoteExec ["OT_fnc_uploadData",_user,false];
};

missionNameSpace setVariable ["OT_saving",false,true];
