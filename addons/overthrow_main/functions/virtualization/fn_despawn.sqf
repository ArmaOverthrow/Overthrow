params ["_i","_s","_e","_c","_p"];

{
    if(typename _x == "GROUP") then {
        {
            if !(_x call OT_fnc_hasOwner) then {
                deleteVehicle _x;
            };
        }foreach(units _x);
        deleteGroup _x;
    }else{
        if !(_x call OT_fnc_hasOwner) then {
            deleteVehicle _x;
        };
    };
}foreach(spawner getVariable [_i,[]]);
spawner setVariable [_i,[],false];
