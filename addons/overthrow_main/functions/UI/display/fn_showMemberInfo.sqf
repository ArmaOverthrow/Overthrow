params ["_ctrl","_index"];

disableSerialization;

private _uid = _ctrl lbData _index;

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

_text = format["<t size='0.8'>%1</t><br/>",_ctrl lbText _index];
_text = _text + format["<t size='0.65'>%1</t><br/>",_on];

if(_amgen) then {
    _text = _text + format["<t size='0.65'>$%1</t>",[_money, 1, 0, true] call CBA_fnc_formatNumber];
};

_textctrl = (findDisplay 8000) displayCtrl 1102;
_textctrl ctrlSetStructuredText parseText _text;

if(_amgen && _uid != (getplayeruid player)) then {
    ctrlEnable [1601,true];
    if !(_uid in (server getVariable ["generals",[]])) then {
        ctrlEnable [1600,true];
    }else{
        ctrlEnable [1600,false];
    };
}else{
    ctrlEnable [1600,false];
    ctrlEnable [1601,false];
};

if(!_amgen) then {
    ctrlShow [1600,false];
    ctrlShow [1601,false];
};
