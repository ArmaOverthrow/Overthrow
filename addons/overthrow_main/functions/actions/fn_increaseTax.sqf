private _rate = server getVariable ["taxrate",0];
_rate = _rate + 5;
if(_rate > 100) then {_rate = 100};
server setVariable ["taxrate",_rate,true];
format["Tax rate is now %1%2",_rate,"%"] call OT_fnc_notifyMinor;
