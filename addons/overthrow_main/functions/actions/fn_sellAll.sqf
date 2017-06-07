private ["_b","_s","_town","_standing","_cls","_num","_price","_idx","_done","_qty"];
if (OT_selling) exitWith {};

OT_selling = true;


_town = (getpos player) call OT_fnc_nearestTown;
_s = [];

_standing = (player getVariable format['rep%1',_town]) * -1;
_idx = lbCurSel 1500;
_sellcls = lbData [1500,_idx];

if(isNil "_sellcls" or _sellcls == "") exitWith {OT_selling = false};

_price = [_town,_sellcls,_standing] call OT_fnc_getSellPrice;
_done = false;
_mynum = 0;

if(isNil "_price") exitWith {OT_selling = false};

_target = player;
if((player getVariable ["OT_shopTarget","Self"]) == "Vehicle") then {
	_target = vehicle player;
};

_qty = 0;
{
	_c = _x select 0;
	if(_c == _sellcls) exitWith {_qty = _x select 1};
}foreach(_target call OT_fnc_unitStock);

private _total = (_price*_qty);
[_total] call OT_fnc_money;
if(_total > 100) then {[_town,round(_total / 100)] call OT_fnc_standing};
_ocls = _sellcls;

if((player getVariable ["OT_shopTarget","Self"]) == "Vehicle") then {
	[_target, _sellcls, _qty] call CBA_fnc_removeItemCargo;
}else{
	for "_i" from 0 to _qty do {
		if(OT_hasTFAR) then {
			_c = _ocls splitString "_";
			if((_c select 0) == "tf") then {
				{
					if(_x find _ocls == 0) exitWith {_sellcls = _x};
				}foreach(items player);
			};
		};
		player removeItem _sellcls;
	};
};

lbClear 1500;
_cat = player getVariable ["OT_shopTargetCategory",""];
[[_target,_cat] call OT_fnc_unitStock,_town,_standing,_s] call OT_fnc_sellDialog;

OT_selling = false;
