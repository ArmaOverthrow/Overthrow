params ["_ctrl","_index"];

disableSerialization;

private _id = _ctrl lbData _index;
_s = _id splitString "-";
_s params ["_cls","_qty"];
_qty = parseNumber _qty;
_def = [];
{
    _x params ["_c","_r","_q"];
    if(_cls == _c and _q == _qty) exitWith {_def = _x};
}foreach(OT_craftableItems);

if(count _def > 0) then {
    _def params ["_cls","_recipe","_qty"];

    _textctrl = (findDisplay 8000) displayCtrl 1100;

    _recipeText = "";
    {
        _x params ["_rcls","_rqty"];
        _name = "";
        call {
            if(_rcls == "Uniform_Base") exitWith {
                _name = "Clothing";
            };
            _name = _rcls call OT_fnc_weaponGetName;
        };
        _recipeText = _recipeText + format["%1 x %2<br/>",_rqty,_name];
    }foreach(_recipe);

    _desc = getText(configFile >> "CfgWeapons" >> _cls >> "descriptionShort");

    _textctrl ctrlSetStructuredText parseText format["
    	<t align='center' size='1.1'>%1 x %2</t><br/>
        <t align='center' size='0.7'>%3</t><br/><br/>
        <t align='center' size='0.8'>Recipe:</t><br/>
        <t align='center' size='0.7'>%4</t><br/>
    ",_qty,_cls call OT_fnc_weaponGetName,_desc,_recipeText];

    _pic = _cls call OT_fnc_weaponGetPic;
    if !(isNil "_pic") then {
    	ctrlSetText [1200,_pic];
    };
};
