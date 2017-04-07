private _pos = _this;
private _search = OT_economicData + OT_objectiveData + OT_townData + OT_commsData + OT_airportData;
private _closest = ([_search,[],{(_x select 0) distance _pos},"ASCEND"] call BIS_fnc_SortBy) select 0;
_type = "Objective";
call {
    if(_closest in OT_economicData) exitWith {_type = "Business"};
    if(_closest in OT_townData) exitWith {_type = "Town"};
    if(_closest in OT_commsData) exitWith {_type = "Radio Tower"};
    if(_closest in OT_airportData) exitWith {_type = "Airport"};
};

[_closest select 1,_type,_closest]
