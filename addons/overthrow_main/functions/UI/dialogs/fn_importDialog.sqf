if(count (player nearObjects [OT_portBuilding,30]) isEqualTo 0) exitWith {};
private _town = player call OT_fnc_nearestTown;
_items = OT_Resources + OT_allItems + OT_allBackpacks + ["V_RebreatherIA"];
if(_town in (server getVariable ["NATOabandoned",[]]) || OT_adminMode) then {
	_items = OT_Resources + OT_allItems + OT_allBackpacks + ["V_RebreatherIA"] + OT_allWeapons + OT_allMagazines + OT_allAttachments + OT_allStaticBackpacks + OT_allOptics + OT_allVests + OT_allHelmets + OT_allClothing;
}else{
	hint format ["Only legal items may be imported while NATO controls %1",_town];
};

private _cursel = lbCurSel 1500;
lbClear 1500;
_done = [];

_numitems = 0;
{
	_cls = _x;
	if(_cls isKindOf ["Default",configFile >> "CfgWeapons"]) then {
		_cls = [_x] call BIS_fnc_baseWeapon;
	};

	if !((_cls in _done) || (_cls in OT_allExplosives)) then {
		_done pushback _cls;
		_price = [OT_nation,_cls,100] call OT_fnc_getPrice;
		_name = "";
		_pic = "";

		if(_price > 0) then {
			_numitems = _numitems + 1;
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
				_name = _cls call OT_fnc_vehicleGetName;
				_pic = _cls call OT_fnc_vehicleGetPic;
			};

			_idx = lbAdd [1500,format["%1",_name]];
			lbSetPicture [1500,_idx,_pic];
			lbSetValue [1500,_idx,_price];
			lbSetData [1500,_idx,_cls];
		};
	};
}foreach(_items);

if(_cursel >= _numitems) then {_cursel = 0};
lbSetCurSel [1500, _cursel];
