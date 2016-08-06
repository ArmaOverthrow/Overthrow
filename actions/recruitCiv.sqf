if !(captive player) exitWith {"You cannot recruit while wanted" call notify_minor};

_town = (getpos player) call nearestTown;
_standing = player getVariable format['rep%1',_town];

_price = [_town,"CIV",_standing] call getPrice;

_money = player getVariable "money";
if(_money < _price) exitWith {format["You need $%1",_price] call notify_minor};

_civs = player nearEntities ["Man", 10];
_possible = [];

{
	_owner = _x getVariable "owner";
	if(isNil "_owner" and side _x == civilian and _x != player) then {
		_possible pushBack _x;
	};
}foreach(_civs);

if(count _possible == 0) exitWith {"No civilians within 10 meters" call notify_minor};

playSound "ClickSoft";
player setVariable ["money",_money-_price,true];

[_town,1] call standing;

_civ = _possible select 0;
_civ setVariable ["owner",player,true];
[_civ] joinSilent (group player);
removeAllActions _civ;
_civ spawn wantedSystem;
_civ setVariable ["NOAI",1,true];

format["%1 has joined your crew",name _civ] call notify_minor;