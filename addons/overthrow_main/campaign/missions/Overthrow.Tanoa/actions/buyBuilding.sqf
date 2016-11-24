if !(captive player) exitWith {"You cannot buy buildings while wanted" call notify_minor};

_b = player call getNearestRealEstate;
_handled = false;
_type = "buy";
_err = false;
if(typename _b == "ARRAY") then {
	_building = (_b select 0);
	if !(_building call hasOwner) then {
		_handled = true;
	}else{
		_owner = _building getVariable "owner";
		if(_owner == getplayeruid player) then {
			_home = player getVariable "home";
			if(_home distance _building < 5) exitWith {"You cannot sell your home" call notify_minor;_err = true};
			_type = "sell";
			_handled = true;
		};		
	};
};
if(_err) exitWith {};
if(_handled) then {
	_building = _b select 0;
	_price = _b select 1;
	_sell = _b select 2;
	_lease = _b select 3;
	_totaloccupants = _b select 4;

	_money = player getVariable "money";
	
	if(_type == "buy" and _money < _price) exitWith {"You cannot afford that" call notify_minor};

	
	_mrkid = format["bdg-%1",_building];
	_owned = player getVariable "owned";
	
	if(_type == "buy") then {
		_building setVariable ["owner",getPlayerUID player,true];
		[-_price] call money;
		
		_mrk = createMarkerLocal [_mrkid,getpos _building];
		_mrk setMarkerShape "ICON";		
		_mrk setMarkerColor "ColorWhite";
		if(typeof _building == OT_warehouse) then {
			_mrk setMarkerType "OT_warehouse";
		}else{
			_mrk setMarkerType "loc_Tourism";
			_mrk setMarkerAlpha 0;
			_mrk setMarkerAlphaLocal 1;
		};
		
		_owned pushback ([_building] call fnc_getBuildID);
		[player,"Building Purchased",format["Bought: %1 in %2 for $%3",getText(configFile >> "CfgVehicles" >> (typeof _building) >> "displayName"),(getpos _building) call nearestTown,_price]] call BIS_fnc_createLogRecord;
		if(_price > 10000) then {
			[_town,round(_price / 10000)] call standing;		
		};
	}else{
		_building setVariable ["owner",nil,true];
		_building setVariable ["leased",nil,true];
		deleteMarker _mrkid;
		_owned deleteAt (_owned find ([_building] call fnc_getBuildID));
		[player,"Building Sold",format["Sold: %1 in %2 for $%3",getText(configFile >> "CfgVehicles" >> (typeof _building) >> "displayName"),(getpos _building) call nearestTown,_sell]] call BIS_fnc_createLogRecord;
		[_sell] call money;
	};
	
	player setVariable ["owned",_owned,true];
		
	
}else{
	"There are no buildings for sale nearby" call notify_minor;
};

