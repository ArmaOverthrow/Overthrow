createDialog 'OT_dialog_resistance';


ctrlEnable [1600,false];
ctrlEnable [1601,false];

private _amgen = (getPlayerUID player) in (server getVariable ["generals",[]]);
if(!isMultiplayer) then {_amgen = true};

if(!_amgen) then {
    ctrlEnable [1605,false];
    ctrlEnable [1602,false];
    ctrlEnable [1603,false];
};

if(!isMultiplayer) then {
    ctrlEnable [1604,false];
    ctrlEnable [1605,false];
};

lbClear 1500;
{
    _uid = _x;
    _name = server getVariable [format["name%1",_uid],"Player"];
    _idx = lbAdd [1500,_name];
    _pic = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
    if(_uid in (server getVariable ["generals",[]])) then {
        _pic = "\A3\Ui_f\data\GUI\Cfg\Ranks\general_gs.paa";
    };
    _col = [0.8,0.8,0.8,1];
    {
        if(getplayeruid _x == _uid) exitWith {_col = [1,1,1,1]};
    }foreach(allplayers);

    lbSetColor [1500, _idx, _col]
    lbSetPicture [1500,_idx,_pic];
    lbSetData [1500,_idx,_uid];
}foreach(server getVariable ["OT_allplayers",[]]);

lbClear 1501;
{

    _name = _x select 1;
    if(_name in (server getVariable ["GEURowned",[]])) then {
        _idx = lbAdd [1501,format["%1",_name]];
        lbSetData [1501,_idx,_name];
    };
}foreach(OT_economicData);

private _owned = player getvariable ["owned",[]];
_lease = 0;
{
    private _bdg = OT_centerPos nearestObject _x;
    if !(isNil "_bdg") then {
        if(_bdg getVariable ["leased",false]) then {
            private _data = _bdg call OT_fnc_getRealEstateData;
            _lease = _lease + (_data select 2);
        };
    };
}foreach(_owned);

_t = call OT_fnc_getTaxIncome;
_taxtotal = _t select 0;
_totax = 0;
_tax = server getVariable ["taxrate",0];
if(_tax > 0) then {
    _totax = round(_taxtotal * (_tax / 100));
};
_numPlayers = count([] call CBA_fnc_players);
_taxper = round(_taxtotal / _numPlayers);
_totaxper = round(_totax / _numPlayers);

private _perhr = (["Tanoa","WAGE",0] call OT_fnc_getPrice)*6;
private _wages = 0;
{
    if(_x != "Factory") then {
        _num = server getVariable [format["%1employ",_x],0];
        _wages = _wages + (_num * _perhr);
    };
}foreach(server getVariable ["GEURowned",[]]);

if(!isMultiplayer) then {
    _totax = _taxtotal + _lease;
};

_balance = _totax - _wages;
_text = "";

if(isMultiplayer) then {
	if((getplayeruid player) in (server getVariable ["generals",[]])) then {
		_text = _text + format["<t align='left' size='0.65'>Resistance Funds: $%1</t><br/>",[server getVariable ["money",0], 1, 0, true] call CBA_fnc_formatNumber];
	};
};

_text = _text + format["<t size='0.65'>Lease Income: $%1</t><br/>",[_lease, 1, 0, true] call CBA_fnc_formatNumber];

if(isMultiplayer) then {
    _text = _text + format["<t size='0.65'>Civilian Income: $%1 ($%2 per player)</t><br/>",[_taxtotal-_totax, 1, 0, true] call CBA_fnc_formatNumber,[_taxper-_totaxper, 1, 0, true] call CBA_fnc_formatNumber];
    if((getplayeruid player) in (server getVariable ["generals",[]])) then {
        _text = _text + format["<t size='0.65'>Resistance Tax (%1%2): $%3 ($%4 per player)</t><br/>",_tax,"%",[_totax, 1, 0, true] call CBA_fnc_formatNumber,[_totaxper, 1, 0, true] call CBA_fnc_formatNumber];
    };
}else{
    _text = _text + format["<t size='0.65'>Tax Income: $%1</t><br/>",[_taxtotal, 1, 0, true] call CBA_fnc_formatNumber];
};
private _minus = "";
if(_wages > 0) then {_minus = "-"};
_text = _text + format["<t size='0.65'>Wages: $%1%2</t><br/>",_minus,[_wages, 1, 0, true] call CBA_fnc_formatNumber];
_text = _text + format["<t size='0.8'>Balance: $%1</t><br/>",[_balance, 1, 0, true] call CBA_fnc_formatNumber];

disableSerialization;
_textctrl = (findDisplay 8000) displayCtrl 1106;
_textctrl ctrlSetStructuredText parseText _text;
