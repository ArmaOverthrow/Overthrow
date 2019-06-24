private _target = vehicle player;
if(_target isEqualTo player) exitWith {};

if(count (player nearObjects [OT_portBuilding,30]) isEqualTo 0) exitWith {};

private _town = player call OT_fnc_nearestTown;
private _doillegal = false;
if(_town in (server getVariable ["NATOabandoned",[]])) then {
	_doillegal = true;
}else{
	hint format ["Only legal items may be exported while NATO controls %1",_town];
};

"Exporting inventory" call OT_fnc_notifyMinor;
[5,false] call OT_fnc_progressBar;
sleep 5;

private _combinedItems = OT_allItems + OT_allBackpacks + OT_Resources;
private _total = 0;

{
	_x params ["_cls", "_qty"];
	private _count = 0;
	if((_doillegal || _cls in _combinedItems) && !(_cls in OT_allClothing)) then {
		private _baseprice = [OT_nation,_cls,0] call OT_fnc_getSellPrice;
		private _costprice = round(_baseprice * 0.6); //The cost of export
		if(_cls in OT_allDrugs) then {
			_costprice = round(_baseprice * 0.5);
		};
		if(_cls in OT_illegalItems) then {
			_costprice = round(_baseprice * 0.3);
		};

		_total = _total + (_costprice * _qty);

		private _noncontaineritems = ((weaponCargo _target) + (itemCargo _target) + (magazineCargo _target) + (backpackCargo _target)) call BIS_fnc_consolidateArray;
		private _ncqty = 0;
		{
			_x params ["_thiscls","_thisqty"];
			if(_thiscls isEqualTo _cls) exitWith {
				_ncqty = _thisqty;
			};
		}foreach(_noncontaineritems);
		if(_ncqty > 0) then {
			if !([_target, _cls, _ncqty] call CBA_fnc_removeItemCargo) then {
				if !([_target, _cls, _ncqty] call CBA_fnc_removeWeaponCargo) then {
					if !([_target, _cls, _ncqty] call CBA_fnc_removeMagazineCargo) then {
						if !([_target, _cls, _ncqty] call CBA_fnc_removeBackpackCargo) then {
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
						[_item, _cls, _q] call CBA_fnc_removeItemCargo;
						_qty = _qty - _q;
					};
				}foreach((itemCargo _item) call BIS_fnc_consolidateArray);
				if(_qty > 0) then {
					{
						_x params ["_c","_q"];
						if(_c isEqualTo _sellcls) exitWith {
							[_item, _cls, _q] call CBA_fnc_removeWeaponCargo;
							_qty = _qty - _q;
						};
					}foreach((weaponCargo _item) call BIS_fnc_consolidateArray);
				};
				if(_qty > 0) then {
					{
						_x params ["_c","_q"];
						if(_c isEqualTo _sellcls) exitWith {
							[_item, _cls, _q] call CBA_fnc_removeMagazineCargo;
							_qty = _qty - _q;
						};
					}foreach((magazineCargo _item) call BIS_fnc_consolidateArray);
				};
			}foreach(everyContainer _target);
		};
	};
}foreach(_target call OT_fnc_unitStock);

[_total] call OT_fnc_money;
