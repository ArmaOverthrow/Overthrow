private ["_town","_cls","_cost","_baseprice","_stability"];

_town = _this select 0;
_cls = _this select 1;
_standing = _this select 2;
_price = 0;

private _trade = player getvariable ["OT_trade",1];
private _discount = 0;
if(_trade > 1) then {
	_discount = 0.02 * (_trade - 1);
};

if((_town in OT_allTowns) and _cls in (OT_allWeapons + OT_allMagazines + OT_illegalItems + OT_allStaticBackpacks)) then {
	_stock = server getVariable format["gunstock%1",_town];
	{
		if((_x select 0) == _cls) exitWith {_price = _x select 1};
	}foreach(_stock);
}else{
	_cost = cost getVariable [_cls,[10,0,0,0]];
	_baseprice = _cost select 0;

	_stability = 1.0 - ((server getVariable [format["stability%1",_town],100]) / 100);

	if(_cls == "WAGE") then {
		_stability = ((server getVariable [format["stability%1",_town],100]) / 100);
	};

	_population = server getVariable [format["population%1",_town],1000];
	if(_town == OT_nation) then {_population = 100};
	if(_population > 2000) then {_population = 2000};
	_population = 1-(_population / 2000);
	if(_cls == "WAGE" and _town != OT_nation) then {
		_population = (_population / 2000);
	};

	if(_standing < -100) then {_standing = -100};
	if(_standing > 100) then {_standing = 100};
	if(_standing == 0) then {_standing = 1};
	_standing = (_standing/100);
	_discount = _discount + (_standing * 0.2);

	_price = _baseprice + (_baseprice + (_baseprice * _stability * _population) * (1+OT_standardMarkup));
	if(_cls == "FUEL") then {
		_price = _price - 9;
	};
};

round(_price - (_price * _discount))
