params ["_f","_t"];
private _por = "";
private _region = "";
if((typename _f) isEqualTo "ARRAY") then {
    _por = _f call OT_fnc_getRegion;
}else{
    _por = _f;
};
if((typename _t) isEqualTo "ARRAY") then {
    _region = _t call OT_fnc_getRegion;
}else{
    _region = _t;
};
if(_por isEqualTo _region) exitWith {true};
private _ret = false;
{
    if(((_x select 0) == _por) && ((_x select 1) == _region)) exitWith {_ret = true};
}foreach(OT_connectedRegions);
_ret;
