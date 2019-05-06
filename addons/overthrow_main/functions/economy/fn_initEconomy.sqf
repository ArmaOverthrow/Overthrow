if (!isServer) exitwith {};

//automatically determinine the population of each town/city on the map
//For each city and/or town
OT_allShops = [];
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
    }foreach(nearestObjects [_pos, OT_shops + OT_offices + OT_warehouses + OT_carShops + OT_portBuildings, _mSize]);

    private _lopop = round(count(_low) * (random(2) + 1));
    private _medpop = round(count(_med) * (random(4) + 2));
    private _highpop = round(count(_hi) * (count(_allshops)) * 0.2);
    private _hugepop = round(count(_huge) * (count(_allshops)) * 0.8);

    private _pop = round((_lopop + _medpop + _highpop + _hugepop) * OT_populationMultiplier);

    private _base = 60 + count(_allshops);
    if(_base > 80) then {
        _base = 80;
    };
    if(_pop > 1200) then {_pop = 1050 + round(random 150)};
    if(_pop < 20) then {_pop = 15 + round(random 10)};
    private _stability = round(_base + random(20));

    //Low stability in small towns

    if((_pop < 500) && !(_name in OT_NATO_priority) && !(_name in OT_Capitals) && (_name in OT_spawnTowns)) then {
        _stability = floor(20 + random(20));
    };
    server setVariable [format["stability%1",_name],_stability,true];

    [_name] call OT_fnc_setupTownEconomy;

    private _popVar=format["population%1",_name];
    server setVariable [_popVar,_pop,true];

    {
        if(_pos inArea _x) exitWith {server setVariable [format["region_%1",_name],_x,true]};
    }foreach(OT_regions);
    sleep 0.2;
}foreach (OT_allTowns);

server setVariable ["spawntown",OT_spawnTowns call BIS_fnc_selectrandom,true];
{
    private _region = _x;

    private _towns = [_x] call OT_fnc_townsInRegion;
    server setVariable [format ["towns_%1",_x],_towns,true];
}foreach(OT_regions);

OT_allShops = nil; //Clean this up we dont need it anymore

OT_economyInitDone = true;
publicVariable "OT_economyInitDone";
