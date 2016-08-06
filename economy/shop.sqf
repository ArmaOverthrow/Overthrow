
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
	
	};
	sleep 200 + random(400); //stagger the updates
};