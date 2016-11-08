private ["_b","_s","_town","_standing","_cls","_num","_price","_idx"];
_idx = lbCurSel 1500;
_cls = lbData [1500,_idx];

_town = (getPos player) call nearestTown;
_standing = player getVariable format['rep%1',_town];

_price = [_town,_cls,_standing] call getPrice;

_money = player getVariable "money";
if(_money < _price) exitWith {"You cannot afford that!" call notify_minor};

call {
	if(_cls == OT_item_UAV) exitWith {	
		_pos = (getpos player) findEmptyPosition [5,100,_cls];
		if (count _pos == 0) exitWith {"Not enough space, please clear an area nearby" call notify_minor};
		
		player setVariable ["money",_money-_price,true];
		
		_veh = createVehicle [_cls, _pos, [], 0,""];  
		_crew = createVehicleCrew _veh; 
		{
			_x setVariable ["owner",getplayeruid player,true];
		}foreach(crew _veh);
		
		_veh setVariable ["owner",getPlayerUID player,true];

		if("ItemGPS" in (assignedItems player)) then {
			player addItem OT_item_UAVterminal;
		}else{
			if !(OT_item_UAVterminal in (assignedItems player)) then {
				player linkItem OT_item_UAVterminal;
			};
		};
		
		player connectTerminalToUAV _veh;
		
		player reveal _veh;
		format["You bought a Quadcopter",_cls call ISSE_Cfg_Vehicle_GetName] call notify_minor;
		playSound "3DEN_notificationDefault";
		hint "To use a UAV, scroll your mouse wheel to 'Open UAV Terminal' then right click your green copter on the ground and 'Connect terminal to UAV'";
	};
	if(_cls isKindOf "LandVehicle") exitWith {	
		_pos = (getpos player) findEmptyPosition [5,100,_cls];
		if (count _pos == 0) exitWith {"Not enough space, please clear an area nearby" call notify_minor};
		
		player setVariable ["money",_money-_price,true];
		_veh = _cls createVehicle _pos;
		_veh setVariable ["owner",getPlayerUID player,true];
		clearWeaponCargoGlobal _veh;
		clearMagazineCargoGlobal _veh;
		clearBackpackCargoGlobal _veh;
		clearItemCargoGlobal _veh;	
		
		player reveal _veh;
		format["You bought a %1",_cls call ISSE_Cfg_Vehicle_GetName] call notify_minor;
		playSound "3DEN_notificationDefault";
	};
	if(_cls isKindOf "Ship") exitWith {	
		_pos = (getpos player) findEmptyPosition [5,100,_cls];
		if (count _pos == 0) exitWith {"Not enough space, please clear an area nearby" call notify_minor};
		
		player setVariable ["money",_money-_price,true];
		_veh = _cls createVehicle _pos;
		_veh setVariable ["owner",getPlayerUID player,true];
		clearWeaponCargoGlobal _veh;
		clearMagazineCargoGlobal _veh;
		clearBackpackCargoGlobal _veh;
		clearItemCargoGlobal _veh;	
		
		player reveal _veh;
		format["You bought a %1",_cls call ISSE_Cfg_Vehicle_GetName] call notify_minor;
		playSound "3DEN_notificationDefault";
	};
	if(_cls in OT_allClothing) exitWith {
		player setVariable ["money",_money-_price,true];

		if(backpack player != "") then {
			player addItem _cls;
		}else{
			player forceAddUniform _cls;
		};
		playSound "3DEN_notificationDefault";
	};
	if((_cls isKindOf ["Launcher",configFile >> "CfgWeapons"]) or (_cls isKindOf ["Rifle",configFile >> "CfgWeapons"])) exitWith {
		player setVariable ["money",_money-_price,true];

		_box = false;
		{
			_owner = _x getVariable "owner";
			if(!isNil "_owner") then {
				if(_owner == getplayerUID player) exitWith {_box = _x};				
			};
		}foreach(nearestObjects [getpos player, [OT_item_Storage],1200]);
		if(typename _box == "OBJECT") then {
			_box addWeaponCargo [_cls,1];
			"Delivered to your closest ammobox" call notify_minor;
		}else{
			player addWeapon _cls;
		};	
		playSound "3DEN_notificationDefault";
	};
	if(_cls isKindOf ["CA_Magazine",configFile >> "CfgMagazines"]) exitWith {	
		player setVariable ["money",_money-_price,true];
		player addMagazine _cls;		
		playSound "3DEN_notificationDefault";
	};
	_handled = true;
	if(_cls isKindOf "Bag_Base") then {	
		if(backpack player != "") exitWith {"You already have a backpack" call notify_minor;_handled = false};
	}else{
		if!([player,_cls] call canFit) exitWith {"There is not enough room in your inventory" call notify_minor;_handled = false};
	};
		
	if(_handled) then {	
		playSound "3DEN_notificationDefault";
		if (_cls in OT_illegalItems) exitWith {
			player setVariable ["money",_money-_price,true];
			player addItem _cls;
		};
		if (_cls in OT_allStaticBackpacks) exitWith {
			player setVariable ["money",_money-_price,true];
			player addBackpack _cls;
		};
		_b = player getVariable ["shopping",objNull];
		_bp = _b getVariable "shop";
		
		_s = [];
		_active = server getVariable [format["activeshopsin%1",_town],[]];
		{
			_pos = _x select 0;
			if(format["%1",_pos] == _bp) exitWith {
				_s = _x select 1;
			};
		}foreach(_active);
	
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
			server setVariable [format["activeshopsin%1",_town],_active,true];	
			if(_cls isKindOf "Bag_Base") then {	
				player addBackpack _cls;
			}else{
				player addItem _cls;
			};
			_s = [];					
			{
				_pos = _x select 0;
				if(format["%1",_pos] == _bp) exitWith {
					_s = _x select 1;
				};
			}foreach(server getVariable [format["activeshopsin%1",_town],[]]);
			[_town,_standing,_s] call buyDialog;
		};
	};
};


