params ["_vehicle"];

if(typename _vehicle == "GROUP") exitWith {
	if(count (units _vehicle) == 0) exitWith {deleteGroup _vehicle};
	private _l = (units _vehicle) select 0;
	_vehs = [];
	waitUntil {sleep 15;!(_l call OT_fnc_inSpawnDistance)};
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
};

if(_vehicle getVariable ["OT_cleanup",false]) exitWith {};

_vehicle setVariable ["OT_cleanup",true,false];
waitUntil {sleep 15;!(_vehicle call OT_fnc_inSpawnDistance)};

if(_vehicle isKindOf "CAManBase") then {
	if(vehicle _vehicle != _vehicle) then {[(vehicle _vehicle)] spawn OT_fnc_cleanup};
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
