private ["_playerstock","_town","_standing"];

_playerstock = _this select 0;
_town = _this select 1;
_standing = _this select 2;

private _cursel = lbCurSel 1500;
lbClear 1500;
private _numitems = 0;
{
	_cls = _x select 0;
	_num = _x select 1;
	_price = [_town,_cls,_standing] call OT_fnc_getSellPrice;

	_name = "";
	_pic = "";
	_cansell = true;
	if(_cls isKindOf ["None",configFile >> "CfgGlasses"]) then {
		_name = _cls call OT_fnc_glassesGetName;
		_pic = _cls call OT_fnc_glassesGetPic;
	};
	if(_cls isKindOf ["Default",configFile >> "CfgWeapons"]) then {
		_name = _cls call OT_fnc_weaponGetName;
		_pic = _cls call OT_fnc_weaponGetPic;
	};
	if(_cls isKindOf ["Default",configFile >> "CfgMagazines"]) then {
		_name = _cls call OT_fnc_magazineGetName;
		_pic = _cls call OT_fnc_magazineGetPic;
	};
	if(_cls isKindOf "Bag_Base") then {
		_cansell = false;
	};
	if(_cls in OT_allClothing) then {
		_cansell = false;
	};
	if(_cansell) then {
		_idx = lbAdd [1500,format["%1 x %2 ($%3)",_num,_name,_price]];
		lbSetPicture [1500,_idx,_pic];
		lbSetValue [1500,_idx,_price];
		lbSetData [1500,_idx,_cls];
		_numitems = _numitems + 1;
	};
}foreach(_playerstock);
if(_cursel >= _numitems) then {_cursel = 0};
lbSetCurSel [1500, _cursel];
