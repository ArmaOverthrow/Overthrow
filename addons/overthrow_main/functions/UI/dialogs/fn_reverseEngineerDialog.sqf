createDialog 'OT_dialog_reverse';

private _playerstock = player call OT_fnc_unitStock;
private _cursel = lbCurSel 1500;
lbClear 1500;
private _numitems = 0;
private _blueprints = server getVariable ["GEURblueprints",[]];
{
	_x params ["_cls"];
	if !((_cls in _blueprints) || (_cls in OT_allExplosives)) then {
		private _name = "";
		private _pic = "";
		if(_cls isKindOf ["Default",configFile >> "CfgWeapons"]) then {
			_name = _cls call OT_fnc_weaponGetName;
			_pic = _cls call OT_fnc_weaponGetPic;
		};
		if(_cls isKindOf ["Default",configFile >> "CfgMagazines"]) then {
			_name = _cls call OT_fnc_magazineGetName;
			_pic = _cls call OT_fnc_magazineGetPic;
		};
		if(_cls isKindOf "Bag_Base") then {
			_name = _cls call OT_fnc_vehicleGetName;
			_pic = _cls call OT_fnc_vehicleGetPic;
		};
		private _idx = lbAdd [1500,_name];
		lbSetPicture [1500,_idx,_pic];
		lbSetData [1500,_idx,_cls];
		_numitems = _numitems + 1;
	};
}foreach(_playerstock);

{
	if (!(_x isKindOf "Animal") && !(_x isKindOf "CaManBase") && alive _x && (damage _x) isEqualTo 0) then {
		private _cls = typeof _x;
		private _name = _cls call OT_fnc_vehicleGetName;
		private _pic = _cls call OT_fnc_vehicleGetPic;
		private _idx = lbAdd [1500,_name];
		lbSetPicture [1500,_idx,_pic];
		lbSetData [1500,_idx,_cls];
		_numitems = _numitems + 1;
	};
}foreach(OT_factoryPos nearObjects ["AllVehicles", 100]);

if(_cursel >= _numitems) then {_cursel = 0};
lbSetCurSel [1500, _cursel];
