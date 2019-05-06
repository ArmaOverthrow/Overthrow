private _town = _this select 0;
if(isNil "_town") exitWith {};
private _rep = (server getVariable [format["rep%1",_town],0]);
if(count _this > 1) then {
    _rep = _rep+(_this select 1);
    server setVariable [format["rep%1",_town],_rep,true];
    _totalrep = (server getVariable ["rep",0])+(_this select 1);
    server setVariable ["rep",_totalrep,true];
};

if(count _this > 2) then {
    _pl = "+";
    if((_this select 1) < 0) then {_pl = ""};
    if(count _this > 3) then {
        format["%1 (%4%2 %3)",_this select 2,_this select 1,_town,_pl] remoteExec ["OT_fnc_notifyMinor", _this select 3,false];
    }else{
        format["%1 (%4%2 %3)",_this select 2,_this select 1,_town,_pl] remoteExec ["OT_fnc_notifyMinor", 0,false];
    };
};
_rep;
