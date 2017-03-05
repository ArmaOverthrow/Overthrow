private _idx = lbCurSel 1500;
private _cls = lbData [1500,_idx];

server setVariable ["GEURproducing",_cls];
[] call OT_fnc_factoryRefresh;
