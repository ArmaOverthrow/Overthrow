if(!(cursorTarget isKindOf "LandVehicle")) exitWith {hint "Workshop Mode: You must be looking at a vehicle"};

createDialog "OT_dialog_workshop";

private _veh = cursorTarget;

private _pic =  getText(configFile >> "cfgVehicles" >> (typeof _veh) >> "editorPreview");
ctrlSetText [1201,_pic];

lbClear 1500;
{
	_x params ["_name","_type","_price","_free","_do"];
	if(_type == "" || _type == (typeof _veh)) then {
		_price = [0,_do] call OT_fnc_getPrice;
		_price = [_price, 0] select ((backpack player) isEqualTo _free);
		private _pic = _do call OT_fnc_vehicleGetPic;
		private _idx = lbAdd [1500,format["%1",_name]];
		lbSetPicture [1500,_idx,_pic];
		lbSetValue [1500,_idx,_price];
		lbSetData [1500,_idx,_do];
	};
}foreach(OT_workshop);
