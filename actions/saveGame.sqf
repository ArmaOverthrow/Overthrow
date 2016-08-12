private ["_data"];

if(AIT_saving) exitWith {hint "Please wait, save still in progress"};
AIT_saving = true;
publicVariable "AIT_saving";
_data = [];
//get all server data
{
	_data pushback [_x,server getVariable _x];
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
					
					if(_x == "home") then {
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

{
	if(alive _x and (_x call hasOwner)) then {
		_owner = _x getVariable ["owner",false];		
		_vehicles pushback [typeof _x,getpos _x,getdir _x,_x call unitStock,_owner];	
	};
}foreach(vehicles);
_data pushback ["vehicles",_vehicles];

profileNameSpace setVariable ["Overthrow.save.001",_data];
if (isDedicated) then {saveProfileNamespace};

"Persistent Save Done" remoteExec ["notify_minor",0,true];

AIT_saving = false;
publicVariable "AIT_saving";
