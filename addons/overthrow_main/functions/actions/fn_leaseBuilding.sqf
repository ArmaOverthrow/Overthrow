_b = player call OT_fnc_nearestRealEstate;
_building = objNull;
if(typename _b == "ARRAY") then {
	_building = (_b select 0);
};
if(damage _building == 1) exitWith {
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
		format["You need $%1",[_price, 1, 0, true] call CBA_fnc_formatNumber];
	};
};
if(typeof _building == OT_policeStation) exitWith {[] call OT_fnc_policeDialog};
if((typeof _building == OT_barracks) or (typeof _building == OT_trainingCamp)) exitWith {[] call OT_fnc_recruitDialog};
if(typeof _building == OT_warehouse) exitWith {[] call OT_fnc_buyVehicleDialog};

if(typename _b != "ARRAY") exitWith {
	private _ob = (getpos player) call OT_fnc_nearestObjective;
	_ob params ["_obpos","_obname"];
	if(_obpos distance player < 250) then {
		if(_obname in (server getVariable ["NATOabandoned",[]])) then {
			[] call OT_fnc_buyVehicleDialog;
		};
	};
};

if !(captive player) exitWith {"You cannot lease buildings while wanted" call OT_fnc_notifyMinor};


_handled = false;
_type = "buy";
_err = false;
_building = objNull;
if(typename _b == "ARRAY") then {
	_building = (_b select 0);
	if !(_building call OT_fnc_hasOwner) then {
		_handled = true;
	}else{
		_owner = _building call OT_fnc_getOwner;
		if(_owner == getplayeruid player) then {
			_home = player getVariable "home";
			if((_home distance _building) < 5) exitWith {"You cannot lease your home" call OT_fnc_notifyMinor;_err = true};
			_handled = true;
		};
	};
};
if(_err) exitWith {};
if(_handled) then {
	private _id = ([_building] call OT_fnc_getBuildID);
	_leased = player getvariable ["leased",[]];
	_leased pushback _id;
	player setvariable ["leased",_leased,true];

	_leasedata = player getvariable ["leasedata",[]];
	_leasedata pushback [_id,typeof _building,getpos _building,(getpos _building) call OT_fnc_nearestTown];
	player setvariable ["leasedata",_leasedata,true];

	_mrkid = format["bdg-%1",_building];
	_mrkid setMarkerAlphaLocal 0.3;
	playSound "3DEN_notificationDefault";
	"Building leased" call OT_fnc_notifyMinor;
};
