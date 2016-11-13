private _cursel = lbCurSel 1500;
lbClear 1500;
_sorted = [allVariables warehouse,[],{_x},"ASCEND"] call BIS_fnc_SortBy;
_numitems = 0;
{	
	_d = warehouse getVariable [_x,[_x,0]];
	_cls = _d select 0;	
	_num = _d select 1;
	_name = "";
	_pic = "";
	
	if(_num > 0) then {	
		_numitems = _numitems + 1;
		if(_cls isKindOf ["Default",configFile >> "CfgWeapons"]) then {
			_name = _cls call ISSE_Cfg_Weapons_GetName;
			_pic = _cls call ISSE_Cfg_Weapons_GetPic;
		};	
		if(_cls isKindOf ["Default",configFile >> "CfgMagazines"]) then {
			_name = _cls call ISSE_Cfg_Magazine_GetName;
			_pic = _cls call ISSE_Cfg_Magazine_GetPic;
		};
		if(_cls isKindOf "Bag_Base") then {
			_name = _cls call ISSE_Cfg_Vehicle_GetName;
			_pic = _cls call ISSE_Cfg_Vehicle_GetPic;
		};

		_idx = lbAdd [1500,format["%1 x %2",_num,_name]];
		lbSetPicture [1500,_idx,_pic];
		lbSetValue [1500,_idx,_num];
		lbSetData [1500,_idx,_cls];
	};
}foreach(_sorted);

if(_cursel >= _numitems) then {_cursel = 0};
lbSetCurSel [1500, _cursel];