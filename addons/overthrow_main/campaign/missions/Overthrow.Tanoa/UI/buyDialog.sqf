private ["_town","_standing","_s"];

_town = _this select 0;
_standing = _this select 1;
_s = _this select 2;

_sorted = [_s,[],{_x select 0},"ASCEND"] call BIS_fnc_SortBy;

lbClear 1500;
{			
	_cls = _x select 0;
	_num = _x select 1;
	_price = [_town,_cls,_standing] call getPrice;
	_name = "";
	_pic = "";
	if(_cls isKindOf "Bag_Base") then {	
		_name = _cls call ISSE_Cfg_Vehicle_GetName;
		_pic = _cls call ISSE_Cfg_Vehicle_GetPic;
	}else{
		_name = _cls call ISSE_Cfg_Weapons_GetName;
		_pic = _cls call ISSE_Cfg_Weapons_GetPic;
	};
	_idx = lbAdd [1500,format["%1 x %2",_num,_name]];
	lbSetPicture [1500,_idx,_pic];
	lbSetValue [1500,_idx,_price];
	lbSetData [1500,_idx,_cls];
}foreach(_sorted);