waitUntil {sleep 1;missionNamespace getVariable ["OT_varInitDone",false]};
{_x setMarkerAlpha 0} foreach OT_regions;

//Find NATO HQ
{
    _x params ["_pos","_name"];
    if(_name isEqualTo OT_NATO_HQ) then {
        OT_NATO_HQPos = _pos;
    };
}foreach (OT_objectiveData + OT_airportData);

private _allActiveShops = [];
private _allActiveCarShops = [];
private _allActivePiers = [];

private _version = server getVariable ["EconomyVersion",0];

diag_log format["Overthrow: Economy version is %1",_version];

//Generate 10 possible gang camp positions for each town

{
    private _town = _x;
    private _posTown = server getVariable _x;
    private _allpos = [];

    _possible = selectBestPlaces [_posTown, 600,"(1 + forest + trees) * (1 - houses) * (1 - sea)",10,600];
    {
        _pos = _x select 0;
        _pos set [2,0];
        if !(_pos isFlatEmpty  [-1, -1, 0.5, 10] isEqualTo []) then {
            _ob = _pos call OT_fnc_nearestObjective;
            _obpos = _ob select 0;
    		_obdist = _obpos distance _pos;

            _towndist = (server getVariable _town) distance _pos;
            _control = _pos call OT_fnc_nearestCheckpoint;
    		_cdist = (getmarkerpos _control) distance _pos;

    		if(_obdist > 800 and _towndist > 200 and _cdist > 500) then {
                _allpos pushback _pos;
            };
        };
        if((count _allpos) > 10) exitWith{};
    }foreach(_possible);
    spawner setVariable [format["gangpositions%1",_town],_allpos,false];

    if((server getVariable "StartupType") == "NEW") then {
        //Form gangs on a new game start
        private _stability = server getVariable [format["stability%1",_town],50];
        if(_stability < 50 && (selectRandom [1,2,3,4]) isEqualTo 1) then { //Approx 1/4 of all towns < 50% will have a gang at start
            _gangid = [_town,false] call OT_fnc_formGang;
            if(_gangid > -1) then {
                [_gangid,1+floor(random 2),false] call OT_fnc_addToGang;
            };
        };
    };
}foreach(OT_allTowns);

if(_version < OT_economyVersion) then {
    diag_log "Overthrow: Economy version is old, regenerating towns";
    OT_allShops = [];

    {
        _x params ["_cls","_name","_side"];
        if(_side != 1) then {
            _reppos = server getVariable [format["factionrep%1",_cls],false];
            if(typename _reppos != "ARRAY") then {
                _town = selectRandom OT_allTowns;
                if(_cls isEqualTo OT_spawnFaction) then {_town = server getvariable "spawntown"};
                _posTown = server getVariable _town;
                _building = [_posTown,OT_allHouses] call OT_fnc_getRandomBuilding;
                _pos = _posTown;
                if(typename _building != "BOOL") then {
            		_pos = (_building call BIS_fnc_buildingPositions) call BIS_fnc_selectRandom;
            		[_building,"system"] call OT_fnc_setOwner;
                    if(isNil "_pos") then {
                        _pos = [[[getpos _building,20]]] call BIS_fnc_randomPos;
                    };
            	}else{
            		_pos = [[[_posTown,200]]] call BIS_fnc_randomPos;
            	};
            	server setVariable [format["factionrep%1",_cls],_pos,true];
                server setVariable [format["factionname%1",_cls],_name,true];
            };
        };
    }foreach(OT_allFactions);
    diag_log "Overthrow: Economy Load Complete";
};

//Save upgrade for existing factions > 0.7.5.1
{
    _x params ["_cls","_name","_side"];
    _n = server getVariable [format["factionname%1",_cls],""];
    if(_n isEqualTo "") then {
        server setVariable [format["factionname%1",_cls],_name,true];
    };
}foreach(OT_allFactions);

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

    _abandoned = server getVariable ["NATOabandoned",[]];
    if(_mrk in _abandoned) then {
        _mrk setMarkerColor "ColorRed";
    }else{
        _mrk setMarkerColor "ColorYellow";
    };

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
        [_x] call OT_fnc_setupTownEconomy;
    };

	_shops = server getVariable [format["activeshopsin%1",_x],[]];
	[_allActiveShops,_shops] call BIS_fnc_arrayPushStack;

	_carshops = server getVariable [format["activecarshopsin%1",_x],[]];
	[_allActiveCarShops,_carshops] call BIS_fnc_arrayPushStack;

	_piers = server getVariable [format["activepiersin%1",_x],[]];
	[_allActivePiers,_piers] call BIS_fnc_arrayPushStack;
    sleep 0.2;
}foreach(OT_allTowns);

OT_allEconomic = [];
{
	_x params ["_pos","_name"];
	_mrk = createMarker [_name,_pos];
	_mrk setMarkerShape "ICON";
    _mrk setMarkerType "ot_Business";
    _mrk setMarkerColor "ColorWhite";
    if(_name in (server getVariable["GEURowned",[]])) then {_mrk setMarkerColor "ColorGUER"};
    _mrk setMarkerAlpha 0.8;
	OT_allEconomic pushback _name;
    server setVariable [_name,_pos,true];
    cost setVariable [_name,_x,true];
}foreach(OT_economicData);
sleep 0.2;

_mrk = createMarker ["Factory",OT_factoryPos];
_mrk setMarkerShape "ICON";
_mrk setMarkerType "ot_Factory";
_mrk setMarkerColor "ColorWhite";
if("Factory" in (server getVariable["GEURowned",[]])) then {_mrk setMarkerColor "ColorGUER"};
_mrk setMarkerAlpha 0.8;

server setVariable ["EconomyVersion",OT_economyVersion,false];

OT_allActiveShops = _allActiveShops;
publicVariable "OT_allActiveShops";

OT_allActiveCarShops = _allActiveCarShops;
publicVariable "OT_allActiveCarShops";

OT_allActivePiers = _allActivePiers;
publicVariable "OT_allActivePiers";

OT_economyLoadDone = true;
publicVariable "OT_economyLoadDone";
