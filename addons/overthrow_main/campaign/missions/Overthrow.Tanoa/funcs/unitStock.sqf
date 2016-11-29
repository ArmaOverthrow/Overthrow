private _items = [];
private _done = [];

private _allCargo = {
	private _myitems = [];
	if(_this isKindOf "Man") then {
		_myitems = (items _this) + (magazines _this);
	}else{	
		_myitems = (itemCargo _this) + (magazineCargo _this) + (backpackCargo _this);
		{
			{
				if(typename _x == "STRING") then {
					if !(_x isEqualTo "") then {
						_myitems pushback _x;
					};
				};
			}foreach(_x);
		}foreach(weaponsItemsCargo _this);
		{
			_x params ["_itemcls","_item"];
			_myitems = _myitems + (_item call _allCargo);
		}foreach(everyContainer _this);
	};
	_myitems
};

private _theseitems = _this call _allCargo;
if !(isNil "_theseitems") then {
	{
		private _cls = _x;
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
	}foreach(_theseitems);
};
_items;