createDialog 'OT_dialog_factory';

private _cursel = lbCurSel 1500;
lbClear 1500;
private _done = [];
private _numitems = 0;

{
	if(_x isKindOf ["Default",configFile >> "CfgWeapons"]) then {
		_x = [_x] call BIS_fnc_baseWeapon;
	};

	if !(_x in _done) then {
		_done pushback _x;
		
		private _name = "";
		private _pic = "";

		_numitems = _numitems + 1;
		_x call {
			if(_this isKindOf "AllVehicles") exitWith {
				_name = _this call OT_fnc_vehicleGetName;
				_pic = _this call OT_fnc_vehicleGetPic;
			};
			if(_this isKindOf ["Default",configFile >> "CfgWeapons"]) exitWith {
				_name = _this call OT_fnc_weaponGetName;
				_pic = _this call OT_fnc_weaponGetPic;
			};
			if(_this isKindOf ["Default",configFile >> "CfgMagazines"]) exitWith {
				_name = _this call OT_fnc_magazineGetName;
				_pic = _this call OT_fnc_magazineGetPic;
			};
			if(_this isKindOf "Bag_Base") exitWith {
				_name = _this call OT_fnc_vehicleGetName;
				_pic = _this call OT_fnc_vehicleGetPic;
			};
		};

		private _idx = lbAdd [1500,format["%1",_name]];
		lbSetPicture [1500,_idx,_pic];
		lbSetData [1500,_idx,_x];
	};
}foreach(server getVariable ["GEURblueprints",[]]);

if(_cursel >= _numitems) then {_cursel = 0};
lbSetCurSel [1500, _cursel];

[] call OT_fnc_factoryRefresh;
