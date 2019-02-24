private _idx = lbCurSel 1500;
private _cls = lbData [1500,_idx];
_cost = cost getVariable[_cls,[]];
private _blueprints = server getVariable ["GEURblueprints",[]];
if((count _cost) > 0 && !(_cls in _blueprints)) then {
    _blueprints pushBack _cls;
    server setVariable ["GEURblueprints",_blueprints,true];
    closeDialog 0;
    "Item is now available for production" call OT_fnc_notifyMinor;

    if(!(_cls isKindOf "Bag_Base") && _cls isKindOf "AllVehicles") then {
        private _veh = OT_factoryPos nearestObject _cls;
        deleteVehicle _veh;
    }else{
        player removeItem _cls;
    };
}else{
    "Cannot reverse-engineer this item, please contact Overthrow Devs on Discord" call OT_fnc_notifyMinor;
};
