_vehicle = _this select 0;
waitUntil {sleep 1;(resistance knowsabout _vehicle) < 1};
{
	if !(_x call hasOwner) then {
		deleteVehicle _x;
	};
}foreach(units _vehicle);
if !(_vehicle call hasOwner) then {
	deleteVehicle _vehicle;
};