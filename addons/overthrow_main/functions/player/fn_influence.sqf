if!(hasInterface) exitWith {};
private _totalrep = (player getVariable ["influence",0])+_this;
player setVariable ["influence",_totalrep,true];
private _plusmin = "";
if(_this > 0) then {
    _plusmin = "+";
};
if(_this != 0) then {
    format["%1%2 Influence",_plusmin,_this] call OT_fnc_notifyMinor;
};
