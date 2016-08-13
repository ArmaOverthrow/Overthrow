{_x setMarkerAlpha 0} foreach AIT_regions;

//Stability markers
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
}foreach(AIT_allTowns);

//Temporary place for stuff that isnt saved in the persistent save
//Shops
{
	_posTown = server getVariable _x;
	_town = _x;
	{	
		if !(_x call hasOwner) then {
			//spawn any main shops
			if((random 100 > 20)) then {		
				AIT_activeShops pushback _x;
			};
			_key = format["shopsin%1",_town];
			server setVariable [_key,(server getVariable [_key,0])+1,true];
		};
	}foreach(nearestObjects [_posTown, AIT_shops, 700]);
	
	{	
		if !(_x call hasOwner) then {
			if((random 100) > 60) then {
				_pos = getpos _x;
				AIT_activeDistribution pushBack _x;
			};
		};
	}foreach(nearestObjects [_posTown, AIT_warehouses, 700]);
	sleep 0.1;
}foreach(AIT_allTowns);

AIT_economyLoadDone = true;
publicVariable "AIT_economyLoadDone";