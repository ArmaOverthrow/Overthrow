private ["_data","_done"];

if(AIT_saving) exitWith {"Please wait, save still in progress" remoteExec ["hint",bigboss,true]};
AIT_saving = true;
publicVariable "AIT_saving";

"Persistent Saving..." remoteExec ["notify_minor",0,true];
sleep 0.1;
waitUntil {!isNil "AIT_NATOInitDone"};

_data = [];
//get all server data
{
	if !(_x == "StartupType" or _x == "recruits") then {
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
		if(_x != "owner" and _x != "morale" and _x != "player_uid" and _x != "sa_tow_actions_loaded" and _x != "hiding" and _x != "randomValue" and _x != "saved3deninventory" and (_x select [0,4]) != "ace_" and (_x select [0,4]) != "cba_" and (_x select [0,4]) != "bis_") then {
			_all pushback _x;
			_val = _me getVariable _x;
			if !(isNil "_val") then {
				if(typename _val != "CODE") then {
					if(_x == "owned") then {
						_owned = [];
						{
							_owned pushback (getpos _x);
						}foreach(_val);
						_val = _owned;
					};
					
					if(_x == "home" or _x == "camp") then {
						_val = getpos _val;
					};					
					_d pushback [_x,_val];											
				};
			};
		};
	}foreach(allVariables _me);
	_data pushback [_uid,_d];
}foreach(allPlayers);

_vehicles = [];

_count = 10001;
{
	if(!(_x isKindOf "Man") and (alive _x) and (_x call hasOwner) and (typeof _x != AIT_item_Flag)) then {
		_owner = _x getVariable ["owner",false];		
		_vehicles pushback [typeof _x,getpos _x,getdir _x,_x call unitStock,_owner,_x getVariable ["name",""]];	
		_done pushback _x;
	};
	if(_count > 5000) then {
		"Still persistent Saving... please wait" remoteExec ["notify_minor",0,true];
		_count = 0;
		sleep 0.1;
	};
	_count = _count + 1;
}foreach((allMissionObjects "Building") + vehicles);

sleep 0.2;
_data pushback ["vehicles",_vehicles];

_recruits = [];
{
	_do = true;
	_unitorpos = _x select 2;
	if(typename _unitorpos == "OBJECT") then {		
		if(alive _unitorpos) then {
			_p = getpos _unitorpos;
			_x set [4,getUnitLoadout _unitorpos];
			_x set [2,[_p select 0,_p select 1,_p select 2]];
		}else{
			_do = false;
		};
	};
	if(_do) then {		
		_recruits pushback _x;
	};
}foreach(server getVariable ["recruits",[]]);
_data pushback ["recruits",_recruits];

profileNameSpace setVariable ["Overthrow.save.001",_data];
if (isDedicated) then {saveProfileNamespace};

"Persistent Save Completed" remoteExec ["notify_minor",0,true];

AIT_saving = false;
publicVariable "AIT_saving";
