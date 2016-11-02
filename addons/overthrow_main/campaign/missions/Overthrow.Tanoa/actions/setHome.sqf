if !(captive player) exitWith {"You cannot set home while wanted" call notify_minor};

_buildings =  (getpos player) nearObjects 15;
_handled = false;
_building = objNULL;
{
	_owner = _x getVariable "owner";
	if(!isNil "_owner") then {
		if ((typeof _x) in OT_allBuyableBuildings and _owner == getplayerUID player) exitWith {
			_handled = true;
			player setVariable ["home",getpos _x,true];
			"This is now your home" call notify_minor;
		};
	};
	
}foreach(_buildings);

if !(_handled) then {	
	"You don't own any buildings nearby" call notify_minor;
};

