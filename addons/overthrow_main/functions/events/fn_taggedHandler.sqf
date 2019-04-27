params ["_tag","_texture","_object","_unit"];

if(_unit call OT_fnc_unitSeenNATO) then {
    _unit setCaptive false;
};

private _town = (getpos _object) call OT_fnc_nearestTown;
if !(_town in (server getVariable ["NATOabandoned",[]])) then {
    [_town,-2] call OT_fnc_stability;    
};
