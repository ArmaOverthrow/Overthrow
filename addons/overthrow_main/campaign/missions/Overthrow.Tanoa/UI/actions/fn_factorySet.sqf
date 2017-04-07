private _idx = lbCurSel 1500;
private _cls = lbData [1500,_idx];

private _currentCls = server getVariable ["GEURproducing",""];

if(_currentCls != _cls) then {
    server setVariable ["GEURproducing",_cls,true];
    server setVariable ["GEURproducetime",0,true];
};
[] call OT_fnc_factoryRefresh;
