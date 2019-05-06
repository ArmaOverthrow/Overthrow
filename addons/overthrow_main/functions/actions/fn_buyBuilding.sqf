private _b = player call OT_fnc_nearestRealEstate;
private _handled = false;
private _type = "buy";
private _isfactory = false;
if(typename _b isEqualTo "ARRAY") then {
	private _building = (_b select 0);
	if !(_building call OT_fnc_hasOwner) then {
		_handled = true;
	}else{
		private _owner = _building call OT_fnc_getOwner;
		if(_owner isEqualTo getplayeruid player) then {
			_home = player getVariable "home";
			if(_home distance _building < 5) exitWith {"You cannot sell your home" call OT_fnc_notifyMinor;_err = true};
			_type = "sell";
			_handled = true;
		};
	};
};
if(_handled) then {
	_b params ["_building","_price","_sell","_lease","_totaloccupants"];
	private _town = (getpos _building) call OT_fnc_nearestTown;

	private _money = player getVariable ["money",0];

	if(_type == "buy" && _money < _price) exitWith {"You cannot afford that" call OT_fnc_notifyMinor};


	private _mrkid = format["bdg-%1",_building];
	private _owned = player getVariable "owned";

	if(_type isEqualTo "buy") then {
		private _id = [_building] call OT_fnc_getBuildID;
		[_id,getPlayerUID player] call OT_fnc_setOwner;
		[-_price] call OT_fnc_money;

		buildingpositions setVariable [_id,position _building,true];
		_owned pushback _id;
		[player,"Building Purchased",format["Bought: %1 in %2 for $%3",getText(configFile >> "CfgVehicles" >> (typeof _building) >> "displayName"),(getpos _building) call OT_fnc_nearestTown,_price]] call BIS_fnc_createLogRecord;		
		_building addEventHandler ["Dammaged",OT_fnc_buildingDamagedHandler];
	}else{
		if ((typeof _building) in OT_allRealEstate) then {
			private _id = [_building] call OT_fnc_getBuildID;
			[_id,nil] call OT_fnc_setOwner;
			private _leased = player getVariable ["leased",[]];
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
