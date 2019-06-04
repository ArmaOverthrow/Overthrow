params ["_pos"];

private _abandoned = server getvariable ["NATOabandoned",[]];

private _air = [];
private _ground = [];
{
    _x params ["_obpos","_name","_pri"];
    if !((_name in _abandoned) || (_obpos distance _pos) < 300) then {
        if([_pos,_obpos] call OT_fnc_regionIsConnected && (_obpos distance _pos) < 5000) then {
            _ground pushback _x;
        };
        if(_x in OT_airportData) then {
            _air pushback _x;
        };
    };
}foreach([OT_objectiveData + OT_airportData,[],{_pos distance (_x select 0)},"ASCEND"] call BIS_fnc_SortBy);

//add helipads to possibles
{
	_x params ["_obpos","_name"];
	if !((_name in _abandoned) || (_obpos distance _pos) < 300) then {
		_air pushback _x;
	};
}foreach(OT_NATOHelipads);

//sort airfields + helipads by distance
_air = [_air,[],{_pos distance (_x select 0)},"ASCEND"] call BIS_fnc_SortBy;

[_ground,_air]
