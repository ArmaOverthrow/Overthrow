private ["_town","_standing","_s"];

_town = _this select 0;
_standing = _this select 1;
_s = _this select 2;
private _multiplier = 1;
if(count _this > 3) then {
	_multiplier = _this select 3;
};

_sorted = [_s,[],{_x select 0},"ASCEND"] call BIS_fnc_SortBy;

lbClear 1500;
{
	_cls = _x select 0;
	_num = _x select 1;
	_enabled = true;
	_disabledText = "Not Available";
	if(count _x > 2) then {
		_enabled = _x select 2;
	};
	if(count _x > 3) then {
		_disabledText = _x select 3;
	};
	_price = [_town,_cls,_standing] call OT_fnc_getPrice;
	_price = _price * _multiplier;
	_name = "";
	_pic = "";
	call {
		if(_cls isKindOf "All") exitWith {
			_name = _cls call OT_fnc_vehicleGetName;
			_pic = _cls call OT_fnc_vehicleGetPic;
		};
		if(_cls isKindOf ["None",configFile >> "CfgGlasses"]) exitWith {
			_name = _cls call OT_fnc_glassesGetName;
			_pic = _cls call OT_fnc_glassesGetPic;
		};
		if(_cls isKindOf ["CA_Magazine",configFile >> "CfgMagazines"]) exitWith {
			_name = _cls call OT_fnc_magazineGetName;
			_pic = _cls call OT_fnc_magazineGetPic;
		};
		_name = _cls call OT_fnc_weaponGetName;
		_pic = _cls call OT_fnc_weaponGetPic;
	};
	_text = format["%1 x %2",_num,_name];
	if(_num == -1) then {_text = _name};
	_idx = lbAdd [1500,_text];
	lbSetPicture [1500,_idx,_pic];
	if !(_enabled) then {
		lbSetColor [1500,_idx,[0.3,0.3,0.3,1]];
		_price = -1;
		_cls = _disabledText;
	};
	lbSetValue [1500,_idx,_price];
	lbSetData [1500,_idx,_cls];
}foreach(_sorted);
