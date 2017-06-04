private _pars = _this;
{
    _p = _x select 1;
    if(_p isEqualTo _pars) exitWith {
        _id = _x select 0;
        OT_allSpawned deleteAt (OT_allSpawned find _id);
    };
}foreach(OT_allSpawners);
