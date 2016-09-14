private _ob = _this select 0;
private _items = _this select 1;
_stash = _ob getVariable["stashed",[]];
{
	_cls = _x select 0;
	_qty = _x select 1;	
	_f = false;
	{
		
		if((_x select 0) == _cls) exitWith {
			_x set [1,(_x select 1)+_qty];
			_f = true;
		};
	}foreach(_stash);
	if !(_f) then {
		_stash pushback _x;
	};
}foreach(_items);
_ob setVariable ["stashed",_stash,true];