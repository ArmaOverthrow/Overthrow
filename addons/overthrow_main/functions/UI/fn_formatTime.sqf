private _hr = date select 3;
private _min = date select 4;

if(_hr < 10) then {
    _hr = format["0%1",_hr];
};
if(_min < 10) then {
    _min = format["0%1",_min];
};
format["%1:%2",_hr,_min];
