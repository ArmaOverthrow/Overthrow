params ["_unit","_gangid","_rep"];
if !(isPlayer _unit) then {
    _unit = _unit call OT_fnc_getOwnerUnit;
};
if(isNull _unit) exitWith {};

private _gang = OT_civilians getVariable [format["gang%1",_gangid],[]];
if(count _gang > 0) then {
    private _totalrep = (_unit getVariable [format["gangrep%1",_gangid],0])+_rep;
    _unit setVariable [format["gangrep%1",_gangid],_totalrep,true];

    private _plusmin = "";
    if(_rep > 0) then {
        _plusmin = "+";
    };
    if(_rep != 0) then {
        private _name = _gang select 8;
        format["%3: %1%2 Rep",_plusmin,_rep,_name] call OT_fnc_notifyMinor;
    };
};
