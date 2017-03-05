params ["_ctrl","_index"];

disableSerialization;

private _name = _ctrl lbData _index;
private _data = _name call OT_fnc_getEconomicData;

private _anum = server getVariable [format["%1employ",_name],0];
private _num = _anum;
if(_num > 20) then {
    _num = 20;
};
private _perhr = ["Tanoa","WAGE",0] call OT_fnc_getPrice;
if(_name == "Factory") then {_perhr = _perhr * 2};

private _wages = _anum * _perhr;

private _innum = _num * 2;
private _outnum = _num * 2;

_amgen = (getPlayerUID player) in (server getVariable ["generals",[]]);

_text = format["<t size='0.8'>%1</t><br/>",_name];
_text = _text + format["<t size='0.65'>Employees: %1</t><br/>",_anum];
_text = _text + format["<t size='0.65'>Wages: $%1</t><br/>",_wages];

_amgen = (getPlayerUID player) in (server getVariable ["generals",[]]);

if(_amgen) then {
    ctrlEnable [1602,true];
    ctrlEnable [1603,true];
};

if(count _data > 2) then {
    _input = _data select 2;
    _output = _data select 3;
    if(_input != "") then {
        _text = _text + format["<t size='0.65'>Input: %1 x %2</t><br/>",_innum, _input call ISSE_Cfg_Weapons_GetName];
    };
    if(_output != "") then {
        _text = _text + format["<t size='0.65'>Output: %1 x %2</t><br/>",_outnum, _output call ISSE_Cfg_Weapons_GetName];
    };
};

_textctrl = (findDisplay 8000) displayCtrl 1104;
_textctrl ctrlSetStructuredText parseText _text;
