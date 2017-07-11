private _cursel = lbCurSel 1500;
lbClear 1500;
_sorted = [allVariables warehouse,[],{_x},"ASCEND"] call BIS_fnc_SortBy;
_numitems = 0;
{
	_d = warehouse getVariable [_x,[_x,0]];
	if(typename _d == "ARRAY") then {
		_cls = _d select 0;
		if(typename _cls != "CODE") then {
			_num = _d select 1;
			_name = "";
			_pic = "";

			if(_num > 0) then {
				_numitems = _numitems + 1;
				call {
					if(_cls isKindOf ["Default",configFile >> "CfgWeapons"]) exitWith {
						_name = _cls call OT_fnc_weaponGetName;
						_pic = _cls call OT_fnc_weaponGetPic;
					};
					if(_cls isKindOf ["Default",configFile >> "CfgMagazines"]) exitWith {
						_name = _cls call OT_fnc_magazineGetName;
						_pic = _cls call OT_fnc_magazineGetPic;
					};
					if(_cls isKindOf "Bag_Base") exitWith {
						_name = _cls call OT_fnc_vehicleGetName;
						_pic = _cls call OT_fnc_vehicleGetPic;
					};
					if(isClass (configFile >> "CfgGlasses" >> _cls)) exitWith {
						_name = gettext(configFile >> "CfgGlasses" >> _cls >> "displayName");
						_pic = gettext(configFile >> "CfgGlasses" >> _cls >> "picture");
					};
					_name = _cls call OT_fnc_vehicleGetName;
					_pic = _cls call OT_fnc_vehicleGetPic;
				};

				_idx = lbAdd [1500,format["%1 x %2",_num,_name]];
				lbSetPicture [1500,_idx,_pic];
				lbSetValue [1500,_idx,_num];
				lbSetData [1500,_idx,_cls];
			};
		};
	};
}foreach(_sorted);

if(_cursel >= _numitems) then {_cursel = 0};
lbSetCurSel [1500, _cursel];
