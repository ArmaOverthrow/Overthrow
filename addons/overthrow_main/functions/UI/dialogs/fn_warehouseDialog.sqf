buttonSetAction [1604, '[] spawn OT_fnc_warehouseDialog'];
private _cursel = lbCurSel 1500;
lbClear 1500;
_SearchTerm = ctrlText 1700;
private _itemVars = (allVariables warehouse) select {((toLower _x select [0,5]) isEqualTo "item_")};
_itemVars sort true;
private _numitems = 0;
{
	private _d = warehouse getVariable [_x,false];
	if(_d isEqualType []) then {
		_d params [["_cls","",[""]], ["_num",0,[0]]];
		if(tolower(_cls) find _SearchTerm > -1) then {
			if ((_cls isEqualType "") && _num > 0) then {
				_numitems = _numitems + 1;
				([_cls] call {
					params ["_cls"];
					if(_cls isKindOf ["Default",configFile >> "CfgWeapons"]) exitWith {
						_name = _cls call OT_fnc_weaponGetName;
						_pic = _cls call OT_fnc_weaponGetPic;
						[_name,_pic]
					};
					if(_cls isKindOf ["Default",configFile >> "CfgMagazines"]) exitWith {
						_name = _cls call OT_fnc_magazineGetName;
						_pic = _cls call OT_fnc_magazineGetPic;
						[_name,_pic]
					};
					if(_cls isKindOf "Bag_Base") exitWith {
						_name = _cls call OT_fnc_vehicleGetName;
						_pic = _cls call OT_fnc_vehicleGetPic;
						[_name,_pic]
					};
					if(isClass (configFile >> "CfgGlasses" >> _cls)) exitWith {
						_name = gettext(configFile >> "CfgGlasses" >> _cls >> "displayName");
						_pic = gettext(configFile >> "CfgGlasses" >> _cls >> "picture");
						[_name,_pic]
					};
					_name = _cls call OT_fnc_vehicleGetName;
					_pic = _cls call OT_fnc_vehicleGetPic;
					[_name,_pic]
				}) params ["_name","_pic"];

				private _idx = lbAdd [1500,format["%1 x %2",_num,_name]];
				lbSetPicture [1500,_idx,_pic];
				lbSetValue [1500,_idx,_num];
				lbSetData [1500,_idx,_cls];
			};
		};
	};
}foreach(_itemVars);

if(_cursel >= _numitems) then {_cursel = 0};
lbSetCurSel [1500, _cursel];
