private ["_b","_s","_town","_standing","_cls","_num","_price","_idx","_done"];
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
_cls = lbData [1500,_idx];

if(isNil "_cls" or _cls == "") exitWith {OT_selling = false};

_price = [_town,_cls,_standing] call OT_fnc_getSellPrice;
_done = false;
_mynum = 0;

if(isNil "_price") exitWith {OT_selling = false};

{
	_c = _x select 0;
	if(_c == _cls) exitWith {_mynum = _x select 1};
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

_stockidx = 0;
{
	if(((_x select 0) == _cls) && ((_x select 1) > 0)) exitWith {
		_num = (_x select 1)+1;
		_x set [1,_num];
		_done = true;
	};
	_stockidx = _stockidx + 1;
}foreach(_s);

if !(_done) then {
	_s pushback [_cls,1];
};

[_price] call money;
_b setVariable ["stock",_s,true];

if(_price > 1000) then {[_town,1] call OT_fnc_standing};

if(OT_hasTFAR) then {
	_c = _cls splitString "_";
	if((_c select 0) == "tf") then {
		{
			if(_x find _cls == 0) exitWith {_cls = _x};
		}foreach(items player);
	};
};
player removeItem _cls;
lbClear 1500;
_mystock = player call OT_fnc_unitStock;
[_mystock,_town,_standing,_s] call OT_fnc_sellDialog;
OT_selling = false;
