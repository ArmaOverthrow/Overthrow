_town = (getpos player) call OT_fnc_nearestTown;
_standing = player getVariable format['rep%1',_town];

if(_standing < 10 and count (player nearObjects [OT_refugeeCamp,50]) == 0) exitWith {
	"+10 Standing required to recruit, or you must be within 50m of a refugee camp" call OT_fnc_notifyMinor
};

if(({side _x == west or side _x == east} count (player nearEntities 50)) > 0) exitWith {"You cannot recruit with enemies nearby" call OT_fnc_notifyMinor};

_price = [_town,"CIV",_standing] call OT_fnc_getPrice;
_money = player getVariable ["money",0];

if(_money < _price) exitWith {"You cannot afford that" call OT_fnc_notifyMinor};
playSound "3DEN_notificationDefault";
player setVariable ["money",_money-_price,true];

if(random 100 > 80) then {
	[_town,1] call OT_fnc_standing;
};

_civ = OT_interactingWith;
[_civ,getPlayerUID player] call OT_fnc_setOwner;
_civ removeAllEventHandlers "FiredNear";
[_civ] joinSilent nil;
[_civ] joinSilent (group player);
_civ setCaptive true;
[_civ] spawn OT_fnc_initRecruit;

[player,format["New Recruit: %1",name _civ],format["Recruited: %1 for $%2",name _civ,_price]] call BIS_fnc_createLogRecord;
format["%1 has been recruited",name _civ] call OT_fnc_notifyMinor;

_civ setBehaviour "SAFE";
[[_civ,""],"switchMove",TRUE,FALSE] spawn BIS_fnc_MP;
