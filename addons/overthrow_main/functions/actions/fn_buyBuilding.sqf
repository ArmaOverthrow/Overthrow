_b = player call OT_fnc_nearestRealEstate;
private _handled = false;
private _type = "buy";
private _isfactory = false;
if(typename _b == "ARRAY") then {
	_building = (_b select 0);
	if !(_building call OT_fnc_hasOwner) then {
		_handled = true;
	}else{
		_owner = _building call OT_fnc_getOwner;
		if(_owner == getplayeruid player) then {
			_home = player getVariable "home";
			if(_home distance _building < 5) exitWith {"You cannot sell your home" call OT_fnc_notifyMinor;_err = true};
			_type = "sell";
			_handled = true;
		};
	};
};
if(_handled) then {
	_building = _b select 0;
	_price = _b select 1;
	_sell = _b select 2;
	_lease = _b select 3;
	_totaloccupants = _b select 4;
	_town = (getpos _building) call OT_fnc_nearestTown;

	_money = player getVariable "money";

	if(_type == "buy" and _money < _price) exitWith {"You cannot afford that" call OT_fnc_notifyMinor};


	_mrkid = format["bdg-%1",_building];
	_owned = player getVariable "owned";

	if(_type == "buy") then {
		_id = [_building] call OT_fnc_getBuildID;
		[_id,getPlayerUID player] call OT_fnc_setOwner;
		[-_price] call OT_fnc_money;

		buildingpositions setVariable [_id,position _building,true];
		_owned pushback _id;
		[player,"Building Purchased",format["Bought: %1 in %2 for $%3",getText(configFile >> "CfgVehicles" >> (typeof _building) >> "displayName"),(getpos _building) call OT_fnc_nearestTown,_price]] call BIS_fnc_createLogRecord;
		if(_price > 10000) then {
			[_town,round(_price / 10000)] call OT_fnc_standing;
		};
		_building addEventHandler ["Dammaged",OT_fnc_buildingDamagedHandler];
	}else{
		if ((typeof _building) in OT_allRealEstate) then {
			_id = [_building] call OT_fnc_getBuildID;
			[_id,nil] call OT_fnc_setOwner;
			_leased = player getVariable ["leased",[]];
			_leased deleteAt (_leased find _id);
			player setVariable ["leased",_leased,true];
			deleteMarker _mrkid;
			_owned deleteAt (_owned find _id);
			[player,"Building Sold",format["Sold: %1 in %2 for $%3",getText(configFile >> "CfgVehicles" >> (typeof _building) >> "displayName"),(getpos _building) call OT_fnc_nearestTown,_sell]] call BIS_fnc_createLogRecord;
			[_sell] call OT_fnc_money;
		}else{
			deleteVehicle _building;
			_owned deleteAt (_owned find ([_building] call OT_fnc_getBuildID));
		};
	};

	player setVariable ["owned",_owned,true];


}else{
	if !(_isfactory) then {
		"There are no buildings for sale nearby" call OT_fnc_notifyMinor;
	};
};
