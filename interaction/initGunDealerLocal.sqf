_civ = _this;

_civ addAction ["Buy Weapon", {	
	_town = (getpos player) call nearestTown; 

	_stock = server getVariable format["gunstock%1",_town];
	if(isNil "_stock") then {
		_basic = cost getVariable AIT_item_BasicGun;
		_stock = [[AIT_item_BasicGun,(_basic select 0) + round(random 12)]];
		_numguns = round(random 5)+1;
		_count = 0;
		_tostock = [AIT_item_BasicGun];
		
		_base = [AIT_item_BasicGun] call BIS_fnc_baseWeapon;
		_magazines = getArray (configFile / "CfgWeapons" / _base / "magazines");
		{
			_stock pushBack [_x,2];
		}foreach(_magazines);
		
		while {_count < _numguns} do {
			_type = AIT_allWeapons call BIS_fnc_selectRandom;
			if !(_type in _tostock) then {
				
				_tostock pushBack _type;
				_count = _count + 1;
				_cost = cost getVariable _type;
				_price = round((_cost select 0) * ((random 2) + 1));
				_stock pushBack [_type,_price];
				
				_base = [_type] call BIS_fnc_baseWeapon;
				_magazines = getArray (configFile / "CfgWeapons" / _base / "magazines");
				_stock pushBack [_magazines select 0,2];				
			};
		};
		server setVariable [format["gunstock%1",_town],_stock,true];
	};
	
	createDialog "AIT_dialog_buy";
	{			
		_cls = _x select 0;
		_price = _x select 1;
		_txt = _cls;
		if(_cls in AIT_allMagazines) then {	
			_txt = format["--- %1",_cls call ISSE_Cfg_Magazine_GetName];
		}else{
			_txt = _cls call ISSE_Cfg_Weapons_GetName;
		};
		_idx = lbAdd [1500,format["%1 ($%2)",_txt,_price]];
		lbSetData [1500,_idx,_cls];
	}foreach(_stock);
	
},nil,1.5,false,true,"","",5];