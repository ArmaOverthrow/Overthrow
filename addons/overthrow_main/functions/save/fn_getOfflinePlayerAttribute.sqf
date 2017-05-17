params ["_uid","_attr"];
private _val = "";
if(count _this > 2) then {
    _val = _this select 2;
};
{
    _x params ["_k","_v"];
    if(_k == _attr) exitWith {_val=_v};
}foreach(server getVariable [_uid,[]]);
_val;
