_b = player call OT_fnc_nearestRealEstate;
private _handled = false;
private _type = "buy";
private _err = false;
private _isfactory = false;
if(typename _b == "ARRAY") then {
	_building = (_b select 0);
	if(typeof _building == OT_item_Flag) then {
		_err = true;
		[] call OT_fnc_garrisonDialog;
	}else{
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
}else{
	_ob = (position player) call OT_fnc_nearestObjective;
	_dist = (_ob select 0) distance player;
	_name = _ob select 1;

	if (_dist < 250 and _name in (server getVariable ["NATOabandoned",[]])) then {
		_err = true;
		[] call OT_fnc_garrisonDialog;
	}else{
		_b = (position player) call OT_fnc_nearestLocation;
		if((_b select 1) == "Business") then {
			if (call OT_fnc_playerIsGeneral) then {
				_name = (_b select 0);
				_pos = (_b select 2) select 0;
				_price = _name call OT_fnc_getBusinessPrice;
				_err = true;
				_money = [] call OT_fnc_resistanceFunds;
				if(_money >= _price) then {
					[-_price] call OT_fnc_resistanceFunds;
					_owned = server getVariable ["GEURowned",[]];
					if(_owned find _name == -1) then {
						server setVariable ["GEURowned",_owned + [_name],true];
						server setVariable [format["%1employ",_name],2];
						_pos remoteExec ["OT_fnc_resetSpawn",2,false];
						format["%1 is now operational",_name] remoteExec ["OT_fnc_notifyMinor",0,true];
						_name setMarkerColor "ColorGUER";
					};
				}else{
					"The resistance cannot afford this" call OT_fnc_notifyMinor;
				};
			};
		}else{
			if((getpos player) distance OT_factoryPos < 150) then {
				if (call OT_fnc_playerIsGeneral) then {
					_name = "Factory";

					_owned = server getVariable ["GEURowned",[]];
					if(_owned find _name == -1) then {
						_pos = OT_factoryPos;
						_price = _name call OT_fnc_getBusinessPrice;
						_err = true;
						_money = [] call OT_fnc_resistanceFunds;
						if(_money >= _price) then {
							[-_price] call OT_fnc_resistanceFunds;
							server setVariable ["GEURowned",_owned + [_name],true];
							server setVariable [format["%1employ",_name],2];
							_pos remoteExec ["OT_fnc_resetSpawn",2,false];
							format["%1 is now operational",_name] remoteExec ["OT_fnc_notifyMinor",0,true];
							_name setMarkerColor "ColorGUER";
						}else{
							"The resistance cannot afford this" call OT_fnc_notifyMinor;
						};
					}else{
						//Manage
						[] spawn OT_fnc_factoryDialog;
						_isfactory = true;
					};
				};
			};
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
	_town = (getpos _building) call OT_fnc_nearestTown;

	_money = player getVariable "money";

	if(_type == "buy" and _money < _price) exitWith {"You cannot afford that" call OT_fnc_notifyMinor};


	_mrkid = format["bdg-%1",_building];
	_owned = player getVariable "owned";

	if(_type == "buy") then {
		[_building,getPlayerUID player] call OT_fnc_setOwner;
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
		_id = [_building] call fnc_getBuildID;
		buildingpositions setVariable [str _id,position _building,true];
		_owned pushback _id;
		[player,"Building Purchased",format["Bought: %1 in %2 for $%3",getText(configFile >> "CfgVehicles" >> (typeof _building) >> "displayName"),(getpos _building) call OT_fnc_nearestTown,_price]] call BIS_fnc_createLogRecord;
		if(_price > 10000) then {
			[_town,round(_price / 10000)] call standing;
		};
		_bdg addEventHandler ["Dammaged",compileFinal preprocessFileLineNumbers "events\buildingDamaged.sqf"];
	}else{
		if ((typeof _building) in OT_allRealEstate) then {
			[_building,nil] call OT_fnc_setOwner;
			_id = [_building] call fnc_getBuildID;
			_leased = player getVariable ["leased",[]];
			_leased deleteAt (_leased find _id);
			player setVariable ["leased",_leased,true];
			deleteMarker _mrkid;
			_owned deleteAt (_owned find _id);
			[player,"Building Sold",format["Sold: %1 in %2 for $%3",getText(configFile >> "CfgVehicles" >> (typeof _building) >> "displayName"),(getpos _building) call OT_fnc_nearestTown,_sell]] call BIS_fnc_createLogRecord;
			[_sell] call money;
		}else{
			deleteVehicle _building;
			_owned deleteAt (_owned find ([_building] call fnc_getBuildID));
		};
	};

	player setVariable ["owned",_owned,true];


}else{
	if !(_isfactory) then {
		"There are no buildings for sale nearby" call OT_fnc_notifyMinor;
	};
};
