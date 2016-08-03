private ["_town","_cls","_cost","_baseprice","_stability"];

_town = _this select 0;
_cls = _this select 1;
_standing = _this select 2;
_price = 0;


if(_cls in (AIT_allWeapons + AIT_allMagazines)) then {
	_stock = server getVariable format["gunstock%1",_town];
	{
		if((_x select 0) == _cls) exitWith {_price = _x select 1}; 
	}foreach(_stock);
}else{		
	_cost = cost getVariable _cls;
	_baseprice = _cost select 0;

	_stability = 1.0 - ((server getVariable format["stability%1",_town]) / 100);

	if(_standing < -100) then {_standing = -100};
	if(_standing > 100) then {_standing = 100};
	_standing = ((_standing/100) * -1)+1;

	_price = _baseprice + (_stability * _baseprice * _standing);
};

round(_price)
