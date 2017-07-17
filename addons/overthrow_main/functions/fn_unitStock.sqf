private _items = [];
private _done = [];
private _category = "";
private _target = _this;
private _categoryItems = [];


if(typename _this == "ARRAY") then {
	_category = _this select 1;
	_target = _this select 0;

	if(_category == "Hardware") then {
		_categoryItems = ["OT_Steel","OT_Wood","OT_Plastic","OT_Fertilizer"];
	};
	if(_category == "Clothing") then {
		_categoryItems = OT_allLegalClothing + OT_allGlasses + OT_allGoggles + OT_allFacewear;
	};
	{
		if((_x select 0) == _category) exitWith {
			{
				_categoryItems pushback _x;
			}foreach(_x select 1);
		};
	}foreach(OT_items);
};

private _allCargo = {
	private _myitems = [];
	if(_target isKindOf "Man") then {
		_myitems = (items _target) + (magazines _target);
	}else{
		_myitems = (itemCargo _target) + (magazineCargo _target) + (backpackCargo _target);
		{
			{
				if(typename _x == "STRING") then {
					if !(_x isEqualTo "") then {
						if((_x call BIS_fnc_itemType) select 0 == "Weapon") then {
							_myitems pushback (_x call BIS_fnc_baseWeapon);
						}else{
							_myitems pushback _x;
						};
					};
				};
				if(typename _x == "ARRAY") then {
					if !((_x select 0) isEqualTo "") then {
						_myitems pushback (_x select 0);
					};
				};
			}foreach(_x);
		}foreach(weaponsItemsCargo _target);
		{
			_x params ["_itemcls","_item"];
			_myitems = _myitems + (itemCargo _item) + (magazineCargo _item) + (backpackCargo _item) + (weaponCargo _item);
		}foreach(everyContainer _target);
	};
	if(isnil "_myitems") then {_myitems = []};
	_myitems
};

private _theseitems = _target call _allCargo;
if !(isNil "_theseitems") then {
	{
		private _cls = _x;
		if(_category == "" or _cls in _categoryItems) then {
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
		};
	}foreach(_theseitems);
};
_items;
