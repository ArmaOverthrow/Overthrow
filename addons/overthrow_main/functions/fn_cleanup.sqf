params ["_vehicle"];

if(typename _vehicle == "GROUP") exitWith {
	waitUntil {sleep 5;!(_vehicle call OT_fnc_inSpawnDistance) and ((resistance knowsabout leader _vehicle) < 1.4)};
	{
		if !(_x call OT_fnc_hasOwner) then {
			deleteVehicle _x;
		};
	}foreach(units _vehicle);
	deleteGroup _vehicle;
};

if(_vehicle getVariable ["OT_cleanup",false]) exitWith {};

_vehicle setVariable ["OT_cleanup",true,false];
waitUntil {sleep 5;!(_vehicle call OT_fnc_inSpawnDistance) and ((resistance knowsabout _vehicle) < 1.4)};

if(_vehicle isKindOf "CAManBase") then {
	if(vehicle _vehicle != _vehicle) then {[(vehicle _vehicle)] spawn OT_fnc_cleanup};
}else{
	{
		if !(_x call OT_fnc_hasOwner) then {
			deleteVehicle _x;
		};
	}foreach(units _vehicle);
};
if !(_vehicle call OT_fnc_hasOwner) then {
	deleteVehicle _vehicle;
};
