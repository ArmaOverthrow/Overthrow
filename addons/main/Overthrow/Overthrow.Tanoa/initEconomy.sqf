if (!isServer) exitwith {};
private ["_mSize","_name","_low","_med","_hi","_huge","_shops","_allshops","_pos","_lopop","_medpop","_hipop","_hugepop","_pop","_base","_stability","_mrk","_region","_popVar","_towns"];

//automatically determining the population of each town/city on the map
//For each city and/or town

{
    _name = _x;// Get name
    
    _mSize = 350;
    if(_name in OT_capitals + OT_sprawling) then {//larger search radius
        _mSize = 1000;
    };
    _pos= server getVariable _x;
    
    _info = [_name,_pos];

    _low = [];
    _med = [];  
    _hi = [];
    _huge = [];
    _shops = [];
    _allshops = [];
    
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
    
    _lopop = round(count(_low) * (random(2) + 1));
    _medpop = round(count(_med) * (random(4) + 2)); 
    _highpop = round(count(_hi) * (count(_allshops)) * 0.2); 
    _hugepop = round(count(_huge) * (count(_allshops))); 
    
    _pop = _lopop + _medpop + _highpop + _hugepop;
    _base = 60 + count(_allshops);
    if(_base > 80) then {
        _base = 80;
    };
    _stability = round(_base + random(20));
    if((_pop < 40) and !(_name in OT_NATO_priority) and !(_name in OT_Capitals) and (_pos select 1 < 7000)) then {
        _stability = floor(20 + random(20));
    };
    server setVariable [format["stability%1",_name],_stability,true];

    [_name] call setupTownEconomy;

    _popVar=format["population%1",_name];
    server setVariable [_popVar,_pop,true];
    
    {
        if([_pos,_x] call fnc_isInMarker) exitWith {server setVariable [format["region_%1",_name],_x,true]};
    }foreach(OT_regions);
}foreach (OT_allTowns);

server setVariable ["spawntown",OT_spawnTowns call BIS_fnc_selectrandom,true];
{
    _region = _x;
        
    _towns = [_x] call townsInRegion;
    server setVariable [format ["towns_%1",_x],_towns,true];
}foreach(OT_regions);

OT_economyInitDone = true;
publicVariable "OT_economyInitDone";
