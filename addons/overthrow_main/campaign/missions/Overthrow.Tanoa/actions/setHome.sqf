if !(captive player) exitWith {"You cannot set home while wanted" call OT_fnc_notifyMinor};

_buildings =  (getpos player) nearObjects 15;
_handled = false;
_building = objNULL;
{
	_owner = _x call OT_fnc_getOwner;
	if(!isNil "_owner") then {
		if ((typeof _x) in OT_allBuyableBuildings and _owner == getplayerUID player) exitWith {
			_handled = true;
			player setVariable ["home",getpos _x,true];
			"This is now your home" call OT_fnc_notifyMinor;
		};
	};

}foreach(_buildings);

if !(_handled) then {
	"You don't own any buildings nearby" call OT_fnc_notifyMinor;
};
