if (OT_taking) exitWith {};

OT_taking = true;
private _idx = lbCurSel 1500;
private _cls = lbData [1500,_idx];
private _num = _this select 0;
private _d = warehouse getVariable [_cls,[_cls,0]];
_in = _d select 1;

if(_num > _in or _num == -1) then {
	_num = _in;
};

_count = 0;
private _veh = (vehicle player);
private	_iswarehouse = false;
if(_veh == player) then {
	_b = OT_warehouseTarget call OT_fnc_nearestRealEstate;
	if(typename _b == "ARRAY") then {
		_building = _b select 0;
		if((typeof _building) == OT_warehouse and _building call OT_fnc_hasOwner) then {
			_iswarehouse = true;
			_veh = OT_warehouseTarget;
		};
	};
};
if(_veh == player) exitWith {
	"No warehouse within range" call OT_fnc_notifyMinor;
};

while {_count < _num} do {
	if ((!(_veh isKindOf "Truck_F")) and (!(_veh isKindOf OT_item_Storage)) and (!(_veh canAdd _cls))) exitWith {hint "This vehicle is full, use a truck for more storage"; closeDialog 0; _num = _count};
	call {
		if(_cls isKindOf ["Rifle",configFile >> "CfgWeapons"]) exitWith {
			_veh addWeaponCargoGlobal [_cls,1];
		};
		if(_cls isKindOf ["Launcher",configFile >> "CfgWeapons"]) exitWith {
			_veh addWeaponCargoGlobal [_cls,1];
		};
		if(_cls isKindOf ["Pistol",configFile >> "CfgWeapons"]) exitWith {
			_veh addWeaponCargoGlobal [_cls,1];
		};
		if(_cls isKindOf ["CA_Magazine",configFile >> "CfgMagazines"]) exitWith {
			_veh addMagazineCargoGlobal [_cls,1];
		};
		if(_cls isKindOf "Bag_Base") exitWith {
			_cls = _cls call BIS_fnc_basicBackpack;
			_veh addBackpackCargoGlobal [_cls,1];
		};
		_veh addItemCargoGlobal [_cls,1];
	};
	_count = _count + 1;
};



private _newnum = _in - _num;
if(_newnum > 0) then {
	warehouse setVariable [_cls,[_cls,_newnum],true];
}else{
	warehouse setVariable [_cls,nil,true];
};

[] call OT_fnc_warehouseDialog;

OT_taking = false;
