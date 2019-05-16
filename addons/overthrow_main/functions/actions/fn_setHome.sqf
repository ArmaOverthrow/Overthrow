private _b = player call OT_fnc_nearestRealEstate;
private _building = objNull;
if(typename _b isEqualTo "ARRAY") then {
	_building = (_b select 0);
};
if((typeof _building) in OT_allRepairableRuins) exitWith {
	private _ruins = [];
	private _type = (typeof _building);
	{
		_x params ["_ruinClass"];
		if(_type isEqualTo _ruinClass) exitWith {_ruins = _x};
	}foreach(OT_repairableRuins);

	if((count _ruins) > 0) then {
		_ruins params ["_ruinClass","_buildClass","_price"];
		_money = player getVariable ["money",0];
		if(_money >= _price) then {
			[-_price] call OT_fnc_money;
			_id = [_building] call OT_fnc_getBuildID;
			_damaged = owners getVariable ["damagedBuildings",[]];
			if(_id in _damaged) then {
				_damaged deleteAt (_damaged find _id);
				owners setVariable ["damagedBuildings",_damaged,true];
			};
			_pos = getPosATL _building;
			_dir = [vectorDir _building,vectorUp _building];
			deleteVehicle _building;
			_veh = createVehicle [_buildClass, _pos, [], 0, "CAN_COLLIDE"];
			_veh enableDynamicSimulation true;
			_veh setVectorDirAndUp _dir;
			_veh setPosATL _pos;
			[_veh,getPlayerUID player] call OT_fnc_setOwner;
		}else{
			format["You need $%1 to repair this building",[_price, 1, 0, true] call CBA_fnc_formatNumber];
		};
	};
};
if(typeof _building isEqualTo OT_warehouse) exitWith {
	_price =  round((_b select 1) * 0.25);
	_money = player getVariable ["money",0];
	if(_money >= _price) then {
		[-_price] call OT_fnc_money;
		_building setDamage 0;
		_id = [_building] call OT_fnc_getBuildID;
		_damaged = owners getVariable ["damagedBuildings",[]];
		if(_id in _damaged) then {
			_damaged deleteAt (_damaged find _id);
			owners setVariable ["damagedBuildings",_damaged,true];
		}
	}else{
		format["You need $%1 to repair this warehouse",[_price, 1, 0, true] call CBA_fnc_formatNumber];
	};
};

if !(captive player) exitWith {"You cannot set home while wanted" call OT_fnc_notifyMinor};
private _handled = false;
private _owner = _building call OT_fnc_getOwner;
if(!isNil "_owner") then {
	if ((typeof _building) in OT_allBuyableBuildings && _owner isEqualTo getplayerUID player) exitWith {
		_handled = true;
		player setVariable ["home",getpos _building,true];
		"This is now your home" call OT_fnc_notifyMinor;
	};
};


if !(_handled) then {
	"You don't own any buildings nearby" call OT_fnc_notifyMinor;
};
