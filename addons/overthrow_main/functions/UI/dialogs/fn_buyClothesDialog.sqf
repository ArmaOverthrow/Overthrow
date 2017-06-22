private ["_town","_standing","_s"];

_town = _this select 0;
_standing = _this select 1;


lbClear 1500;
{
	_cls = _x;

	_c = _cls splitString "_";
	_side = _c select 1;
	if((_cls == "V_RebreatherIA" or _side == "C" or _side == "I") and (_c select (count _c - 1) != "VR")) then {
		_price = [_town,_cls,_standing] call OT_fnc_getPrice;
		_name = "";
		_pic = "";
		_name = _cls call OT_fnc_weaponGetName;
		_pic = _cls call OT_fnc_weaponGetPic;

		_idx = lbAdd [1500,_name];
		lbSetPicture [1500,_idx,_pic];
		lbSetValue [1500,_idx,_price];
		lbSetData [1500,_idx,_cls];
	};
}foreach(OT_allClothing + ["V_RebreatherIA"]);

{
	_cls = _x;

	_price = [_town,_cls,_standing] call OT_fnc_getPrice;
	_name = "";
	_pic = "";
	_name = _cls call OT_fnc_glassesGetName;
	_pic = _cls call OT_fnc_glassesGetPic;

	_idx = lbAdd [1500,_name];
	lbSetPicture [1500,_idx,_pic];
	lbSetValue [1500,_idx,_price];
	lbSetData [1500,_idx,_cls];

}foreach(OT_allGlasses + OT_allGoggles + OT_allFacewear);
