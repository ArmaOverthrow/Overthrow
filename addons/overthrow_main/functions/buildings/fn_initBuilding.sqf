private _veh = _this select 0;
private _pos = _this select 1;
private _fnc = _this select 2;
if((_fnc select [0,6]) != "OT_fnc") then {
    //Legacy building Init

    private _code = {};
    if((_fnc find "policeStation") > -1) then {
        _code = OT_fnc_initPoliceStation;
    };
    if((_fnc find "trainingCamp") > -1) then {
        _code = OT_fnc_initTrainingCamp;
    };
    if((_fnc find "warehouse") > -1) then {
        _code = OT_fnc_initWarehouse;
    };
    if((_fnc find "workshop") > -1) then {
        _code = OT_fnc_initWorkshop;
    };
    [_pos,_veh] spawn _code;
}else{
    [_pos,_veh] spawn (missionNamespace getVariable _fnc);
};
