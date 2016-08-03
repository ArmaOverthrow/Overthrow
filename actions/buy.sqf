private ["_b","_s","_town","_standing","_cls","_num","_price","_idx"];
_idx = lbCurSel 1500;
_cls = lbData [1500,_idx];

_town = text ((nearestLocations [ getPos player, ["NameCityCapital","NameCity","NameVillage","CityCenter"],1000]) select 0); 
_standing = player getVariable format['rep%1',_town];

_price = [_town,_cls,_standing] call getPrice;

_money = player getVariable "money";
if(_money < _price) exitWith {hint "You cannot afford that!"};

playSound "3DEN_notificationDefault";
if(_cls in AIT_allVehicles) then {	
	_pos = (getpos player) findEmptyPosition [5,100,_cls];
	if (count _pos == 0) exitWith {hint "Not enough space, please clear an area nearby"};
	
	player setVariable ["money",_money-_price,true];
	_veh = _cls createVehicle _pos;
	_veh setVariable ["owner",player,true];
	clearWeaponCargoGlobal _veh;
	clearMagazineCargoGlobal _veh;
	clearBackpackCargoGlobal _veh;
	clearItemCargoGlobal _veh;	
	
	player reveal _veh;
	hint format["You bought a %1",_cls call ISSE_Cfg_Vehicle_GetName];
	
}else{
	if(_cls in AIT_allWeapons) then {
		_stock = server getVariable format["gunstock%1",_town];
		_idx = 0;
		{
			if((_x select 0) == _cls) exitWith {}; 
			_idx = _idx + 1;
		}foreach(_stock);
		_stock deleteAt _idx;
		server setVariable [format["gunstock%1",_town],_stock,true];
		player setVariable ["money",_money-_price,true];
		
		_house = player getVariable "home";
		_box =  (nearestObjects [getpos _house, AIT_items_Storage,50]) select 0;
		_box addWeaponCargo [_cls,1];
		hint "All weapons and ammo are delivered to your ammobox";
	}else{
		if(_cls in AIT_allMagazines) then {	
			player setVariable ["money",_money-_price,true];
			
			_house = player getVariable "home";
			_box =  (nearestObjects [getpos _house, AIT_items_Storage,50]) select 0;
			_box addMagazineCargo [_cls,1];
			hint "All weapons and ammo are delivered to your ammobox";
		}else{
			_b = nearestBuilding getPos player;
			_s = _b getVariable "stock";
			
			if!([player,_cls] call canFit) exitWith {hint "There is not enough room in your inventory"};

			_done = false;
			_soldout = false;
			_stockidx = 0;
			{	
				if(((_x select 0) == _cls) && ((_x select 1) > 0)) exitWith {
					_num = (_x select 1)-1;		
					if(_num == 0) then {
						_soldout = true;
					};
					_x set [1,_num];
					_done = true;
				};
				_stockidx = _stockidx + 1;
			}foreach(_s);

			if(_done) then {	
				if(_soldout) then {
					_s deleteAt _stockidx;
				};
				player setVariable ["money",_money-_price,true];
				_b setVariable ["stock",_s,true];	
				player addItem _cls;
				lbClear 1500;
				{			
					_cls = _x select 0;
					_num = _x select 1;
					_price = [_town,_cls,_standing] call getPrice;
					_idx = lbAdd [1500,format["%1 x %2 ($%3)",_num,_cls call ISSE_Cfg_Weapons_GetName,_price]];
					lbSetData [1500,_idx,_cls];
				}foreach(_s);
			};
		}
	}
}


