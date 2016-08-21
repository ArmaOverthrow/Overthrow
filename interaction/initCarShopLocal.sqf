_civ = _this;

_civ addAction ["Buy Vehicle", {		
	_town = (getpos player) call nearestTown; 
	_standing = player getVariable format['rep%1',_town];
	createDialog "AIT_dialog_buy";
	{			
		_cls = _x select 0;
		_price = [_town,_cls,_standing] call getPrice;
		if("fuel depot" in (server getVariable "AIT_NATOabandoned")) then {
			_price = round(_price * 0.5);
		};
		_idx = lbAdd [1500,format["%1",_cls call ISSE_Cfg_Vehicle_GetName,_price]];
		lbSetPicture [1500,_idx,_cls call ISSE_Cfg_Vehicle_GetPic];
		lbSetData [1500,_idx,_cls];
		lbSetValue [1500,_idx,_price];
	}foreach(AIT_vehicles);
	
}];