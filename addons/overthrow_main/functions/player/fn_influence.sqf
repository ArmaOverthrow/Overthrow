if!(hasInterface) exitWith {};
_totalrep = (player getVariable ["influence",0])+_this;
player setVariable ["influence",_totalrep,true];
_plusmin = "";
if(_this > 0) then {
    _plusmin = "+";
};
if(_this != 0) then {
    format["%1%2 Influence",_plusmin,_this] call OT_fnc_notifyMinor;
};
