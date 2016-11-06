_b = player call getNearestRealEstate;
_building = objNull;
if(typename _b == "ARRAY") then {
	_building = (_b select 0);	
};
if(typeof _building == OT_policeStation) exitWith {[] call policeDialog};
if !(captive player) exitWith {"You cannot lease buildings while wanted" call notify_minor};


_handled = false;
_type = "buy";
_err = false;
_building = objNull;
if(typename _b == "ARRAY") then {
	_building = (_b select 0);
	if !(_building call hasOwner) then {
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
	_leased = player getvariable ["leased",[]];
	_leased pushback ([_building] call fnc_getBuildID);
	player setvariable ["leased",_leased,true];
	_building setVariable ["leased",true,true];
	_mrkid = format["bought%1",str(_building)];
	_mrkid setMarkerAlpha 0;	
	playSound "3DEN_notificationDefault";
	"Building leased" call notify_minor;
};