private _iswarehouse = false;
_b = (position player) call OT_fnc_nearestRealEstate;
if(typename _b == "ARRAY") then {
    _building = _b select 0;
    if((player distance _building) < 15 and (typeof _building) == OT_warehouse and (_building call OT_fnc_hasOwner) and (damage _building) < 1) then {
        _iswarehouse = true;
    };
};
_iswarehouse
