private _index = lbCurSel 1500;
private _id = lbData [1500,_index];
_s = _id splitString "-";
_s params ["_cls","_qty"];
_qty = parseNumber _qty;
_def = [];
{
    _x params ["_c","_r","_q"];
    if(_cls == _c && _q isEqualTo _qty) exitWith {_def = _x};
}foreach(OT_craftableItems);

if(count _def > 0) then {
    private _err = false;
    _def params ["_cls","_recipe","_qty"];

    _container = getpos player nearestObject OT_item_Storage;
    if !(isNull _container) then {
        if(_container distance player > 20) exitWith {"You need to be within 20m of an ammobox to craft" call OT_fnc_notifyMinor};
        _stock = _container call OT_fnc_unitStock;

        _itemName = "";
        if(_cls isKindOf ["Default", configFile >> "CfgMagazines"]) then {
            _itemName = _cls call OT_fnc_magazineGetName;
        }else{
            _itemName = _cls call OT_fnc_weaponGetName;
        };

        {
            _x params ["_needed","_qtyneeded"];
            _good = false;
            {
                _x params ["_c","_amt"];
                if(_c isEqualTo _needed) exitWith {
                    if(_amt >= _qtyneeded) then {
                        _good = true;
                    };
                };
                if(_c isKindOf [_needed,configFile >> "CfgMagazines"]) exitWith {
                    if(_amt >= _qtyneeded) then {
                        _good = true;
                    };
                };
                if(_c isKindOf [_needed,configFile >> "CfgWeapons"]) exitWith {
                    if(_amt >= _qtyneeded) then {
                        _good = true;
                    };
                };
            }foreach(_stock);

            if !(_good) exitWith {_err = true;"Required ingredients not in closest ammobox" call OT_fnc_notifyMinor};
        }foreach(_recipe);

        if !(_err) then {
            {
                _x params ["_needed","_qtyneeded"];
                {
                    _x params ["_c","_amt"];
                    if(_c isKindOf [_needed,configFile >> "CfgMagazines"]) exitWith {
                        [_container, _c, _qtyneeded] call CBA_fnc_removeMagazineCargo;
                    };
                    if(_c isKindOf [_needed,configFile >> "CfgWeapons"]) exitWith {
                        [_container, _c, _qtyneeded] call CBA_fnc_removeItemCargo;
                    };
                }foreach(_stock);
            }foreach(_recipe);

            _container addItemCargoGlobal [_cls, _qty];

            playSound "3DEN_notificationDefault";
            format["%1 x %2 added to closest ammobox",_qty,_itemName] call OT_fnc_notifyMinor;
        };
    };
};
