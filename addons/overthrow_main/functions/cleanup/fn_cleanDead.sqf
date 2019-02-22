{
    {
        if (!alive _x) then {
            deleteVehicle _x;
        };
    } foreach crew _x;
    if (!alive _x) then {
        deletevehicle _x;
    };
} foreach vehicles;
{
    deleteVehicle _x;
} foreach allDeadMen;
