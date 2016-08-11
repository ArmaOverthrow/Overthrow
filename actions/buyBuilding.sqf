if !(captive player) exitWith {hint "You cannot buy buildings while wanted"};



_buildings =  (getpos player) nearObjects 15;
_handled = false;
_building = objNULL;
_price = 0;
{
	_owner = _x getVariable "owner";
	if ((typeof _x) in AIT_allBuyableBuildings and (isNil "_owner")) exitWith {
		_handled = true;
		_town = (getpos _x) call nearestTown;
		_stability = ((server getVariable format["stability%1",_town]) / 100);
		_standing = (player getVariable format["rep%1",_town]) + 40;
			
		if(_standing < -100) then {_standing = -100};
		if(_standing > 100) then {_standing = 100};
		if(_standing != 0) then {
			_standing = ((_standing/100) * -1)+1;
		};		
				
		_baseprice = 400;
		_type = typeof _x;
		if !(_type in AIT_spawnHouses) then {
			if(_type in AIT_mansions) then {_baseprice = 25000}else{
				if(_type in AIT_medPopHouses) then {_baseprice = 5000};
				if(_type in AIT_lowPopHouses) then {_baseprice = 1000};
			};			
		};
		_price = round(_baseprice + (_stability * _baseprice * _standing));
		_building = _x;
	};
}foreach(_buildings);

if(_handled) then {
	_money = player getVariable "money";
	if(_money < _price) exitWith {format["You need $%1",_price] call notify_minor};

	playSound "ClickSoft";
	
	_building setVariable ["owner",player];
	player setVariable ["money",_money-_price,true];
	
	_mrk = createMarkerLocal [format["bought%1",str(_building)],getpos _building];
	_mrk setMarkerShape "ICON";
	_mrk setMarkerType "loc_Tourism";
	_mrk setMarkerColor "ColorWhite";
	_mrk setMarkerAlpha 0;
	_mrk setMarkerAlphaLocal 1;
	
	_owned = player getVariable "owned";
	_owned pushback _building;
	player setVariable ["owned",_owned,true];
	
	format["You purchased this building for $%1",_price] call notify_minor;
	
	if(_price > 2000) then {
		[_town,round(_price / 1000)] call standing;		
	};
}else{
	"There are no buildings for sale nearby" call notify_minor;
};

