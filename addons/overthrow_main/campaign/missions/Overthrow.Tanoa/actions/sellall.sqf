private ["_b","_s","_town","_standing","_cls","_num","_price","_idx","_done","_qty"];
if (OT_selling) exitWith {};

OT_selling = true;


_b = player getVariable "shopping";
_bp = _b getVariable "shop";
_town = (getpos player) call OT_fnc_nearestTown;
_s = [];
_active = server getVariable [format["activeshopsin%1",_town],[]];
{
	_pos = _x select 0;
	if(format["%1",_pos] == _bp) exitWith {
		_s = _x select 1;
	};
}foreach(_active);

_standing = (player getVariable format['rep%1',_town]) * -1;
_idx = lbCurSel 1500;
_sellcls = lbData [1500,_idx];

if(isNil "_sellcls" or _sellcls == "") exitWith {OT_selling = false};

_price = [_town,_sellcls,_standing] call OT_fnc_getSellPrice;
_done = false;
_mynum = 0;

if(isNil "_price") exitWith {OT_selling = false};

_qty = 0;
{
	_c = _x select 0;
	if(_c == _sellcls) exitWith {_qty = _x select 1};				
}foreach(player call OT_fnc_unitStock);

if(_qty == 0) exitWith {[_mystock,_town,_standing,_s] call sellDialog};

{
	_c = _x select 0;
	if(_c == _sellcls) exitWith {_mynum = _x select 1};				
}foreach(_s);
			
if(_mynum > 50) then {
	_price = ceil(_price * 0.75);
};
if(_mynum > 100) then {
	_price = ceil(_price * 0.6);
};
if(_mynum > 200) then {
	_price = ceil(_price * 0.5);
};
if(_price <= 0) then {_price = 1};

_done = false;
_stockidx = 0;
{	
	if(((_x select 0) == _sellcls) && ((_x select 1) > 0)) exitWith {
		_num = (_x select 1)+_qty;		
		_x set [1,_num];
		_done = true;
	};
	_stockidx = _stockidx + 1;
}foreach(_s);

if !(_done) then {
	_s pushback [_sellcls,_qty];
};

[(_price*_qty)] call money;
_ocls = _sellcls;
_b setVariable ["stock",_s,true];
for "_i" from 0 to _qty do {
	if(OT_hasTFAR) then {
		_c = _ocls splitString "_";
		if((_c select 0) == "tf") then {
			{			
				if(_x find _ocls == 0) exitWith {_sellcls = _x};
			}foreach(items player);
		};
	};	
	player removeItem _sellcls;
};


OT_selling = false;
_mystock = player call OT_fnc_unitStock;
lbClear 1500;
[_mystock,_town,_standing,_s] call sellDialog;
