{_x setMarkerAlpha 0} foreach OT_regions;

//Find NATO HQ
{
    _name = _x select 0;
	_pos = _x select 1;
    if(_name == OT_NATO_HQ) then {
        OT_NATO_HQPos = _pos;
    };
}foreach (OT_airportData);

_allActiveShops = [];

//Stability markers
{
    _stability = server getVariable format["stability%1",_x];
    _posTown = server getVariable _x;
    _pos = [_posTown,40,-90] call BIS_fnc_relPos;
    _mSize = 250;
    
    if(_x in OT_Capitals) then {
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
    _garrison = server getVariable [format['police%1',_x],0];
	if(_garrison > 0) then {
		_mrk setMarkerType "OT_Police";
	}else{
		_mrk setMarkerType "OT_Anarchy";
	};	
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
    
    if((server getVariable ["EconomyVersion",0]) < OT_economyVersion) then {
        [_x] call setupTownEconomy;
    };
	
	_shops = server getVariable [format["activeshopsin%1",_x],[]];
	[_allActiveShops,_shops] call BIS_fnc_arrayPushStack;
	
	//place animals
	[nearestBuilding _posTown, OT_allTownAnimals, _mSize+400] call BIS_fnc_animalSiteSpawn;
	private _church = server getVariable [format["churchin%1",_x],[]];
	if !(_church isEqualTo []) then {
		_c = nearestBuilding _church;
		if(typeof _c == "Land_Temple_Native_01_F") then {
			[_c, OT_allVillageAnimals, 150] call BIS_fnc_animalSiteSpawn;
		};
	};
	
}foreach(OT_allTowns);

server setVariable ["EconomyVersion",OT_economyVersion,false];

OT_allActiveShops = _allActiveShops;
publicVariable "OT_allActiveShops";

OT_economyLoadDone = true;
publicVariable "OT_economyLoadDone";