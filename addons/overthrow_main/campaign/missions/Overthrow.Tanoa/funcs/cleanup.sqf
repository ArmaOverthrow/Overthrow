_vehicle = _this select 0;
waitUntil {sleep 1;(resistance knowsabout _vehicle) < 1.4};
{
	if !(_x call hasOwner) then {
		deleteVehicle _x;
	};
}foreach(units _vehicle);
if(vehicle _vehicle == _vehicle) exitWith{};
if !(_vehicle call hasOwner) then {
	deleteVehicle _vehicle;
};