private ["_b","_s","_town","_standing","_cls","_num","_price","_idx","_done"];
if (OT_selling) exitWith {};

OT_selling = true;


_town = (getpos player) call OT_fnc_nearestTown;

_standing = (player getVariable format['rep%1',_town]) * -1;
_idx = lbCurSel 1500;
_cls = lbData [1500,_idx];

if(isNil "_cls" or _cls == "") exitWith {OT_selling = false};

_price = [_town,_cls,_standing] call OT_fnc_getSellPrice;

if(isNil "_price") exitWith {OT_selling = false};

[_price] call OT_fnc_money;

if(_price > 100) then {[_town,round(_price / 100)] call OT_fnc_standing};

if(OT_hasTFAR) then {
	_c = _cls splitString "_";
	if((_c select 0) == "tf") then {
		{
			if(_x find _cls == 0) exitWith {_cls = _x};
		}foreach(items player);
	};
};
_target = player;
if((player getVariable ["OT_shopTarget","Self"]) == "Vehicle") then {
	_target = vehicle player;

	[_target, _cls, 1] call CBA_fnc_removeItemCargo;
}else{
	_target removeItem _cls;
};

lbClear 1500;
_cat = player getVariable ["OT_shopTargetCategory",""];
[[_target,_cat] call OT_fnc_unitStock,_town,_standing] call OT_fnc_sellDialog;
OT_selling = false;
