private _who = _this select 0;
private _xp = _who getVariable ["OT_xp",0];
if(count _this > 1) then {
    _amount = _this select 1;
    if(isPlayer _who) then {
        [_amount] remoteExec ["experience",_who,false];
    }else{
        _who setVariable ["OT_xp",_xp + _amount,true];
    };
};
_xp
