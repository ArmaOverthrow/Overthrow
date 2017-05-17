private _p = _this;
private _region = "";
{
    if(_p inArea _x) exitWith {_region = _x};
}foreach(OT_regions);
_region;
