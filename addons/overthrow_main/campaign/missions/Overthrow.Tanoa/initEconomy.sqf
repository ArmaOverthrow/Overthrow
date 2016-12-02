if (!isServer) exitwith {};

//automatically determining the population of each town/city on the map
//For each city and/or town

{
    private _name = _x;// Get name

    private _mSize = 350;
    if(_name in OT_capitals + OT_sprawling) then {//larger search radius
        _mSize = 1000;
    };
    private _pos= server getVariable _x;

    private _info = [_name,_pos];

    private _low = [];
    private _med = [];
    private _hi = [];
    private _huge = [];
    private _shops = [];
    private _allshops = [];

    {
        _low pushback (getpos _x);
    }foreach(nearestObjects [_pos, OT_lowPopHouses, _mSize]);

    {
        _med pushback (getpos _x);
    }foreach(nearestObjects [_pos, OT_medPopHouses, _mSize]);

    {
        _hi pushback (getpos _x);
    }foreach(nearestObjects [_pos, OT_highPopHouses, _mSize]);

    {
        _huge pushback (getpos _x);
    }foreach(nearestObjects [_pos, OT_hugePopHouses, _mSize]);

    {
        _allshops pushback (getpos _x);
    }foreach(nearestObjects [_pos, OT_allShops + OT_offices + OT_warehouses + OT_carShops + OT_portBuildings, _mSize]);

    private _lopop = round(count(_low) * (random(2) + 1));
    private _medpop = round(count(_med) * (random(4) + 2));
    private _highpop = round(count(_hi) * (count(_allshops)) * 0.2);
    private _hugepop = round(count(_huge) * (count(_allshops)));

    private _pop = _lopop + _medpop + _highpop + _hugepop;
    private _base = 60 + count(_allshops);
    if(_base > 80) then {
        _base = 80;
    };
    private _stability = round(_base + random(20));
    if((_pop < 40) and !(_name in OT_NATO_priority) and !(_name in OT_Capitals) and (_pos select 1 < 7000)) then {
        _stability = floor(20 + random(20));
    };
    server setVariable [format["stability%1",_name],_stability,true];

    [_name] call setupTownEconomy;

    private _popVar=format["population%1",_name];
    server setVariable [_popVar,_pop,true];

    {
        if([_pos,_x] call fnc_isInMarker) exitWith {server setVariable [format["region_%1",_name],_x,true]};
    }foreach(OT_regions);
    sleep 0.1;
}foreach (OT_allTowns);

server setVariable ["spawntown",OT_spawnTowns call BIS_fnc_selectrandom,true];
{
    private _region = _x;

    private _towns = [_x] call townsInRegion;
    server setVariable [format ["towns_%1",_x],_towns,true];
}foreach(OT_regions);

OT_economyInitDone = true;
publicVariable "OT_economyInitDone";
