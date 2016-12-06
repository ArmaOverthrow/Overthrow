_vehicle = _this select 0;
waitUntil {sleep 1;(resistance knowsabout _vehicle) < 1.4};
{
	if !(_x call OT_fnc_hasOwner) then {
		deleteVehicle _x;
	};
}foreach(units _vehicle);

if !(_vehicle call OT_fnc_hasOwner) then {
	deleteVehicle _vehicle;
};
