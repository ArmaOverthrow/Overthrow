if !(captive player) exitWith {"You cannot buy or manage real estate while wanted" call notify_minor};

_b = player call OT_fnc_nearestRealEstate;
private _handled = false;
private _type = "buy";
private _err = false;
private _isfactory = false;
if(typename _b == "ARRAY") then {
	_building = (_b select 0);
	if !(_building call OT_fnc_hasOwner) then {
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
					format["%1 is now operational",_name] remoteExec ["notify_minor",0,true];
					_name setMarkerColor "ColorGUER";
				};
			}else{
				"The resistance cannot afford this" call notify_minor;
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
						format["%1 is now operational",_name] remoteExec ["notify_minor",0,true];
						_name setMarkerColor "ColorGUER";
					}else{
						"The resistance cannot afford this" call notify_minor;
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
if(_err) exitWith {};
if(_handled) then {
	_building = _b select 0;
	_price = _b select 1;
	_sell = _b select 2;
	_lease = _b select 3;
	_totaloccupants = _b select 4;
	_town = (getpos _building) call OT_fnc_nearestTown;

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
		[player,"Building Purchased",format["Bought: %1 in %2 for $%3",getText(configFile >> "CfgVehicles" >> (typeof _building) >> "displayName"),(getpos _building) call OT_fnc_nearestTown,_price]] call BIS_fnc_createLogRecord;
		if(_price > 10000) then {
			[_town,round(_price / 10000)] call standing;
		};
	}else{
		if ((typeof _building) in OT_allRealEstate) then {
			_building setVariable ["owner",nil,true];
			_building setVariable ["leased",nil,true];
			deleteMarker _mrkid;
			_owned deleteAt (_owned find ([_building] call fnc_getBuildID));
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
		"There are no buildings for sale nearby" call notify_minor;
	};
};
