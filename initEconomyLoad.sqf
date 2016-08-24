{_x setMarkerAlpha 0} foreach AIT_regions;

//Find NATO HQ
{
    _name = text _x;
    if(_name == AIT_NATO_HQ) then {
        AIT_NATO_HQPos = getpos _x;
    };
}foreach (nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["NameLocal","Airport"], 50000]);

//Stability markers
{
    _stability = server getVariable format["stability%1",_x];
    _pos = server getVariable _x;
    _pos = [_pos,40,-90] call BIS_fnc_relPos;
    _mSize = 250;
    
    if(_x in AIT_Capitals) then {
        _mSize = 400;
    };
    
    _mrk = createMarker [_x,_pos];
    _mrk setMarkerShape "ELLIPSE";
    _mrk setMarkerSize[_mSize,_mSize];
    _mrk setMarkerColor "ColorRed";
        
    if(_stability < 50) then {      
        _mrk setMarkerAlpha 1.0 - (_stability / 50);
    }else{
        _mrk setMarkerAlpha 0;
    };
    _mrk = createMarker [format["%1-abandon",_x],_pos];
    _mrk setMarkerShape "ICON";
    _mrk setMarkerType "mil_dot";
    if(_stability < 50) then {      
        _mrk setMarkerColor "ColorOPFOR";
    }else{
        _mrk setMarkerColor "ColorGUER";
    };
    if(_x in (server getVariable ["NATOabandoned",[]])) then {      
        _mrk setMarkerAlpha 1;
    }else{
        _mrk setMarkerAlpha 0;
    };
    
    if((server getVariable ["EconomyVersion",0]) < 2) then {
        [_x] call setupTownEconomy;
    };
}foreach(AIT_allTowns);

server setVariable ["EconomyVersion",2,false];

AIT_economyLoadDone = true;
publicVariable "AIT_economyLoadDone";