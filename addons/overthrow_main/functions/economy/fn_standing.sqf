private _town = _this select 0;
private _rep = (player getVariable [format["rep%1",_town],0]);
if(count _this > 1) then {
    _rep = _rep+(_this select 1);
    player setVariable [format["rep%1",_town],_rep,true];
    _totalrep = (player getVariable ["rep",0])+(_this select 1);
    player setVariable ["rep",_totalrep,true];
};

if(count _this > 2) then {
    format["%1 (%2 %3)",_this select 2,_this select 1,_town] call OT_fnc_notifyMinor;
};
_rep;
