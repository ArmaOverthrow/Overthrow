params ["_uid","_attr",["_val",""]];
{
    _x params ["_k","_v"];
    if(_k isEqualTo _attr) exitWith {_val=_v};
}foreach(players_NS getVariable [_uid,[]]);
_val;
