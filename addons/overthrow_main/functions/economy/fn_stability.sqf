_town = _this select 0;
if !(_town in OT_allTowns) exitWith{};

_townmrk = format["%1-abandon",_town];
_stability = (server getVariable [format["stability%1",_town],0])+(_this select 1);
if(_stability < 0) then {_stability = 0};
if(_stability > 100) then {_stability = 100};
server setVariable [format["stability%1",_town],_stability,true];

_abandoned = server getVariable "NATOabandoned";
if(_town in _abandoned) then {
    _townmrk setMarkerAlpha 1;
}else{
    _townmrk setMarkerAlpha 0;
};

_garrison = server getVariable [format['police%1',_town],0];
if(_stability < 50) then {
    if(_garrison > 0) then {
        _townmrk setMarkerType "OT_Police";
    }else{
        _townmrk setMarkerType "OT_Anarchy";
    };
}else{
    _townmrk setMarkerType "Empty";
};

//update the markers
if(_stability < 50) then {
    if(_town in _abandoned) then {
        _town setMarkerColor "ColorRed";
    }else{
        _town setMarkerColor "ColorYellow";
    };
    _town setMarkerAlpha 1.0 - (_stability / 50);
    _townmrk setMarkerColor "ColorOPFOR";
}else{
    _townmrk setMarkerColor "ColorGUER";
    if(_town in _abandoned) then {
        _town setMarkerAlpha ((_stability - 50) / 100);
        _town setMarkerColor "ColorGUER";
    }else{
        _town setMarkerAlpha 0;
    };
};
if(_town isEqualTo (server getVariable ["NATOattacking",""])) then {
    _town setMarkerAlpha 0;
};
if !(_town in _abandoned) then {
    _townmrk setMarkerAlpha 0;
    _townmrk setMarkerAlphaLocal 0;
};
