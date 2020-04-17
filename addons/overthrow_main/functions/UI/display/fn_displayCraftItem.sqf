params ["_ctrl","_index"];

disableSerialization;

private _id = _ctrl lbData _index;
private _s = _id splitString "-";
_s params ["_cls","_qty"];
private _qty = parseNumber _qty;
private _def = [];
{
    _x params ["_c","_r","_q"];
    if(_cls == _c && _q == _qty) exitWith {_def = _x};
}foreach(OT_craftableItems);

if(count _def > 0) then {
    _def params ["_cls","_recipe","_qty"];

    private _textctrl = (findDisplay 8000) displayCtrl 1100;
    private _itemName = "";

    private _recipeText = "";
    {
        _x params ["_rcls","_rqty"];
        _name = _rcls call {
            params ["_rcls"];
            if(_rcls isEqualTo "Uniform_Base") exitWith {"Clothing"};// allows hierarchy w/o display name to have display name in recipe menu
			if(_rcls isEqualTo "CA_LauncherMagazine") exitWith {"Rocket"};
			if(_rcls isEqualTo "HandGrenade") exitWith {"Grenade"};
            if(_rcls isKindOf ["Default", configFile >> "CfgMagazines"]) exitWith {_rcls call OT_fnc_magazineGetName};
            _rcls call OT_fnc_weaponGetName;
        };
        _recipeText = _recipeText + format["%1 x %2<br/>",_rqty,_name];
    }foreach(_recipe);
    private _desc = "";
    private _pic = "";

    if(_cls isKindOf ["Default", configFile >> "CfgMagazines"]) then {
        _desc = getText(configFile >> "CfgWeapons" >> _cls >> "descriptionShort");
        _itemName = _cls call OT_fnc_magazineGetName;
        _pic = _cls call OT_fnc_magazineGetPic;
    }else{
        _desc = getText(configFile >> "CfgMagazines" >> _cls >> "descriptionShort");
        _itemName = _cls call OT_fnc_weaponGetName;
        _pic = _cls call OT_fnc_weaponGetPic;
    };

    _textctrl ctrlSetStructuredText parseText format["
    	<t align='center' size='1.1'>%1 x %2</t><br/>
        <t align='center' size='0.7'>%3</t><br/><br/>
        <t align='center' size='0.8'>Recipe:</t><br/>
        <t align='center' size='0.7'>%4</t><br/>
    ",_qty,_itemName,_desc,_recipeText];

    if (!isNil "_pic" && {!(_pic isEqualTo "")}) then {
    	ctrlSetText [1200,_pic];
    };
};
