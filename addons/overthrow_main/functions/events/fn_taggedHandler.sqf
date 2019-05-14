params ["_tag","_texture","_object","_unit"];

if(_unit call OT_fnc_unitSeenNATO) then {
    _unit setCaptive false;
    _unit call OT_fnc_revealToNATO;
};
private _town = (getpos _object) call OT_fnc_nearestTown;
private _numtags = (server getVariable [format["tagsin%1",_town],0]);

if !(_town in (server getVariable ["NATOabandoned",[]]) || _numtags > 9) then {
    [_town,-2] call OT_fnc_stability;
    [_town,1] call OT_fnc_support;
};

server setVariable [format["tagsin%1",_town],_numtags + 1,true];
