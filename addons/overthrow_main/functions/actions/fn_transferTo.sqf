_target = vehicle player;

private _notvehicle = false;
if(_target == player) then {
	_target = OT_warehouseTarget;
	_notvehicle = true;
};

if(isNull _target || isNil "_target") exitWith {};

private _objects = [];

private _b = player call OT_fnc_nearestRealEstate;
private _iswarehouse = false;
if(typename _b == "ARRAY") then {
	_building = _b select 0;
	if((typeof _building) == OT_warehouse and _building call OT_fnc_hasOwner) then {
		_iswarehouse = true;
		_objects pushback _building;
	};
};

if(!_iswarehouse and !_notvehicle) then {
	{
		if(_x != _target) then {_objects pushback _x};
	}foreach(player nearEntities [["Car","ReammoBox_F","Air","Ship"],20]);
};


if(!_notvehicle  and count _objects == 0) exitWith {
	"Cannot find any containers or other vehicles within 20m of this vehicle" call OT_fnc_notifyMinor;
};

if(_notvehicle and count _objects == 0) exitWith {
	"No warehouse within range" call OT_fnc_notifyMinor;
};

if(count _objects == 1) then {
	[vehicle player, (_objects select 0)] call OT_fnc_transferHelper;
}else{
	private _options = [];
	{
		_options pushback [
			format[
				"%1 (%2m)",
				(typeof _x) call OT_fnc_vehicleGetName,
				round (_x distance player)
			],
			OT_fnc_transferHelper,
			[vehicle player, _x]
		];
	}foreach(_objects);
	"Transfer to which container?" call OT_fnc_notifyBig;
	_options spawn OT_fnc_playerDecision;
};
