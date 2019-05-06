private _idx = lbCurSel 1500;
private _cls = lbData [1500,_idx];

private _town = (getPos player) call OT_fnc_nearestTown;
private _standing = [_town] call OT_fnc_support;

private _price = lbValue [1500,_idx];
if(_price isEqualTo -1) exitWith {};

private _chems = server getVariable ["reschems",0];
private _cost = cost getVariable [_cls,[0,0,0,0]];
if(_cls in OT_allExplosives && _chems < (_cost select 3)) exitWith {format["You need %1 chemicals",_cost select 3] call OT_fnc_notifyMinor};

private _money = player getVariable "money";
if(_money < _price) exitWith {"You cannot afford that!" call OT_fnc_notifyMinor};


if(_cls == "Set_HMG") exitWith {
	private _pos = (getpos player) findEmptyPosition [5,100,"C_Quadbike_01_F"];
	if (count _pos == 0) exitWith {"Not enough space, please clear an area nearby" call OT_fnc_notifyMinor};

	player setVariable ["money",_money-_price,true];
	private _veh = "C_Quadbike_01_F" createVehicle _pos;
	[_veh,getPlayerUID player] call OT_fnc_setOwner;
	clearWeaponCargoGlobal _veh;
	clearMagazineCargoGlobal _veh;
	clearBackpackCargoGlobal _veh;
	clearItemCargoGlobal _veh;
	_veh addBackpackCargoGlobal ["I_HMG_01_high_weapon_F", 1];
	_veh addBackpackCargoGlobal ["I_HMG_01_support_high_F", 1];

	player reveal _veh;
	format["You bought a Quad Bike w/ HMG for $%1",_price] call OT_fnc_notifyMinor;
	playSound "3DEN_notificationDefault";
};
if(OT_interactingWith getVariable ["factionrep",false] && ((_cls isKindOf "Land") || (_cls isKindOf "Air"))) exitWith {
	private _blueprints = server getVariable ["GEURblueprints",[]];
	if !(_cls in _blueprints) then {
		_blueprints pushback _cls;
		server setVariable ["GEURblueprints",_blueprints,true];
		_factionName = OT_interactingWith getVariable ["factionrepname",""];
		format["%1 has bought %2 blueprint from %3",name player,_cls call OT_fnc_vehicleGetName,_factionName] remoteExec ["OT_fnc_notifyMinor",0,false];
		closeDialog 0;
	};
};
if(_cls isKindOf "Man") exitWith {
	[_cls,getpos player,group player] call OT_fnc_recruitSoldier;
};
if(_cls in OT_allSquads) exitWith {
	[_cls,getpos player] call OT_fnc_recruitSquad;
};
if(_cls == OT_item_UAV) exitWith {
	private _pos = (getpos player) findEmptyPosition [5,100,_cls];
	if (count _pos == 0) exitWith {"Not enough space, please clear an area nearby" call OT_fnc_notifyMinor};

	player setVariable ["money",_money-_price,true];

	private _veh = createVehicle [_cls, _pos, [], 0,""];
	_veh setVariable ["OT_spawntrack",true,true]; //Tells virtualization to track this vehicle like it's a player.
	private _crew = createVehicleCrew _veh;
	{
		[_x,getPlayerUID player] call OT_fnc_setOwner;
	}foreach(crew _veh);

	[_veh,getPlayerUID player] call OT_fnc_setOwner;

	if("ItemGPS" in (assignedItems player)) then {
		player addItem OT_item_UAVterminal;
	}else{
		if !(OT_item_UAVterminal in (assignedItems player)) then {
			player linkItem OT_item_UAVterminal;
		};
	};

	player connectTerminalToUAV _veh;

	player reveal _veh;
	format["You bought a Quadcopter",_cls call OT_fnc_vehicleGetName] call OT_fnc_notifyMinor;
	playSound "3DEN_notificationDefault";
	hint "To use a UAV, scroll your mouse wheel to 'Open UAV Terminal' then right click your green quadcopter on the ground and 'Connect terminal to UAV'";
};
if(_cls in OT_allVehicles) exitWith {
	private _pos = (getpos player) findEmptyPosition [5,100,_cls];
	if (count _pos == 0) exitWith {"Not enough space, please clear an area nearby" call OT_fnc_notifyMinor};

	player setVariable ["money",_money-_price,true];
	private _veh = _cls createVehicle _pos;
	[_veh,getPlayerUID player] call OT_fnc_setOwner;
	clearWeaponCargoGlobal _veh;
	clearMagazineCargoGlobal _veh;
	clearBackpackCargoGlobal _veh;
	clearItemCargoGlobal _veh;

	if(_cls == OT_vehType_service) then {
		_veh addItemCargoGlobal ["ToolKit", 1];
		[_veh,3,"ACE_Wheel"] call ace_repair_fnc_addSpareParts;
	};

	player reveal _veh;
	format["You bought a %1 for $%2",_cls call OT_fnc_vehicleGetName,_price] call OT_fnc_notifyMinor;
	playSound "3DEN_notificationDefault";
};
if(_cls isKindOf "Ship") exitWith {
	private _pos = (getpos player) findEmptyPosition [5,100,_cls];
	if (count _pos == 0) exitWith {"Not enough space, please clear an area nearby" call OT_fnc_notifyMinor};

	player setVariable ["money",_money-_price,true];
	private _veh = _cls createVehicle _pos;
	[_veh,getPlayerUID player] call OT_fnc_setOwner;
	clearWeaponCargoGlobal _veh;
	clearMagazineCargoGlobal _veh;
	clearBackpackCargoGlobal _veh;
	clearItemCargoGlobal _veh;

	player reveal _veh;
	format["You bought a %1",_cls call OT_fnc_vehicleGetName] call OT_fnc_notifyMinor;
	playSound "3DEN_notificationDefault";
};
if(_cls in OT_allClothing) exitWith {
	[-_price] call OT_fnc_money;

	if((backpack player != "") && (player canAdd _cls)) then {
		player addItemToBackpack _cls;
		"Clothing added to your backpack" call OT_fnc_notifyMinor;
	}else{
		player forceAddUniform _cls;
	};
	playSound "3DEN_notificationDefault";
};
if(_cls == "V_RebreatherIA") exitWith {
	[-_price] call OT_fnc_money;

	if((backpack player != "") && (player canAdd _cls)) then {
		player addItemToBackpack _cls;
		"Rebreather added to your backpack" call OT_fnc_notifyMinor;
	}else{
		player addVest _cls;
	};
	playSound "3DEN_notificationDefault";
};
if(
	(_cls isKindOf ["Launcher",configFile >> "CfgWeapons"])
	||
	(_cls isKindOf ["Rifle",configFile >> "CfgWeapons"])
	||
	(_cls isKindOf ["Pistol",configFile >> "CfgWeapons"])
) exitWith {
	[-_price] call OT_fnc_money;

	private _box = objNull;
	{
		private _owner = _x call OT_fnc_getOwner;
		if(!isNil "_owner") then {
			if(_owner == getplayerUID player) exitWith {_box = _x};
		};
	}foreach(nearestObjects [getpos player, [OT_item_Storage],1200]);

	// @todo probably add to box if possible
	player addWeapon _cls;

	playSound "3DEN_notificationDefault";
};
if(_cls isKindOf ["CA_Magazine",configFile >> "CfgMagazines"]) exitWith {
	if(_cls in OT_allExplosives) then {
		server setVariable ["reschems",_chems - (_cost select 3),true];
	};
	[-_price] call OT_fnc_money;
	player addMagazineGlobal _cls;
	playSound "3DEN_notificationDefault";
};
private _handled = true;
private _b = player getVariable ["OT_shopTarget","Self"];
if(_b != "Vehicle") then {
	if(_cls isKindOf "Bag_Base") then {
		if(backpack player != "") then {
			"You already have a backpack" call OT_fnc_notifyMinor;
			_handled = false;
		};
	}else{
		if !(player canAdd [_cls,1]) then {
			"There is not enough room in your inventory" call OT_fnc_notifyMinor;
			_handled = false;
		};
	};
}else{
	_veh = vehicle player;
	if ((!(_veh isKindOf "Truck_F")) && (!(_veh canAdd [_cls,1]))) then {
		"This vehicle is full, use a truck for more storage" call OT_fnc_notifyMinor;
		_handled = false;
	};
};

if(_handled) then {
	playSound "3DEN_notificationDefault";
	if (_cls in OT_illegalItems) exitWith {
		[-_price] call OT_fnc_money;
		player addItem _cls;

		if(player call OT_fnc_unitSeenNATO) then {
			[player] remoteExec ["OT_fnc_NATOsearch",2,false];
		};
	};
	if (_cls in OT_allStaticBackpacks) exitWith {
		[-_price] call OT_fnc_money;
		player addBackpack _cls;
	};
	if (_cls in OT_allOptics) exitWith {
		[-_price] call OT_fnc_money;
		player addItem _cls;
	};
	player setVariable ["money",_money-_price,true];

	if(_b == "Vehicle") then {
		if(_cls isKindOf "Bag_Base") then {
			(vehicle player) addBackpackCargoGlobal [_cls,1];
		}else{
			(vehicle player) addItemCargoGlobal [_cls,1];
		};
	}else{
		if(_cls isKindOf "Bag_Base") then {
			player addBackpack _cls;
		}else{
			player addItem _cls;
		};
	};
};
