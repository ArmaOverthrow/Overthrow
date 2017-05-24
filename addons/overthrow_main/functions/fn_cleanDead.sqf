{
    {
        if !(alive _x) then {
            deleteVehicle _x;
        };
    }foreach(crew _x);
    if !(alive _x or _x call OT_fnc_vehicleCanMove) then {deletevehicle _x};    
} foreach(vehicles);
{
    deleteVehicle _x;
} foreach(alldeadmen);
