private _cls = _this;
private _d = [];
{
	_x params ["_name"];
	if(_name == _cls) exitWith {
		_d = _x;
	};
}foreach(OT_Squadables);

_d params ["_name","_comp","_shortname"];
private _soldiers = [];
private _cost = 0;
private _totalitems = [];
{
	_soldier = _x call OT_fnc_getSoldier;
	_totalitems = _totalitems + _soldier#4;
	_soldiers pushback _soldier;
}foreach(_comp);
private _bought = [];
{
	_x params ["_cls","_num"];
	_whqty = _cls call OT_fnc_qtyInWarehouse;
	if(_whqty < _num) then {_num = _num - _whqty} else {_num = 0};
	if(_num > 0) then {
		_cost = _cost + (([OT_nation,_cls,30] call OT_fnc_getPrice) * _num);
		_bought pushback [_cls,_num];
	};
}foreach(_totalitems call BIS_fnc_consolidateArray);

[_cost,_soldiers,_bought,_shortname]
