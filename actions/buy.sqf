private ["_b","_s","_town","_standing","_cls","_num","_price","_idx"];
_idx = lbCurSel 1500;
_cls = lbData [1500,_idx];

_town = text ((nearestLocations [ getPos player, ["NameCityCapital","NameCity","NameVillage","CityCenter"],1000]) select 0); 
_standing = player getVariable format['rep%1',_town];

_price = [_town,_cls,_standing] call getPrice;

_money = player getVariable "money";
if(_money < _price) exitWith {"You cannot afford that!" call notify_minor};

playSound "ClickSoft";
if(_cls in AIT_allVehicles) then {	
	_pos = (getpos player) findEmptyPosition [5,100,_cls];
	if (count _pos == 0) exitWith {"Not enough space, please clear an area nearby" call notify_minor};
	
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
		player setVariable ["money",_money-_price,true];

		_box = false;
		{
			_owner = _x getVariable "owner";
			if(!isNil "_owner") then {
				if(_owner == player) exitWith {_box = _x};				
			};
		}foreach(nearestObjects [getpos player, [AIT_item_Storage],1200]);
		if(typename _box == "OBJECT") then {
			_box addWeaponCargo [_cls,1];
			"Delivered to your closest ammobox" call notify_minor;
		}else{
			player addWeapon _cls;
		};		
	}else{
		if(_cls in AIT_allMagazines) then {	
			player setVariable ["money",_money-_price,true];
			
			_house = player getVariable "home";
			_box = false;
			{
				_owner = _x getVariable "owner";
				if(!isNil "_owner") then {
					if(_owner == player) exitWith {_box = _x};				
				};
			}foreach(nearestObjects [getpos player, [AIT_item_Storage],1200]);
			if(typename _box == "OBJECT") then {
				_box addMagazineCargo [_cls,1];
				"Delivered to your closest ammobox" call notify_minor;
			}else{
				player addMagazine _cls;
			};		
		}else{					
			_b = nearestBuilding getPos player;
			_s = _b getVariable "stock";
			
			if(_cls in AIT_allBackpacks) then {	
				if(backpack player != "") exitWith {"You already have a backpack" call notify_minor};
			}else{
				if!([player,_cls] call canFit) exitWith {"There is not enough room in your inventory" call notify_minor};
			};
			if (_cls in AIT_illegalItems) exitWith {
				player setVariable ["money",_money-_price,true];
				player addItem _cls;
			};
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
				if(_cls in AIT_allBackpacks) then {	
					player addBackpack _cls;
				}else{
					player addItem _cls;
				};
				
				lbClear 1500;
				{			
					_cls = _x select 0;
					_num = _x select 1;
					_name = "";
					if(_cls in AIT_allBackpacks) then {
						_name = _cls call ISSE_Cfg_Vehicle_GetName;
					}else{
						_name = _cls call ISSE_Cfg_Weapons_GetName;
					};
					_price = [_town,_cls,_standing] call getPrice;
					_idx = lbAdd [1500,format["%1 x %2 ($%3)",_num,_name,_price]];
					lbSetData [1500,_idx,_cls];
				}foreach(_s);
			};
		}		
	}
}


