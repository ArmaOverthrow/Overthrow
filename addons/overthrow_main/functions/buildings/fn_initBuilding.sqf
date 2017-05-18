private _veh = _this select 0;
private _pos = _this select 1;
private _fnc = _this select 2;
if((_fnc select [0,6]) != "OT_fnc") then {
    private _code = compileFinal preProcessFileLineNumbers _fnc;
    [_pos,_veh] spawn _code;
}else{
    [_pos,_veh] spawn (missionNamespace getVariable _fnc);
};
