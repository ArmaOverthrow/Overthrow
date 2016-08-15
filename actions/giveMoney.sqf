_money = player getVariable "money";

if(_money < 100) exitWith {"You don't have $100 to give" call notify_minor};

_civ = player getvariable "hiringciv";

_handled = false;

_town = (getpos player) call nearestTown;
_rep = player getVariable format["rep%1",_town];
if(_rep > 100) then {_rep = 100};
if(_rep < -100) then {_rep = -100};

if(isPlayer _civ) exitWith {
	_handled = true;
	_mon = _x getVariable "money";
	_x setVariable ["money",_mon+100,true];
};
if(side _civ == civilian) then {
	_handled = true;			
	_civ setVariable ["gotmoney",true,false];
	_civ setVariable ["askedintel",false,false];
	if((random 100) > 80) then {
		_x globalChat "I'll tell everyone in town how generous you are!";
		[_town,1] call standing;
	}else{
		_civ globalChat "Thank you, kind sir!";
	};			
};

if(_handled) then {
	player setVariable ["money",_money-100,true];
};