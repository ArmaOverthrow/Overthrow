params ["_i","_s","_e","_c","_p"];
private _groups = spawner getVariable [_i,[]];
spawner setVariable [_i,[],false];
{
    if(typename _x isEqualTo "GROUP") then {
        {
            if !(_x call OT_fnc_hasOwner) then {
                _x remoteExecCall ["deleteVehicle",_x];
                sleep 0.3;
            };
        }foreach(units _x);
        deleteGroup _x;
    }else{
        if !(_x call OT_fnc_hasOwner) then {
            _x remoteExecCall ["deleteVehicle",_x];
        };
    };
    sleep 0.3;
}foreach(_groups);
