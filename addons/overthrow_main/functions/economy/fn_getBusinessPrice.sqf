private _data = _this call OT_fnc_getBusinessData;
private _baseprice = 100000;
if(count _data == 2) then {
    //turns nothing into money
    _baseprice = round(_baseprice * 1.5);
};
if(count _data == 3) then {
    //turns something into money
    _baseprice = round(_baseprice * 1.3);
};
if(count _data == 4) then {
    if((_data select 2) != "" and (_data select 3) != "") then {
        //turns something into something
        _baseprice = round(_baseprice * 1.2);
    };
    if((_data select 2) == "" and (_data select 3) != "") then {
        if((_data select 3) == "OT_Steel") then {
            _baseprice = round(_baseprice * 2.4);
        };
        if((_data select 3) == "OT_Sugarcane") then {
            _baseprice = round(_baseprice * 0.4);
        };
    };
};
private _stability = 1.0 - ((server getVariable [format["stability%1",OT_nation],100]) / 100);

_baseprice + (_baseprice * _stability)
