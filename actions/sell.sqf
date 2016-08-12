private ["_b","_s","_town","_standing","_cls","_num","_price","_idx","_done"];

playSound "ClickSoft";
_b = player getVariable "shopping";
_s = _b getVariable "stock";
_town = (getpos player) call nearestTown;
_standing = (player getVariable format['rep%1',_town]) * -1;
_idx = lbCurSel 1500;
_cls = lbData [1500,_idx];

_price = [_town,_cls,_standing] call getSellPrice;
_done = false;
_mynum = 0;
_s = _b getVariable "stock";
{
	_c = _x select 0;
	if(_c == _cls) exitWith {_mynum = _x select 1};				
}foreach(_s);
			
if(_mynum > 10) then {
	_price = ceil(_price * 0.75);
};
if(_mynum > 20) then {
	_price = ceil(_price * 0.5);
};
if(_mynum > 50) then {
	_price = 1;
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

_money = player getVariable "money";

player setVariable ["money",_money+_price,true];
_b setVariable ["stock",_s,true];	
player removeItem _cls;
lbClear 1500;
_mystock = player call unitStock;
{			
	_cls = _x select 0;
	if!(_cls in AIT_allMagazines + AIT_illegalItems + AIT_illegalHeadgear + AIT_illegalVests + AIT_allWeapons) then {
		_num = _x select 1;
		_price = [_town,_cls,_standing] call getSellPrice;
		
		_s = _b getVariable "stock";
		{
			_c = _x select 0;
			if(_c == _cls) exitWith {_mynum = _x select 1};				
		}foreach(_s);
					
		if(_mynum > 10) then {
			_price = ceil(_price * 0.75);
		};
		if(_mynum > 20) then {
			_price = ceil(_price * 0.5);
		};
		if(_mynum > 50) then {
			_price = 1;
		};
		if(_price <= 0) then {_price = 1};
		
		_idx = lbAdd [1500,format["%1 x %2 ($%3)",_num,_cls call ISSE_Cfg_Weapons_GetName,_price]];
		lbSetData [1500,_idx,_cls];
	};	
}foreach(_mystock);
