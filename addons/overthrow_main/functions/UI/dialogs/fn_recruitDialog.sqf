_b = player call OT_fnc_nearestRealEstate;
_building = objNull;
if(typename _b != "ARRAY") exitWith {};
_building = (_b select 0);
if(damage _building == 1) exitWith {"Must repair before you can recruit" call OT_fnc_notifyMinor};

disableSerialization;

_base = nil;
_good = true;
if(typeof _building == OT_barracks) then {
	_base = (getpos player) call OT_fnc_nearestObjective;
	if !((_base select 1) in (server getvariable "NATOabandoned")) then {
		_good = false;
	}
};
if ((typeof _building == OT_barracks) and isNil "_base") exitWith {};
if ((typeof _building == OT_barracks) and !_good) exitWith {"This barracks is under NATO control" call OT_fnc_notifyMinor};

private _price = floor(([OT_nation,"CIV",0] call OT_fnc_getPrice) * 1.5);

createDialog "OT_dialog_buy";
ctrlSetText [1600,"Recruit"];
lbClear 1500;
if (typeof _building == OT_barracks) then {
	{
		_cls = _x select 0;
		_comp = _x select 1;
		_cost = (_price * count _comp);

		_idx = lbAdd [1500,_cls];
		lbSetValue [1500,_idx,_cost];
		lbSetData [1500,_idx,_cls];
	}foreach(OT_squadables);
};
{
	_cls = _x select 0;
	_name = _cls call OT_fnc_vehicleGetName;

	_idx = lbAdd [1500,_name];
	lbSetValue [1500,_idx,_price];
	lbSetData [1500,_idx,_cls];
}foreach(OT_recruitables);
