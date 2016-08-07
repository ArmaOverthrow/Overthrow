_group = _this;

if({alive _x} count (units _group) == 0) exitWith {};

_veh = assignedVehicle (units _group) select 0;
if(isNil _veh) exitWith {};

_deliveries = _veh getVariable ["delivery",[]];

if(count _deliveries == 0) exitWith {};

_delivery = _deliveries select 0;
_building = _delivery select 0;
_items = _delivery select 1;

_stock = _building getVariable ["stock",[]];
_intruck = _veh call unitStock;
{
	_cls = _x select 0;
	_numwant = _x select 1;
	_numhave = 0;
	_out = false;
	_stockidx = 0;
	_done = false;
	{	
		if((_x select 0) == _cls) exitWith {
			_done = true;
			_numhave = _x select 1;
			if(_numwant > _numhave) then {
				_numwant = _numhave;
				_out = true;
			};
			_x set [1,_numhave-_numwant];
		};
		_stockidx = _stockidx + 1;
	}foreach(_intruck);
	if(_out) then {
		_intruck deleteAt _stockidx;
	};
	if(_done) then {
		{	
			if((_x select 0) == _cls) exitWith {
				_num = (_x select 1)+_numwant;				
				_x set [1,_num];
			};
		}foreach(_stock);
	};

}foreach(_items);

_building setVariable ["stock",_stock];

clearItemCargoGlobal _veh;
{				
	_cls = _x select 0;
	_num = _x select 1;
	if(_cls in AIT_allBackpacks) then {	
		_veh addBackpackCargo _x;
	}else{
		_veh addItemCargo _x;
	};				
}foreach(_intruck);

_deliveries deleteAt 0;
_veh setVariable ["delivery",_deliveries];