if(OT_saving) exitWith {"Please wait, save still in progress" remoteExec ["hint",bigboss,false]};
OT_saving = true;
publicVariable "OT_saving";

"Persistent Saving..." remoteExec ["notify_long",0,true];
sleep 0.1;
waitUntil {!isNil "OT_NATOInitDone"};

private _data = [];
//get all server data
{
	if !(_x == "StartupType" or _x == "recruits" or _x == "squads") then {
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

//get all online player data
{
	_uid = getPlayerUID _x;
	_me = _x;
	_val = "";
	_d = [];
	_all = [];
	{
		if(_x != "ot_loaded" and _x != "owner" and _x != "morale" and _x != "player_uid" and _x != "sa_tow_actions_loaded" and _x != "hiding" and _x != "randomValue" and _x != "saved3deninventory" and (_x select [0,11]) != "MissionData" and (_x select [0,4]) != "ace_" and (_x select [0,4]) != "cba_" and (_x select [0,4]) != "bis_") then {
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
	if(!(_x isKindOf "Man") and (alive _x) and (_x call OT_fnc_hasOwner) and (typeof _x != OT_item_Flag)) then {
		_owner = _x getVariable ["owner",false];
		_s = _x call OT_fnc_unitStock;
		if(typeof _x == OT_item_safe) then {
			_s pushback ["money",_x getVariable ["money",0]];
			_s pushback ["password",_x getVariable ["password",""]];
		};
		_params = [typeof _x,getposatl _x,[vectorDir _x,vectorUp _x],_s,_owner,_x getVariable ["name",""],_x getVariable ["OT_init",""]];
		if(_x isKindOf "AllVehicles") then {
			_params pushback [fuel _x,getAllHitPointsDamage _x,_x call ace_refuel_fnc_getFuel];
		};
		_vehicles pushback _params;
	};
	if(_count > 2000) then {
		"Still persistent Saving... please wait" remoteExec ["notify_long",0,true];
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
			_squads pushback [getplayeruid player,_cls,"",_units];
		};
	};
}foreach(server getVariable ["squads",[]]);

_data pushback ["squads",_squads];

_data pushback ["timedate",date];

{
	_data pushback [format["loadout%1",getplayeruid _x],getUnitLoadout _x];
}foreach([] call CBA_fnc_players);

profileNameSpace setVariable ["Overthrow.save.001",_data];
if (isDedicated) then {
	"Saving to dedicated server.. not long now" remoteExec ["notify_long",0,true];
	sleep 0.01;
	saveProfileNamespace
};

"Persistent Save Completed" remoteExec ["notify_minor",0,true];

OT_saving = false;
publicVariable "OT_saving";
