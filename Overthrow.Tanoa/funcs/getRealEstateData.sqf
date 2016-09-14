private _town = (getpos _this) call nearestTown;
private _stability = ((server getVariable format["stability%1",_town]) / 100);
private _population = server getVariable format["population%1",_town];
if(_population > 1000) then {_population = 1000};
_population = (_population / 1000);
private _totaloccupants = 1;
		
private _baseprice = 400;
private _type = typeof _this;
if !(_type in AIT_spawnHouses) then {
	call {
		if(_type in AIT_lowPopHouses) exitWith {_baseprice = 1000;_totaloccupants=4};
		if(_type in AIT_mansions) exitWith {_baseprice = 25000;_totaloccupants=5;};
		if(_type in AIT_medPopHouses) exitWith {_baseprice = 5000;_totaloccupants=6};
		if(_type in AIT_highPopHouses) exitWith {_baseprice = 5000;_totaloccupants=12};
		if(_type in AIT_hugePopHouses) exitWith {_baseprice = 5000;_totaloccupants=50};
	};				
};
private _price = round(_baseprice + ((_baseprice * _stability * _population) * (1+AIT_standardMarkup)));
private _sell = round(_baseprice + (_baseprice * _stability * _population));
private _lease = round((_stability * _population) * (_baseprice * 0.15));
[_price,_sell,_lease,_totaloccupants]