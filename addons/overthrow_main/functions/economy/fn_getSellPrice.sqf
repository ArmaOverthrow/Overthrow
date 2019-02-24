private ["_town","_cls","_cost","_baseprice","_stability"];

_town = _this select 0;
_cls = _this select 1;
_standing = _this select 2;
_price = 0;


if(_cls in (OT_allWeapons + OT_allMagazines) && (_town in OT_allTowns)) then {
	_stock = server getVariable format["gunstock%1",_town];
	{
		if((_x select 0) isEqualTo _cls) exitWith {_price = _x select 1};
	}foreach(_stock);
}else{
	_cost = cost getVariable [_cls,[10,0,0,0]];
	_baseprice = _cost select 0;

	_stability = 1.0 - ((server getVariable [format["stability%1",_town],100]) / 100);
	_population = server getVariable [format["population%1",_town],1000];
	if(_population > 1000) then {_population = 1000};
	_population = 1-(_population / 1000);

	if(_standing < -100) then {_standing = -100};
	if(_standing > 100) then {_standing = 100};
	if(_standing isEqualTo 0) then {_standing = 1};
	_standing = (_standing/100)+1;

	_price = _baseprice + ((_baseprice * 0.55) + (_baseprice * _stability * _population));
};


if(_price < 0) then {_price = 1};

round(_price)
