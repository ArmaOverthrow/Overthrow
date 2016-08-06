if !(captive player) exitWith {hint "You cannot set home while wanted"};

_buildings =  (getpos player) nearObjects 15;
_handled = false;
_building = objNULL;
{
	_owner = _x getVariable "owner";
	if(!isNil "_owner") then {
		if ((typeof _x) in AIT_allBuyableBuildings and _owner == player) exitWith {
			_handled = true;
			player setVariable ["home",_x,true];
			"This is now your home" call notify_minor;
		};
	};
	
}foreach(_buildings);

if !(_handled) then {	
	"You don't own any buildings nearby" call notify_minor;
};

