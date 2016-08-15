if !(captive player) exitWith {"You cannot recruit while wanted" call notify_minor};

_town = (getpos player) call nearestTown;
_standing = player getVariable format['rep%1',_town];

_price = [_town,"CIV",_standing] call getPrice;
_money = player getVariable "money";

if(_money < _price) exitWith {"You cannot afford that" call notify_minor};
playSound "3DEN_notificationDefault";
player setVariable ["money",_money-_price,true];

if(random 100 > 80) then {
	[_town,1] call standing;
};

_civ = player getvariable "hiringciv";
_civ setVariable ["owner",getPlayerUID player,true];
[_civ] joinSilent (group player);
removeAllActions _civ;
_civ setCaptive false;
_civ setVariable ["NOAI",true,true];

format["%1 has joined your crew",name _civ] call notify_minor;