
private ["_building","_seeded","_cost","_num","_stock","_truckbusy","_pos","_town","_townpos"];
_building = _this select 0;

_seeded = false;

_pos = getPos _building;
_stock = [];

_building addEventHandler ["killed",{
	_b = _this select 0;
	_b setVariable ["status","finished",false];
}];

sleep (random 2);

_building setVariable ["status","idle",false];
_status = "idle";
_doingdelivery = false;

while {_status != "finished"} do {
	_status = _building getVariable ["status","idle"];
	_tiempo = time;
	
	//check my stock levels
	if (!_seeded) then {		
		_seeded = true;	
		_numemployees = 1 + round(random 12);
		_numsecurity = 2 + round(random 4);
				
		{
			_cost = cost getVariable _x;
			_base = _cost select 0;
			
			_max = 20;
			if(_base > 40) then {
				_max = 5;
			};			
			
			_num = floor(random _max);
			if(_x in OT_consumableItems) then {
				_num = floor(_num * 2);
			};
			if(_num > 0) then {
				_stock pushBack [_x,_num];
			};
		}foreach(OT_allItems + OT_allBackpacks);
		_building setVariable ["stock",_stock,true];
		_building setVariable ["employees",_numemployees,false];
		_building setVariable ["security",_numsecurity,false];
		_building setVariable ["delivery",false,false];
		_building setVariable ["deliveryid","",false];
		_building setVariable ["orders",[],false];
	}else{
		//check my orders
		_hour = date select 3;
		_orders = _building getVariable "orders";
		
		if(!(_doingdelivery) and _status == "idle" and _hour > 8 and _hour < 17 and (count _orders) > 0) then {
			
			//Need to determine if a town has a big enough order to bother sending a truck, so one isnt sent for 2 bandages
			//First pull apart the orders and file them by town into a dictionary
			
			_townorders = call dict_create;
			_towntotal = call dict_create;
			_townorder = "";
			{
				_shop = _x select 0;
				_order = _x select 1;
				_town = (getpos _shop) call nearestTown;
				if([_towntotal,_town] call dict_exists) then {
					_townorder = [_towntotal,_town] call dict_get;
				}else{
					_townorder = call dict_create;
				};
				{
					_cls = _x select 0;
					_num = _x select 1;
					if([_townorder,_cls] call dict_exists) then {
						_c = ([_townorder,_cls] call dict_get) + _num;
						[_townorder,_cls,_c] call dict_set;
					}else{
						[_townorder,_cls,_num] call dict_set;
					};					
				}foreach(_order);
				[_townorders,_town,_x] call dict_pushback;
				[_towntotal,_town,_townorder] call dict_set;
			}foreach(_orders);
			
			//Get the total value of the orders for each town
			_townqty = [];
			{
				_town = _x;
				_size = 0;
				_o = [_towntotal,_town] call dict_get;
				{
					_cls = _x;
					_num = [_o,_cls] call dict_get;
					_basecost = (cost getVariable _cls) select 0;
					_size = _size + (_num * _basecost)
				}foreach(_o call dict_keys);
				_townqty pushback [_town,_size];
			}foreach(_towntotal call dict_keys);
						
			_size = 0;
			//Get the town with the most orders and see if its higher than the threshold
			_qty = [_townqty,[],{_x select 1},"DESCEND"] call BIS_fnc_sortBy;
			_town =  (_qty select 0) select 0;
			_size = (_qty select 0) select 1;
									
			if(_size > OT_distroThreshold) then {
				//OK.. Send a truck				
				_loaddict = [_towntotal,_town] call dict_get;				
				_load = [];
				{
					_load pushback [_x,[_loaddict,_x] call dict_get]; 
				}foreach(_loaddict call dict_keys);
				
				_deliveries = [_townorders,_town] call dict_get;
				_townpos = server getvariable _town;
				_pos = getpos _building;
				
				_actual = [];
				_s = _building getVariable "stock";
				{
					_cls = _x select 0;
					_numwant = _x select 1;
					_done = false;
					_soldout = false;
					_stockidx = 0;
					{	
						if(((_x select 0) == _cls) && ((_x select 1) > 0)) exitWith {
							_num = (_x select 1)-_numwant;
							if(_num < 0) then {_num = 0;_numwant = _x select 1};
							if(_num == 0) then {
								_soldout = true;
							};
							_x set [1,_num];
							_done = true;
						};
						_stockidx = _stockidx + 1;
					}foreach(_s);

					if(_done) then {	
						if(_soldout) then {
							_s deleteAt _stockidx;
						};
						_actual pushback [_cls,_numwant];
					};
				}foreach(_load);
				_building setVariable ["stock",_s,true];	
				
				if((count _actual) > 0) then {
					_deliveryid = [[_pos,_townpos],logistics,[_building,_actual,_deliveries]] call OT_fnc_registerSpawner;
					_doingdelivery = true;
				};
			};
			
			{
				_town = _x;
				_townorder = [_towntotal,_town] call dict_get;
				_townorder call dict_destroy;
			}foreach(_towntotal call dict_keys);
			_towntotal call dict_destroy;
			_townorders call dict_destroy;
		};
	};
	sleep 200 + random(600); //stagger the updates
};

OT_activeDistribution deleteAt (OT_activeDistribution find _building);
publicVariable "OT_activeDistribution";