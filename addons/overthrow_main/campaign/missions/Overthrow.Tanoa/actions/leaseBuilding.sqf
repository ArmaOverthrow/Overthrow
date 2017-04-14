_b = player call OT_fnc_nearestRealEstate;
_building = objNull;
if(typename _b == "ARRAY") then {
	_building = (_b select 0);
};
if(typeof _building == OT_policeStation) exitWith {[] call policeDialog};
if(typeof _building == OT_barracks) exitWith {[] call recruitDialog};
if(typeof _building == OT_warehouse) exitWith {[] call buyVehicleDialog};

if(typename _b != "ARRAY") exitWith {
	private _ob = (getpos player) call OT_fnc_nearestObjective;
	_ob params ["_obpos","_obname"];
	if(_obpos distance player < 250) then {
		if(_obname in (server getVariable ["NATOabandoned",[]])) then {
			[] call buyVehicleDialog;
		};
	};
};

if !(captive player) exitWith {"You cannot lease buildings while wanted" call notify_minor};


_handled = false;
_type = "buy";
_err = false;
_building = objNull;
if(typename _b == "ARRAY") then {
	_building = (_b select 0);
	if !(_building call OT_fnc_hasOwner) then {
		_handled = true;
	}else{
		_owner = _building getVariable "owner";
		if(_owner == getplayeruid player) then {
			_home = player getVariable "home";
			if((_home distance _building) < 5) exitWith {"You cannot lease your home" call notify_minor;_err = true};
			_handled = true;
		};
	};
};
if(_err) exitWith {};
if(_handled) then {
	private _id = ([_building] call fnc_getBuildID);
	_leased = player getvariable ["leased",[]];
	_leased pushback _id;
	player setvariable ["leased",_leased,true];

	_leasedata = player getvariable ["leasedata",[]];
	_leasedata pushback [_id,typeof _building,getpos _building,(getpos _building) call OT_fnc_nearestTown];
	player setvariable ["leasedata",_leasedata,true];

	_building setVariable ["leased",true,true];
	_mrkid = format["bdg-%1",_building];
	_mrkid setMarkerAlphaLocal 0.3;
	playSound "3DEN_notificationDefault";
	"Building leased" call notify_minor;
};
