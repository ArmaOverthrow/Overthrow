private ["_items","_myitems"];

_items = [];
_done = [];

_myitems = [];

if(_this isKindOf "Man") then {
	_myitems = (items _this) + (magazines _this);
}else{
	_myitems = (itemCargo _this) + (weaponCargo _this) + (magazineCargo _this) + (backpackCargo _this);	
};
if !(isNil "_myitems") then {
	{
		_cls = _x;
		if(OT_hasTFAR) then {
			_c = _cls splitString "_";
			if((_c select 0) == "tf") then {
				_cls = "tf";
				{
					if(_forEachIndex == (count _c)-1) exitWith {};
					if(_forEachIndex != 0) then {
						_cls = format["%1_%2",_cls,_x];
					};
				}foreach(_c);
			};
		};
		if !(_cls in _done) then {
			_done pushback _cls;
			_items pushback [_cls,1];
		}else {
			{
				if((_x select 0) == _cls) then {
					_x set [1,(_x select 1)+1];				
				};
			}foreach(_items);
		};
	}foreach(_myitems);
};
_items;