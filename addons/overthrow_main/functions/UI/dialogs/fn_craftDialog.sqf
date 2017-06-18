closedialog 0;
createDialog "OT_dialog_craft";

{
    _x params ["_cls","_recipe","_qty"];
    _idx = 0;
    if(_cls isKindOf ["Default", configFile >> "CfgMagazines"]) then {
        _idx = lbAdd [1500,format["%1 x %2",_qty,_cls call OT_fnc_magazineGetName]];
    }else{
        _idx = lbAdd [1500,format["%1 x %2",_qty,_cls call OT_fnc_weaponGetName]];
    };
    lbSetData [1500,_idx,format["%1-%2",_cls,_qty]];
}foreach(OT_craftableItems);
