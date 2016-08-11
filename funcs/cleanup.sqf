_vehicle = _this select 0;

{
	deleteVehicle _x;
}foreach(units _vehicle);

deleteVehicle _vehicle;