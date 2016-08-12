private ["_items","_myitems"];

_items = [];
_done = [];

_myitems = [];

_myitems = items _this;
if(count _myitems == 0) then {
	_myitems = (itemCargo _this) + (weaponCargo _this) + (magazineCargo _this) + (backpackCargo _this);
};
if !(isNil "_myitems") then {
	{
		if !(_x in _done) then {
			_done pushback _x;
			_items pushback [_x,1];
		}else {
			_cls = _x;
			{
				if((_x select 0) == _cls) then {
					_x set [1,(_x select 1)+1];				
				};
			}foreach(_items);
		};
	}foreach(_myitems);
};
_items;