params ["_unit","_loadout",["_charge",true]];

removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeGoggles _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeVest _unit;

_unit setUnitLoadout _loadout;

private _missing = _unit call OT_fnc_verifyLoadoutFromWarehouse;

if(_charge) then {
    private _cost = 0;
    {
        _cost = _cost + [OT_nation,_x,[OT_nation] call OT_fnc_support] call OT_fnc_getPrice;
    }foreach(_missing);
    [-_cost] call OT_fnc_money;
};
