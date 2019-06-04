params ["_vehicle",["_force",false]];

if(_force) exitWith {
	{
		if !(_x call OT_fnc_hasOwner) then {
			deleteVehicle _x;
		};
	}foreach(crew _vehicle);
	if !(_vehicle call OT_fnc_hasOwner) then {
		deleteVehicle _vehicle;
	};
};

if(typename _vehicle isEqualTo "GROUP") exitWith {
	if(count (units _vehicle) isEqualTo 0) exitWith {deleteGroup _vehicle};
	private _l = (units _vehicle) select 0;
	[{!((_this#0) call OT_fnc_inSpawnDistance) || _force}, {
		_vehs = [];
		_this params ["_l","_vehicle"];
		{
			if(vehicle _x != _x) then {_vehs pushBackUnique (vehicle _x)};
			if !(_x call OT_fnc_hasOwner) then {
				deleteVehicle _x;
			};
		}foreach(units _vehicle);
		{
			deleteVehicle _x;
		}foreach(_vehs);
		deleteGroup _vehicle;
	}, [(units _vehicle) select 0,_vehicle]] call CBA_fnc_waitUntilAndExecute;
};

if(_vehicle getVariable ["OT_cleanup",false]) exitWith {};

_vehicle setVariable ["OT_cleanup",true,false];

if(OT_adminMode) then {
	diag_log format["Overthrow: cleanup called on %1",typeOf _vehicle];
};

[{!((_this select 0) call OT_fnc_inSpawnDistance)}, {
	_this params ["_vehicle"];
	if(_vehicle isKindOf "CAManBase") then {
		if(vehicle _vehicle != _vehicle) then {[(vehicle _vehicle)] call OT_fnc_cleanup};
	}else{
		{
			if !(_x call OT_fnc_hasOwner) then {
				deleteVehicle _x;
			};
		}foreach(crew _vehicle);
	};
	if !(_vehicle call OT_fnc_hasOwner) then {
		deleteVehicle _vehicle;
	};
}, [_vehicle]] call CBA_fnc_waitUntilAndExecute;
