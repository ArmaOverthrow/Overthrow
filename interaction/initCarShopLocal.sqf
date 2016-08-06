_civ = _this;

_civ addAction ["Buy Vehicle", {		
	_town = (getpos player) call nearestTown; 
	_standing = player getVariable format['rep%1',_town];
	createDialog "AIT_dialog_buy";
	{			
		_cls = _x select 0;
		_price = [_town,_cls,_standing] call getPrice;
		_idx = lbAdd [1500,format["%1 ($%2)",_cls call ISSE_Cfg_Vehicle_GetName,_price]];
		lbSetData [1500,_idx,_cls];
	}foreach(AIT_vehicles);
	
}];