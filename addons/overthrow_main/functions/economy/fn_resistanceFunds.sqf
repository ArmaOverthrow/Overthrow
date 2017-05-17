private _funds = player getVariable ["money",0];
if(isMultiplayer) then {
    _funds = server getVariable ["money",0];
};
if(count _this > 0) then {
    _funds = _funds + (_this select 0);
    if(isMultiplayer) then {
        server setVariable ["money",_funds,true];
    }else{
        player setVariable ["money",_funds,true];
    }
};
_funds;
