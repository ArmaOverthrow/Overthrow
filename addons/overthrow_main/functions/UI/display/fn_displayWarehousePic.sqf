params ["_ctrl","_index"];

disableSerialization;

_cls = _ctrl lbData _index;
_price = [_ctrl lbValue _index, 1, 0, true] call CBA_fnc_formatNumber;

_pic = "";
_txt = "";
_desc = "";

if(_cls isKindOf ["Default",configFile >> "CfgMagazines"]) then {
	_txt = _cls call OT_fnc_magazineGetName;
	_pic = _cls call OT_fnc_magazineGetPic;
	_desc = _cls call OT_fnc_magazineGetDescription;
};
if(_cls isKindOf "All") then {
	_txt = _cls call OT_fnc_vehicleGetName;
	_pic = getText(configFile >> "cfgVehicles" >> _cls >> "editorPreview");
	_desc = getText(configFile >> "cfgVehicles" >> _cls >> "Library" >> "libTextDesc");
};
if(isClass (configFile >> "CfgGlasses" >> _cls)) then {
	_txt = gettext(configFile >> "CfgGlasses" >> _cls >> "displayName");
	_pic = gettext(configFile >> "CfgGlasses" >> _cls >> "picture");
};
if(_cls isKindOf "Bag_Base") then {
	_txt = _cls call OT_fnc_vehicleGetName;
	_pic = _cls call OT_fnc_vehicleGetPic;
	_desc = _cls call OT_fnc_vehicleGetDescription;
};
if(_cls isKindOf ["Default",configFile >> "CfgWeapons"]) then {
	_txt = _cls call OT_fnc_weaponGetName;
	_pic = _cls call OT_fnc_weaponGetPic;
	_desc = format["%1<br/>%2",getText(configFile >> "CfgWeapons" >> _cls >> "descriptionShort"),_cls call OT_fnc_magazineGetDescription];
};
if !(isNil "_pic") then {
	ctrlSetText [1200,_pic];
};

_textctrl = (findDisplay 8000) displayCtrl 1100;

_textctrl ctrlSetStructuredText parseText format["
	<t align='center' size='1.5'>%1</t><br/>
	<t align='center' size='1.2'>%3 in stock</t><br/><br/>
	<t align='center' size='0.8'>%2</t>
",_txt,_desc,_price];
