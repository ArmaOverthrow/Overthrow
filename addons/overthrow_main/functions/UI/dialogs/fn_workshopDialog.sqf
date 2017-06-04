if(!(cursorTarget isKindOf "LandVehicle")) exitWith {hint "Workshop Mode: You must be looking at a vehicle"};

createDialog "OT_dialog_workshop";

private _veh = cursorTarget;

private _pic =  getText(configFile >> "cfgVehicles" >> (typeof _veh) >> "editorPreview");
ctrlSetText [1201,_pic];

lbClear 1500;
{			
	_name = _x select 0;
	_type = _x select 1;
	if(_type == "" or _type == (typeof _veh)) then {
		_price = _x select 2;
		_free = _x select 3;
		
		if((backpack player) == _free) then {
			_price = 0;
		};	
		
		_do = _x select 4;
		
		_pic = _do call OT_fnc_vehicleGetPic;
		
		_idx = lbAdd [1500,format["%1",_name]];
		lbSetPicture [1500,_idx,_pic];
		lbSetValue [1500,_idx,_price];
		lbSetData [1500,_idx,_do];
	};
}foreach(OT_workshop);