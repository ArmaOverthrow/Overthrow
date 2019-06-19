if (OT_selling) exitWith {};
OT_selling = true;

private _town = (getpos player) call OT_fnc_nearestTown;
private _s = [];

private _standing = ([_town] call OT_fnc_support) * -1;
private _idx = lbCurSel 1500;
private _sellcls = lbData [1500,_idx];

if(isNil "_sellcls" || {_sellcls isEqualTo ""}) exitWith {OT_selling = false};

private _price = [_town,_sellcls,_standing] call OT_fnc_getSellPrice;
private _done = false;
private _mynum = 0;

if(isNil "_price") exitWith {OT_selling = false};

private _target = player;
if((player getVariable ["OT_shopTarget","Self"]) isEqualTo "Vehicle") then {
	_target = vehicle player;
};

private _qty = 0;
{
	private _c = _x select 0;
	if(_c == _sellcls) exitWith {_qty = _x select 1};
}foreach(_target call OT_fnc_unitStock);

private _total = (_price*_qty);
[_total] call OT_fnc_money;
if(_total > 100) then {[_town,round(_total / 100)] call OT_fnc_support};
private _ocls = _sellcls;

if((player getVariable ["OT_shopTarget","Self"]) isEqualTo "Vehicle") then {
	private _noncontaineritems = ((weaponCargo _target) + (itemCargo _target) + (magazineCargo _target) + (backpackCargo _target)) call BIS_fnc_consolidateArray;
	private _ncqty = 0;
	{
		_x params ["_thiscls","_thisqty"];
		if(_thiscls isEqualTo _sellcls) exitWith {
			_ncqty = _thisqty;
		};
	}foreach(_noncontaineritems);
	if(_ncqty > 0) then {
		if !([_target, _sellcls, _ncqty] call CBA_fnc_removeItemCargo) then {
			if !([_target, _sellcls, _ncqty] call CBA_fnc_removeWeaponCargo) then {
				if !([_target, _sellcls, _ncqty] call CBA_fnc_removeMagazineCargo) then {
					if !([_target, _sellcls, _ncqty] call CBA_fnc_removeBackpackCargo) then {
					};
				};
			};
		};
	};
	_qty = _qty - _ncqty;
	if(_qty > 0) then {
		//still need to find more items in backpacks, uniforms etc
		{
			_x params ["_itemcls","_item"];
			{
				_x params ["_c","_q"];
				if(_c isEqualTo _sellcls) exitWith {
					[_item, _sellcls, _q] call CBA_fnc_removeItemCargo;
					_qty = _qty - _q;
				};
			}foreach((itemCargo _item) call BIS_fnc_consolidateArray);
			if(_qty > 0) then {
				{
					_x params ["_c","_q"];
					if(_c isEqualTo _sellcls) exitWith {
						[_item, _sellcls, _q] call CBA_fnc_removeWeaponCargo;
						_qty = _qty - _q;
					};
				}foreach((weaponCargo _item) call BIS_fnc_consolidateArray);
			};
			if(_qty > 0) then {
				{
					_x params ["_c","_q"];
					if(_c isEqualTo _sellcls) exitWith {
						[_item, _sellcls, _q] call CBA_fnc_removeMagazineCargo;
						_qty = _qty - _q;
					};
				}foreach((magazineCargo _item) call BIS_fnc_consolidateArray);
			};
		}foreach(everyContainer _target);
	};
}else{
	for "_i" from 0 to _qty do {
		if(OT_hasTFAR) then {
			private _c = _ocls splitString "_";
			if((_c select 0) == "tf") then {
				{
					if((_x find _ocls) isEqualTo 0) exitWith {_sellcls = _x};
				}foreach(items player);
			};
		};
		player removeItem _sellcls;
	};
};

lbClear 1500;
private _cat = player getVariable ["OT_shopTargetCategory",""];
[[_target,_cat] call OT_fnc_unitStock,_town,_standing,_s] call OT_fnc_sellDialog;

OT_selling = false;
