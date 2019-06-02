private _ob = player call OT_fnc_nearestObjective;
_ob params ["_obpos","_obname"];

if (_obname in (server getVariable ["NATOabandoned",[]])) exitWith {};
if !(captive player) exitWith {hint "Cannot capture while wanted"};

private _resources = server getVariable ["NATOresources",2000];
private _countered = (server getVariable ["NATOattacking",""]) != "";

if (_countered) exitWith {hint "There is already a battle in progress or scheduled"};
private _popControl = call OT_fnc_getControlledPopulation;

private _cost = 350;
{
    _x params ["","_name","_pri"];
    if(_name isEqualTo _obname) exitWith {_cost = _pri};
}foreach(OT_objectiveData + OT_airportData);

private _m = 1;
if(_popControl > 1000) then {_m = 2};
if(_popControl > 2000) then {_m = 4};
_cost = _cost * _m;
server setVariable ["NATOattacking",_obname,true];
server setVariable ["NATOattackstart",time,true];
diag_log format["Overthrow: Manual trigger for QRF at %1",_obname];
if(_resources < _cost) then {_cost = _resources};
[_obname,_cost] remoteExec ["OT_fnc_NATOResponseObjective",2,false];
_obname setMarkerAlpha 1;
_resources = _resources - _cost;

server setVariable ["NATOresources",_resources,true];
