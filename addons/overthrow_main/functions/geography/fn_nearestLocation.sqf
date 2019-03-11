private _pos = _this;
private _search = OT_economicData + OT_objectiveData + OT_townData + OT_commsData + OT_airportData;
private _closest = ([_search,[],{(_x select 0) distance _pos},"ASCEND"] call BIS_fnc_SortBy) select 0;
private _type = _closest call {
    if(_this in OT_economicData) exitWith {"Business"};
    if(_this in OT_townData) exitWith {"Town"};
    if(_this in OT_commsData) exitWith {"Radio Tower"};
    if(_this in OT_airportData) exitWith {"Airport"};
    "Objective"
};

[_closest select 1,_type,_closest]
