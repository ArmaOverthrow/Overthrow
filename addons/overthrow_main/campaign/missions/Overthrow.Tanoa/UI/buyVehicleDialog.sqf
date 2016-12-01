private _town = player call nearestTown;
_standing = player getVariable format['rep%1',_town];

private _items = OT_vehicles;

private _ob = (getpos player) call nearestObjective;
_ob params ["_obpos","_obname"];
if(_obpos distance player < 250) then {
	if(_obname in (server getVariable ["NATOabandoned",[]])) then {
		_town = "Tanoa";
		_standing = 100;
		if((_obname in OT_allAirports) or OT_adminMode) then {
			_items = OT_helis + OT_vehicles;
		}else{
			_items = OT_vehicles + OT_boats;
		};
	}
};

if(OT_adminMode) then {
	_items = OT_helis + OT_vehicles + OT_boats;
};

createDialog "OT_dialog_buy";
{			
	_cls = _x select 0;
	_price = [_town,_cls,_standing] call getPrice;
	if("fuel depot" in (server getVariable "OT_NATOabandoned")) then {
		_price = round(_price * 0.5);
	};
	_idx = lbAdd [1500,format["%1",_cls call ISSE_Cfg_Vehicle_GetName]];
	lbSetPicture [1500,_idx,_cls call ISSE_Cfg_Vehicle_GetPic];
	lbSetData [1500,_idx,_cls];
	lbSetValue [1500,_idx,_price];
}foreach(_items);

_price = [_town,OT_item_UAV,_standing] call getPrice;
_idx = lbAdd [1500,format["Quadcopter"]];
lbSetPicture [1500,_idx,OT_item_UAV call ISSE_Cfg_Vehicle_GetPic];
lbSetData [1500,_idx,OT_item_UAV];
lbSetValue [1500,_idx,_price];