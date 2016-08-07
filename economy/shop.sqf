
private ["_building","_town","_tracked","_tiempo","_spawned","_vehs","_seeded","_itemsToStock","_group","_shopkeeper","_stock","_b","_s","_town","_standing","_cls","_num","_price","_idx","_all"];
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
_town = _pos call nearestTown;
_region = server getVariable [format["region_%1",_town],"region_none"];

_onorder = [];

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
			_item = (AIT_allItems) call BIS_Fnc_selectRandom;
			if!(_item in _itemsToStock) then {
				_itemsToStock pushback _item;
				_count = _count + 1;
			};			
		};
		
		//1 Backpack
		_item = (AIT_allBackpacks) call BIS_Fnc_selectRandom;
		_itemsToStock pushback _item;		
		
		{
			_num = floor(random 5) + 1;
			if(_x in AIT_consumableItems) then {
				_num = floor(_num * 4);
			};
			_stock pushBack [_x,_num];
		}foreach(_itemsToStock);
		_building setVariable ["stock",_stock,true];
	}else{		
		_currentitems = [];
		
		//Find the closest distro center and check if I already have an order there
		_closest = nearestBuilding([AIT_activeDistribution,_building,_region] call nearestPositionRegion);
		if !(isNil "_closest") then {
			_orders = _closest getVariable ["orders",[]];
			_idx = -1;
			_neworder = false;
			_order = [];
			{				
				_idx = _idx + 1;
				_b = _x select 0;
				_o = _x select 1;				
				if(_b == _building) exitWith {};
			}foreach(_orders);
			if(_idx > -1) then {
				_order = (_orders select _idx) select 1;
			}else{
				_neworder = true;
			};
			
			//check my current stock levels
			_stock = _building getvariable "stock";
			{
				_currentitems pushback (_x select 0);
			}foreach(_stock);
			{
				if (!(_x in _currentitems) and !(_x in _onorder)) then {
					//Add it to my order
					_onorder pushback _x;
					_num = floor(random 3) + 1;
					if(_x in AIT_consumableItems) then {
						_num = floor(_num * 2);
					};
					_order pushback [_x,_num];
				};
			}foreach(_itemsToStock);
			
			if(_neworder and (count _order) > 0) then {
				_orders pushback [_building,_order];
			};
			_closest setVariable ["orders",_orders,true];
			
			_stability = server getVariable format["stability%1",_town];
			if(_stability > 50 and (random 1000 > 700)) then {
				//Sell a random item			
				_stock = _building getVariable "stock";
				_idx = floor random((count _stock) - 1);
				_item = _stock call BIS_fnc_selectRandom;
				_cls = _item select 0;
				_num = _item select 1;
				if(_num <= 1) then {
					_stock deleteAt _idx;
				}else{
					_item set[1,_num-1];
				};
				_building setVariable ["stock",_stock,true];
			};
		};
	};
	sleep 60 + random(200); //stagger the updates
};