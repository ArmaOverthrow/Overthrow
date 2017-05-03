disableSerialization;

_base = (getpos player) call OT_fnc_nearestObjective;
if (isNil "_base") exitWith {};
if !((_base select 1) in (server getvariable "NATOabandoned")) exitWith {"This barracks is under NATO control" call OT_fnc_notifyMinor};

private _price = floor((["Tanoa","CIV",0] call OT_fnc_getPrice) * 1.5);

createDialog "OT_dialog_buy";
ctrlSetText [1600,"Recruit"];
lbClear 1500;
{			
	_cls = _x select 0;
	_comp = _x select 1;
	_cost = (_price * count _comp);
		
	_idx = lbAdd [1500,_cls];
	lbSetValue [1500,_idx,_cost];
	lbSetData [1500,_idx,_cls];
}foreach(OT_squadables);
{			
	_cls = _x select 0;
	_name = _cls call ISSE_Cfg_Vehicle_GetName;
		
	_idx = lbAdd [1500,_name];
	lbSetValue [1500,_idx,_price];
	lbSetData [1500,_idx,_cls];
}foreach(OT_recruitables);

