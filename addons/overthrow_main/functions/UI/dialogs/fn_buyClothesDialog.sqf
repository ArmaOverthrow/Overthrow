params ["_town","_standing"];

lbClear 1500;
{
	private _cls = _x;

	private _c = _cls splitString "_";
	private _side = _c select 1;
	if((_cls == "V_RebreatherIA" || _side == "C" || _side == "I") && (_c select (count _c - 1) != "VR")) then {
		private _price = [_town,_cls,_standing] call OT_fnc_getPrice;
		private _name = "";
		private _pic = "";
		private _name = _cls call OT_fnc_weaponGetName;
		private _pic = _cls call OT_fnc_weaponGetPic;

		private _idx = lbAdd [1500,_name];
		lbSetPicture [1500,_idx,_pic];
		lbSetValue [1500,_idx,_price];
		lbSetData [1500,_idx,_cls];
	};
}foreach(OT_allClothing + ["V_RebreatherIA"]);

{
	private _cls = _x;

	private _price = [_town,_cls,_standing] call OT_fnc_getPrice;
	private _name = "";
	private _pic = "";
	private _name = _cls call OT_fnc_glassesGetName;
	private _pic = _cls call OT_fnc_glassesGetPic;

	private _idx = lbAdd [1500,_name];
	lbSetPicture [1500,_idx,_pic];
	lbSetValue [1500,_idx,_price];
	lbSetData [1500,_idx,_cls];

}foreach(OT_allGlasses + OT_allGoggles + OT_allFacewear);
