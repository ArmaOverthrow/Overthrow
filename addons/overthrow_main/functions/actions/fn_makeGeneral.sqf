
private _idx = lbCurSel 1500;
private _uid = lbData [1500,_idx];

private _generals = server getVariable ["generals",[]];
_generals pushback _uid;
server setVariable ["generals",_generals,true];

disableSerialization;

_amgen = (getPlayerUID player) in (server getVariable ["generals",[]]);

_isonline = false;
_on = "Offline";
_player = objNull;
{
    if(getplayeruid _x isEqualTo _uid) exitWith {_isonline = true;_on = "Online";_player = _x};
}foreach(allplayers);

_money = 0;
if(_isonline) then {
    _money = _player getVariable["money",0];
}else{
    _money = [_uid,"money"] call OT_fnc_getOfflinePlayerAttribute;
};

if(_uid in (server getVariable ["generals",[]])) then {
    _on = _on + " (General)";
};

_text = format["<t size='0.8'>%1</t><br/>",lbText [1500,_idx]];
_text = _text + format["<t size='0.65'>%1</t><br/>",_on];

if(_amgen) then {
    _text = _text + format["<t size='0.65'>$%1</t>",[_money, 1, 0, true] call CBA_fnc_formatNumber];
};

_textctrl = (findDisplay 8000) displayCtrl 1102;
_textctrl ctrlSetStructuredText parseText _text;
ctrlEnable [1600,false];
