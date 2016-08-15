if !(captive player) exitWith {"You cannot ask for intel while wanted" call notify_minor};

_town = (getpos player) call nearestTown;
_standing = player getVariable 'rep';

_civ = player getvariable "hiringciv";
_handled = false;

if(_civ getvariable ["askedintel",false]) exitWith {
	_civ globalChat "You already asked me";
};

_got = _civ getVariable ["gotmoney",false];

if(_got or (random 500 < _standing)) then {
	_handled = [player,_civ] call giveIntel;
}else{
	_civ globalChat "Can't help you, I'm sorry";
};

_civ setVariable ["askedintel",true];
_civ setVariable ["gotmoney",false,false];