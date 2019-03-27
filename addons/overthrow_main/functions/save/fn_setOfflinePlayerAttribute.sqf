params ["_uid","_attr","_value"];
private _params = players_NS getVariable [_uid,[]];
private _done = false;
{
    _x params ["_k","_v"];
    if(_k isEqualTo _attr) exitWith {
        _done=true;
        _x set [1,_value];
    };
}foreach(_params);
if(!_done) then {
    _params pushback [_attr,_value];
};
players_NS setVariable [_uid,_params,true];
