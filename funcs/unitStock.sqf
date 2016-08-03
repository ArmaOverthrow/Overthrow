_items = [];
_done = [];
{
	if !(_x in _done) then {
		_items pushback [_x,1];
		_done pushback _x
	}else {
		_cls = _x;
		{
			if((_x select 0) == _cls) then {
				_x set [1,(_x select 1)+1];				
			};
		}foreach(_items);
	};
}foreach(items _this);

_items;