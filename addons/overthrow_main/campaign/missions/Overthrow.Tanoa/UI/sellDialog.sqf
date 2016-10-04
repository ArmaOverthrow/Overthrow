private ["_playerstock","_town","_standing","_s"];

_playerstock = _this select 0;
_town = _this select 1;
_standing = _this select 2;
_s = _this select 3;

lbClear 1500;
{			
	_cls = _x select 0;
	if(_cls in OT_allItems) then {
		_num = _x select 1;			
		_price = [_town,_cls,_standing] call getSellPrice;
		_mynum = 0;
		{
			_c = _x select 0;
			if(_c == _cls) exitWith {_mynum = _x select 1};				
		}foreach(_s);
					
		if(_mynum > 50) then {
			_price = ceil(_price * 0.75);
		};
		if(_mynum > 100) then {
			_price = ceil(_price * 0.6);
		};
		if(_mynum > 200) then {
			_price = ceil(_price * 0.5);
		};
		if(_price <= 0) then {_price = 1};
		
		_name = "";
		_pic = "";
		if(_cls in OT_allBackpacks) then {
			_name = _cls call ISSE_Cfg_Vehicle_GetName;
			_pic = _cls call ISSE_Cfg_Vehicle_GetPic;
		}else{
			_name = _cls call ISSE_Cfg_Weapons_GetName;
			_pic = _cls call ISSE_Cfg_Weapons_GetPic;
		};
		_idx = lbAdd [1500,format["%1 x %2 ($%3)",_num,_name,_price]];
		lbSetPicture [1500,_idx,_pic];
		lbSetValue [1500,_idx,_price];
		lbSetData [1500,_idx,_cls];
	};
}foreach(_playerstock);