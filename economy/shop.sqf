
private ["_building","_tracked","_tiempo","_spawned","_vehs","_seeded","_itemsToStock","_group","_shopkeeper","_stock","_b","_s","_town","_standing","_cls","_num","_price","_idx","_all"];
_building = _this select 0;

_pos = getPos _building;
_tiempo = time;
_spawned = false;
_vehs = [];
_groups = [];
_tracked = [];
_seeded = false;
_itemsToStock = [];
_stock = [];

sleep (random 2);

while {true} do {
	
	_tiempo = time;
	
	//check my stock levels
	if (!_seeded) then {
		//choose some random legal items
		_seeded = true;
		_numitems = floor(random 10) + 2;
		_count = 0;
		
		while {_count < _numitems} do {
			_item = (AIT_allItems + AIT_allBackpacks) call BIS_Fnc_selectRandom;
			if!(_item in _itemsToStock) then {
				_itemsToStock pushback _item;
				_count = _count + 1;
			};
		};
		
		{
			_num = floor(random 5) + 1;
			if(_x in AIT_consumableItems) then {
				_num = floor(_num * 4);
			};
			_stock pushBack [_x,_num];
		}foreach(_itemsToStock);
		_building setVariable ["stock",_stock,true];
	}else{
		//check my stock
		_currentitems = [];
		
		_order = [];
		
		_stock = _building getvariable "stock";
		{
			_currentitems pushback (_x select 0);
		}foreach(_stock);
		{
			if (!(_x in _currentitems) || ((random 10000) > 9999)) then {
				_num = floor(random 10) + 1;
				if(_x in AIT_consumableItems) then {
					_num = floor(_num * 4);
				};
				_order pushback [_x,_num];
			};
		}foreach(_itemsToStock);
		
		if(count _order > 0) then {
			_closest = [AIT_activeDistribution,_building] call BIS_fnc_nearestPosition;
			_orders = _closest getVariable "orders";
			_idx = -1;
			{				
				_idx = _idx + 1;
				_b = _x select 0;
				_o = _x select 1;				
				if(_b == _building) exitWith {};
			}foreach(_orders);
			if(_idx > -1) then {
				_orders deleteAt _idx;
			};
			_orders pushback [_building,_order];
			_closest setVariable ["orders",_orders,true];
		};
		
		
	};
	sleep 200 + random(600); //stagger the updates
};