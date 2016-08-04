
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
	if (time - _tiempo >= 0.5) then {sleep 0.1} else {sleep 0.5 - (time - _tiempo)};
	_tiempo = time;
	
	_indist = (_pos call inSpawnDistance);
	
	if(!_spawned && _indist) then {
		_tracked = _building call spawnTemplate;
		_vehs = _tracked select 0;
		
		_cashdesk = _pos nearestObject AIT_item_ShopRegister;
		_spawnpos = _building buildingPos 0;
		
		_group = createGroup civilian;	
		_group setBehaviour "CARELESS";
		_type = (AIT_civTypes_locals + AIT_civTypes_expats) call BIS_Fnc_selectRandom;		
		_shopkeeper = _group createUnit [_type, _spawnpos, [],0, "NONE"];
		_vehs pushback _shopkeeper;
		
		_all = server getVariable "activeshops";
		_all pushback _shopkeeper;
		server setVariable ["activeshops",_all,true];
		
		_shopkeeper remoteExec ["initShopLocal",0,true];
		[_shopkeeper] call initCivilian;
		
		_spawned = true;
	}else{
		if(!_indist) then {
			_spawned = false;
			{deleteVehicle _x} forEach _vehs;
			{deleteGroup _x} forEach _groups;			
			_vehs = [];
			_groups = [];
		}
	};
	
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
	
};