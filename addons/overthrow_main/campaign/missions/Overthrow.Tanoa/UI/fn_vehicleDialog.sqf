
private _veh = vehicle player;

private _isgen = call OT_fnc_playerIsGeneral;

if((_veh getVariable ["owner",""]) != (getplayeruid player)) then {
    ctrlEnable [1605,false];
}else{
    if(_veh getVariable ["OT_locked",false]) then {
        ctrlSetText [1605,"Unlock Vehicle"];
    };
}
