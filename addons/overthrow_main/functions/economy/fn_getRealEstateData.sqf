private _town = "";
private _type = "";
if(typename _this isEqualTo "ARRAY") then {
	_type = _this select 0;
	_town = _this select 1;
}else{
	_type = typeof _this;
	_town = (getpos _this) call OT_fnc_nearestTown;
};

if(isNil "_town") exitWith {[-1,-1,-1,-1]};
private _stability = ((server getVariable format["stability%1",_town]) / 100);
private _population = server getVariable format["population%1",_town];
if(_population > 1000) then {_population = 1000};
if(_population < 300) then {_population = 300};
_population = (_population / 1000);

([_type] call {
	params ["_type"];
	if (_type in OT_spawnHouses) exitWith {[]};
	if(_type in OT_lowPopHouses) exitWith {[1000,8]};
	if(_type in OT_mansions) exitWith {[50000,10]};
	if(_type in OT_medPopHouses) exitWith {[2000,12,0.2]};
	if(_type in OT_highPopHouses) exitWith {[15000,15,0.15]};
	if(_type in OT_hugePopHouses) exitWith {[50000,40,0.06]};
	if(_type == OT_warehouse) exitWith {[3000,0]};
	[]
}) params [["_baseprice", 400],["_totaloccupants",4],["_multiplier",0.35]];

private _price = round(_baseprice + ((_baseprice * _stability * _population) * (1+OT_standardMarkup)));
private _sell = round(_baseprice + (_baseprice * _stability * _population));
private _lease = round((_stability * _population) * ((_baseprice * _multiplier) * _totaloccupants * 0.3));
if !(_town in (server getvariable ["NATOabandoned",[]])) then {_lease = round(_lease * 0.2)};
private _diff = server getVariable ["OT_difficulty",1];
if(_diff isEqualTo 0) then {_lease = round(_lease * 1.2)};
if(_diff isEqualTo 2) then {_lease = round(_lease * 0.8)};
if(_lease < 1) then {_lease = 1};
[_price,_sell,_lease,_totaloccupants]
