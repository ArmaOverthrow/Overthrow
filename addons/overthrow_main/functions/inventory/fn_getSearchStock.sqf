private ["_items","_myitems"];

_items = [];
_done = [];

_myitems = [];

if(_this isKindOf "Man") then {
	_myitems = (items _this) + (magazines _this);
}else{
	_myitems = (itemCargo _this) + (weaponCargo _this) + (magazineCargo _this) + (backpackCargo _this);
	{
		_myitems = [_myitems,(items _this) + (magazines _this)] call BIS_fnc_arrayPushStack;
	}foreach(units _this);		
};
if !(isNil "_myitems") then {
	{
		if !(_x in _done) then {
			_done pushback _x;
			_items pushback [_x,1];
		}else {
			_cls = _x;
			{
				if((_x select 0) isEqualTo _cls) then {
					_x set [1,(_x select 1)+1];				
				};
			}foreach(_items);
		};
	}foreach(_myitems);
};
_items;