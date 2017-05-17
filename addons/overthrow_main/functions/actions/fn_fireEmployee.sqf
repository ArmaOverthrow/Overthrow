private _idx = lbCurSel 1501;
private _name = lbData [1501,_idx];
private _rate = server getVariable [format["%1employ",_name],0];
_rate = _rate - 1;
if(_rate < 0) then {_rate = 0};
server setVariable [format["%1employ",_name],_rate,true];
_name remoteExec ["OT_fnc_refreshEmployees",2,false];
[] call OT_fnc_showBusinessInfo;
