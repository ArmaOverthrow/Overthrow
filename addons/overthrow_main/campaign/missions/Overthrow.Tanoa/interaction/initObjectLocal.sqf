if(typeof _this == OT_item_Map) then {
	_this addAction ["Town Info", "actions\townInfo.sqf",nil,0,false,true,"",""];
	_this addAction ["Most Wanted", "actions\mostWanted.sqf",nil,0,false,true,"",""];
	_this addAction ["Reset UI", {
		closedialog 0;
		[] execVM "setupPlayer.sqf";
		[] spawn setupKeyHandler;
	},nil,0,false,true,"",""];

};
if(typeof _this == OT_item_Storage) then {
	_this addAction ["Dump Everything", {[player,_this select 0] call dumpStuff},nil,0,false,true,"",""];
	_this addAction ["Save Loadout", "actions\saveLoadout.sqf",nil,0,false,true,"",""];
	_this addAction ["Restore Loadout", "UI\loadoutDialog.sqf",nil,0,false,true,"",""];
	_this addAction ["Take From Warehouse", {
		private _iswarehouse = call OT_fnc_playerAtWarehouse;

		if !(_iswarehouse) exitWith {
			"No warehouse within range or needs repair" call OT_fnc_notifyMinor;
		};

		OT_warehouseTarget = _this select 0;
		closeDialog 0;
		createDialog "OT_dialog_warehouse";
		[] call warehouseDialog;
	},nil,0,false,true,"","call OT_fnc_playerAtWarehouse"];
	_this addAction ["Store In Warehouse", {
		private _iswarehouse = call OT_fnc_playerAtWarehouse;
		if !(_iswarehouse) exitWith {
			"No warehouse within range or needs repair" call OT_fnc_notifyMinor;
		};
		OT_warehouseTarget = _this select 0;
		[] spawn OT_fnc_transferTo;
	},nil,0,false,true,"","call OT_fnc_playerAtWarehouse"];
	if(_this call OT_fnc_playerIsOwner) then {
		_this addAction ["Lock", {
			(_this select 0) setVariable ["OT_locked",true,true];
			"Ammobox locked" call OT_fnc_notifyMinor;
		},nil,0,false,true,"","!(_target getVariable ['OT_locked',false])"];
		_this addAction ["Unlock", {
			(_this select 0) setVariable ["OT_locked",false,true];
			"Ammobox unlocked" call OT_fnc_notifyMinor;
		},nil,0,false,true,"","(_target getVariable ['OT_locked',false])"];
	};
};
if(typeof _this == OT_item_Safe) then {
	_this addAction ["Put Money", "actions\putMoney.sqf",nil,0,false,true,"",""];
	_this addAction ["Take Money", "actions\takeMoney.sqf",nil,0,false,true,"",""];
	_this addAction ["Set Password", "actions\setPassword.sqf",nil,0,false,true,"","(_target getVariable ['owner','']) == getplayeruid _this"];
};

if(typeof _this == "Land_Cargo_House_V4_F") then {
	if(OT_hasACE) then {
		[_this] call ace_repair_fnc_moduleAssignRepairFacility;
	};
};

if(_this isKindOf "Building" or _this isKindOf "Man" or _this isKindOf "LandVehicle") exitWith{};

if(OT_hasACE) then {
	_dir = 0;
	if(typeof _this == "C_Rubberboat") then {
		_dir = 90;
	};
	[_this, true, [0, 2, 0.4],_dir] call ace_dragging_fnc_setCarryable;
};
