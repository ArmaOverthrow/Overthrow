private _town    = _this select 0;
private _dist = 600;
if(_town in OT_sprawling or _town in OT_capitals) then {_dist = 1000};
private _posTown = server getVariable _town;
private _stability = server getVariable format["stability%1",_town];
private _population = server getVariable format["population%1",_town];
private _shops   = 0;
private _activeShops  = [];
private _activecar  = [];
private _piers  = [];
private _activeHardware = [];

private _churches = nearestObjects [_posTown, OT_churches, _dist,false];
if(count _churches > 0) then {
	server setVariable [format["churchin%1",_town],getpos (_churches select 0),true];
};

//Find hardware stores
{
	private _pos = getpos _x;
	if !(_pos in OT_allShops) exitWith {
		_activeHardware pushback [_pos];
		OT_allShops pushback _pos;
	};
}foreach(nearestObjects [_posTown, [OT_hardwareStore], _dist,false]);
server setVariable [format["activehardwarein%1",_town],_activeHardware,true];

private _chance = 100; //Chance that a shop will be a shop
private _shops = nearestObjects [_posTown, OT_shops, _dist,false];
if(count _shops > (count OT_itemCategoryDefinitions)-1) then {
	//More shops than there are definitions in this town, so make sure one of each is spawned
	{
		_category = _x select 0;
		if(_category != "Hardware") then {
			_x = objNull;
			_c = 0;
			_pos = [];
			while {_c < 10} do{
				_x = selectRandom _shops;
				_pos = getpos _x;
				if !(_pos in OT_allShops) exitWith {};
				_c = _c + 1;
			};
			if(_c < 10) then {
				_activeShops pushback [_pos,_category];
				OT_allShops pushback _pos;
			};
		};
	}foreach(OT_itemCategoryDefinitions);
}else{
	//Find shop buildings and distribute categories to them
	{
		private _pos = getpos _x;
		//Ensure shops are not found twice (overlapping town search radius)
		if (!(_pos in OT_allShops) and (random 100 < _chance)) then {
			_category = "General";
			_rnd = random 100;
			call {
				if(_rnd > 90) exitWith {_category = "Surplus"};
				if(_rnd > 80) exitWith {_category = "Electronics"};
				if(_rnd > 60) exitWith {_category = "Pharmacy"};
				if(_rnd > 40) exitWith {_category = "Clothing"};
			};
			_activeShops pushback [_pos,_category];
			OT_allShops pushback _pos;
		};
	}foreach(_shops);
};

server setVariable [format["activeshopsin%1",_town],_activeShops,true];

{
	private _po = getpos _x;
    if !(_x call OT_fnc_hasOwner or _po in _activecar or _po in OT_allShops) then {
		OT_allShops pushback _po;
		_activecar pushback _po;
    };
}foreach(nearestObjects [_posTown, OT_carShops, _dist,false]);
server setVariable [format["activecarshopsin%1",_town],_activecar,true];

{
	private _po = getpos _x;
    if !(_po in _piers) then {
		_do = true;
		{
			if(_x distance _po < 80) exitWith {_do = false};
		}foreach(_piers);
		if(_do) then {
			_piers pushback _po;
		};
    };
}foreach(nearestObjects [_posTown,OT_piers, _dist,false]);
server setVariable [format["activepiersin%1",_town],_piers,true];
