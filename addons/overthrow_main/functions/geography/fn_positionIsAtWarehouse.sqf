private _iswarehouse = false;
private _b = _this call OT_fnc_nearestRealEstate;
if(_b isEqualType []) then {
    private _building = _b select 0;
    if((_this distance _building) < 15 && (typeof _building) == OT_warehouse && (_building call OT_fnc_hasOwner) && (damage _building) < 1) then {
        _iswarehouse = true;
    };
};
_iswarehouse
