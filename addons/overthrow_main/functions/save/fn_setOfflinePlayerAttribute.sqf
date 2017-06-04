params ["_uid","_attr","_value"];
private _params = server getVariable [_uid,[]];
private _done = false;
{
    _x params ["_k","_v"];
    if(_k == _attr) exitWith {_done=true;_x set [1,_value]};
}foreach(_params);
if(!_done) then {
    _params pushback [_attr,_value];
};
server setVariable [_uid,_params,true];
