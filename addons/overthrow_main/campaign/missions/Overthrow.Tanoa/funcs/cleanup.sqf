_vehicle = _this select 0;
waitUntil {sleep 1;!((getpos _vehicle) call inSpawnDistance)};
{
	if !(_x call hasOwner) then {
		deleteVehicle _x;
	};
}foreach(units _vehicle);
if !(_vehicle call hasOwner) then {
	deleteVehicle _vehicle;
};