params ["_town","_cls",["_standing",0]];
private _price = 0;

private _trade = player getvariable ["OT_trade",1];
private _discount = 0;
if(_trade > 1) then {
	_discount = 0.02 * (_trade - 1);
};

private _cost = cost getVariable [_cls,[10,0,0,0]];
private _baseprice = _cost select 0;

private _stability = 1.0 - ((server getVariable [format["stability%1",_town],100]) / 100);

if(_cls isEqualTo "WAGE") then {
	_stability = ((server getVariable [format["stability%1",_town],100]) / 100);
};

_population = server getVariable [format["population%1",_town],1000];
if(_town isEqualTo OT_nation) then {_population = 100};
if(_population > 2000) then {_population = 2000};
_population = 1-(_population / 2000);
if(_cls == "WAGE" && _town != OT_nation) then {
	_population = (_population / 2000);
};

if(_standing < -100) then {_standing = -100};
if(_standing > 100) then {_standing = 100};
if(_standing isEqualTo 0) then {_standing = 1};
_standing = (_standing/100);
_discount = _discount + (_standing * 0.2);

_price = _baseprice + (_baseprice + (_baseprice * _stability * _population) * (1+OT_standardMarkup));
if(_cls isEqualTo "FUEL") then {
	_price = _price - 9;
};

round(_price - (_price * _discount))
