private _shortest = 99999;
private _town = "";
{
    private _dis = (_x select 0) distance _this;
    if (_dis < _shortest) then {
        _shortest = _dis;
        _town = _x select 1;
    };
}forEach(OT_townData);
_town