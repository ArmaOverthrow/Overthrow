createDialog 'OT_dialog_reverse';
private ["_playerstock","_town","_standing","_s"];

_playerstock = player call OT_fnc_unitStock;

private _cursel = lbCurSel 1500;
lbClear 1500;
private _numitems = 0;
private _blueprints = server getVariable ["GEURblueprints",[]];
{
	_cls = _x select 0;
	if !((_cls in _blueprints) or (_cls in OT_allExplosives)) then {
		_name = "";
		_pic = "";
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
		_idx = lbAdd [1500,_name];
		lbSetPicture [1500,_idx,_pic];
		lbSetData [1500,_idx,_cls];
		_numitems = _numitems + 1;
	};
}foreach(_playerstock);

{
	if (!(_x isKindOf "Animal") and !(_x isKindOf "CaManBase") and alive _x and (damage _x) == 0) then {
		_cls = typeof _x;
		_name = _cls call OT_fnc_vehicleGetName;
		_pic = _cls call OT_fnc_vehicleGetPic;
		_idx = lbAdd [1500,_name];
		lbSetPicture [1500,_idx,_pic];
		lbSetData [1500,_idx,_cls];
		_numitems = _numitems + 1;
	};
}foreach(OT_factoryPos nearObjects ["AllVehicles", 100]);

if(_cursel >= _numitems) then {_cursel = 0};
lbSetCurSel [1500, _cursel];
