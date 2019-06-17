//returns number of minutes since Jan 1 00:00 (in game local time)

private _daysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31];
date params ["","_month","_day","_hr","_min"];
private _stamp = 0;
//add up completed months
{
    if(_forEachIndex isEqualTo (_month - 1)) exitWith {};
    _stamp = _stamp + ((_daysInMonth select _forEachIndex) * 1440);
}foreach(_daysInMonth);

//add up completed days in month
_stamp = _stamp + ((_day - 1) * 1440);

//add up completed hours
_stamp = _stamp + (_hr * 60);

//return with completed minutes
_stamp + _min
