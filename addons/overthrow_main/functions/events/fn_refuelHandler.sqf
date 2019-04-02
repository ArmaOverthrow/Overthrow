params ["_sink","_fuelInSink"];

private _nozzle = _sink getVariable "ace_refuel_nozzle";
private _source = _nozzle getVariable "ace_refuel_source";

if((typeof _source) in OT_fuelPumps) then {
    private _last = _sink getVariable ["ot_lastFuel",fuel _sink];
    private _fueled = (fuel _sink) - _last;
    private _litresFueled = _fueled * getNumber (configFile >> "CfgVehicles" >> typeof _sink >> "fuelCapacity");
    private _cargoCap = getNumber (configFile >> "CfgVehicles" >> typeof _sink >> "ace_refuel_fuelCargo");
    private _cargo = [_sink] call ace_refuel_fnc_getFuel;

    private _pricePer = [OT_nation,"FUEL",100] call OT_fnc_getPrice;
    private _total = round(_pricePer * _litresFueled);

    //take money from nearest player
    private _player = objNull;
    private _close = -1;
    {
        private _dis = (_x distance _sink);
        if(_close isEqualTo -1 || _dis < _close) then {
            _player = _x;
            _close = _dis;
        }
    }foreach(allplayers);
    _money = _player getVariable ["money",0];
    if(_money < _total) then {
        _nozzle setVariable ["ace_refuel_lastTickMissionTime", nil];
        _nozzle setVariable ["ace_refuel_isRefueling", false, true];
        "You cannot afford fuel" remoteExec ["OT_fnc_notifyMinor",_player];
        _sink setFuel _last;
    }else{
        [-_total] remoteExec ["OT_fnc_money",_player];
    };

    _sink setVariable ["ot_lastFuel",fuel _sink,false];
};
