params ["_town"];

private _dist = 600;
if(_town in OT_sprawling || _town in OT_capitals) then {_dist = 1000};
private _posTown = server getVariable _town;
private _stability = server getVariable [format["stability%1",_town],100];
private _population = server getVariable [format["population%1",_town],0];

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

private _shops = nearestObjects [_posTown, OT_shops, _dist,false];
if(count _shops > (count OT_itemCategoryDefinitions)-1) then {
	//More shops than there are definitions in this town, so make sure one of each is spawned
	{
		_x params ["_category"];
		if(_category != "Hardware") then {
			_c = 0;
			_pos = [];
			while {_c < 10} do{
				_shop = selectRandom _shops;
				_pos = getpos _shop;
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
	//Find shop buildings && distribute categories to them
	private _shopsDone = [];
	{
		private _pos = getpos _x;
		//Ensure shops are not found twice (overlapping town search radius)
		if !(_pos in OT_allShops) then {
			private _category = "";
			if !("General" in _shopsDone) then {
				_category =	"General";
			}else{
				_category =	selectRandom (["General","Surplus","Electronics","Pharmacy","Clothing"] - _shopsDone);
			};
			_shopsDone pushback _category;
			_activeShops pushback [_pos,_category];
			OT_allShops pushback _pos;
		};
	}foreach(_shops);
};

server setVariable [format["activeshopsin%1",_town],_activeShops,true];

diag_log format["Overthrow: Set up economy in %1 (pop. %2, %3 of %4 shops)",_town,_population,count _activeShops,count _shops];

{
	private _po = getpos _x;
    if !(_x call OT_fnc_hasOwner || _po in _activecar || _po in OT_allShops) then {
			OT_allShops pushback _po;
			_activecar pushback _po;
    };
}foreach(nearestObjects [_posTown, OT_carShops, _dist,false]);
server setVariable [format["activecarshopsin%1",_town],_activecar,true];

if((count OT_piers) > 0) then {
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
};
server setVariable [format["activepiersin%1",_town],_piers,true];
