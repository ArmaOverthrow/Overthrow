
private ["_building","_seeded","_cost","_num","_stock"];
_building = _this select 0;

_seeded = false;

_pos = getPos _building;
_stock = [];

sleep (random 2);

while {true} do {
	
	_tiempo = time;
	
	//check my stock levels
	if (!_seeded) then {		
		_seeded = true;		
		{
			_cost = cost getVariable _x;
			_base = _cost select 0;
			
			_max = 50;
			if(_base > 40) then {
				_max = 10;
			};			
			
			_num = floor(random _max);
			if(_x in AIT_consumableItems) then {
				_num = floor(_num * 4);
			};
			if(_num > 0) then {
				_stock pushBack [_x,_num];
			};
		}foreach(AIT_allItems + AIT_allBackpacks);
		_building setVariable ["stock",_stock,true];
		_building setVariable ["orders",[],true];
	}else{
		//check my orders
		
		_orders = _building getVariable "orders";
		_townorders = [];
		if(count _orders > 0) then {
			
		};
	};
	sleep 30 + random(200); //stagger the updates
};