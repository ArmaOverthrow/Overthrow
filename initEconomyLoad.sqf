{_x setMarkerAlpha 0} foreach AIT_regions;

//Temporary place for stuff that isnt saved in the persistent save
//Shops
{	
	//spawn any main shops
	if((random 100 > 20)) then {		
		AIT_activeShops pushback _x;
	};
	_town = (getpos _x) call nearestTown;
	_key = format["shopsin%1",_town];
	server setVariable [_key,(server getVariable [_key,0])+1,true];
	sleep 0.1;
}foreach(nearestObjects [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), AIT_shops, 50000]);
sleep 0.5;
//Distribution
_count = 0;
{
	if((random 100) > 40) then {
		_pos = getpos _x;
		AIT_activeDistribution pushBack _x;
	};
	sleep 0.1;
}foreach(nearestObjects [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), AIT_warehouses, 50000]);
sleep 0.5;
{
	_stability = server getVariable format["stability%1",_x];
	_pos = server getVariable _x;
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
	sleep 0.1;
}foreach(AIT_allTowns);

AIT_economyLoadDone = true;
publicVariable "AIT_economyLoadDone";