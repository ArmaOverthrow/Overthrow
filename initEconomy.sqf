if (!isServer) exitwith {};
private ["_mSize","_name","_low","_med","_hi","_huge","_shops","_allshops","_pos","_lopop","_medpop","_hipop","_hugepop","_pop","_base","_stability","_mrk","_region","_popVar","_towns"];

{_x setMarkerAlpha 0} foreach AIT_regions;

//automatically determining the population of each town/city on the map
//For each city and/or town
AIT_activeShops = [];
{
	_name = text _x;// Get name
	
	server setVariable [_name,getpos _x,true];
	
	_mSize = 350;
	if(_name in AIT_capitals + AIT_sprawling) then {//larger search radius
		_mSize = 1000;
	};
	_pos=getpos _x;
	
	_info = [_name,_pos];

	_low = [];
	_med = [];	
	_hi = [];
	_huge = [];
	_shops = [];
	_allshops = [];
	
	{
		_low pushback (getpos _x);
	}foreach(nearestObjects [_pos, AIT_lowPopHouses, _mSize]);
	
	{
		_med pushback (getpos _x);
	}foreach(nearestObjects [_pos, AIT_medPopHouses, _mSize]);
	
	{
		_hi pushback (getpos _x);
	}foreach(nearestObjects [_pos, AIT_highPopHouses, _mSize]);
	
	{
		_huge pushback (getpos _x);
	}foreach(nearestObjects [_pos, AIT_hugePopHouses, _mSize]);
	
	//spawn any main shops
	{
		_shops pushback _x;
		[_x] spawn run_shop;
		AIT_activeShops pushback _x;
	}foreach(nearestObjects [_pos, AIT_shops, _mSize]);
	
	{
		_allshops pushback (getpos _x);
	}foreach(nearestObjects [_pos, AIT_allShops + AIT_offices + AIT_warehouses + AIT_carShops + AIT_portBuildings, _mSize]);
	
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
	if((_pop < 40) and !(_name in AIT_NATO_priority) and !(_name in AIT_Capitals) and (_pos select 1 < 7000)) then {
		_stability = floor(4 + random(30));
	};
	server setVariable [format["stability%1",_name],_stability,true];
	_mrk = createMarker [_name,_pos];
	_mrk setMarkerShape "ELLIPSE";
	_mrk setMarkerSize[_mSize,_mSize];
	_mrk setMarkerColor "ColorRed";
		
	if(_stability < 50) then {		
		_mrk setMarkerAlpha 1.0 - (_stability / 50);
	}else{
		_mrk setMarkerAlpha 0;
	};
	
	server setVariable [format["shopsin%1",_name],_shops,true];

	_popVar=format["population%1",_name];
	server setVariable [_popVar,_pop,true];
	
	{
		if([_pos,_x] call fnc_isInMarker) exitWith {server setVariable [format["region_%1",_name],_x,true]};
	}foreach(AIT_regions);
}foreach (nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["NameCityCapital","NameCity","NameVillage","CityCenter"], 50000]);

server setVariable ["spawntown",AIT_spawnTowns call BIS_fnc_selectrandom,true];
publicVariable "AIT_activeShops";
{
	_region = _x;
		
	_towns = [_x] call townsInRegion;
	server setVariable [format ["towns_%1",_x],_towns,true];
	
	
}foreach(AIT_regions);

AIT_activeDistribution = [];

_count = 0;
{
	if((random 100) > 40) then {
		_pos = getpos _x;	
		[_x] spawn run_distribution;
		AIT_activeDistribution pushBack _x;
	};
	
}foreach(nearestObjects [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), AIT_warehouses, 50000]);
publicVariable "AIT_activeDistribution";

_towns = [];
//spawn player in a random town with pop > 200 and stability > 20, not in the blacklist
{
	_pop = server getVariable format["population%1",_x];
	_stability = server getVariable format["stability%1",_x];
	
	if(_stability > 70 && !(_x in AIT_spawnBlacklist)) then {
		_towns pushBack _x;
	};	
	player setVariable [format["rep%1",_x],0,true];
}foreach(AIT_allTowns);

AIT_economyInitDone = true;
publicVariable "AIT_economyInitDone";
