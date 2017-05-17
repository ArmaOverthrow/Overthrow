private _civ = OT_interactingWith;

private _town = (getpos player) call OT_fnc_nearestTown;
private _standing = [_town] call OT_fnc_standing;
private _civprice = [_town,"CIV",_standing] call OT_fnc_getPrice;
private _influence = player getvariable "influence";
private _money = player getvariable "money";

private _options = [];

if (side _civ == west) exitWith {
	_options pushBack ["Cancel",{}];
	_options spawn playerDecision;
};

private _canRecruit = true;

private _canBuy = false;
private _canBuyClothes = false;
private _canBuyVehicles = false;
private _canBuyBoats = false;
private _canBuyGuns = false;
private _canSell = false;
private _canSellDrugs = true;
private _canIntel = true;
private _canMission = false;
private _canLocMission = false;

if !((_civ getvariable ["shop",[]]) isEqualTo []) then {_canSellDrugs = true;_canRecruit = false;_canBuy=true;_canSell=true;_canBuyClothes=true};
if (_civ getvariable ["carshop",false]) then {_canSellDrugs = true;_canRecruit = false;_canBuyVehicles=true};
if (_civ getvariable ["harbor",false]) then {_canSellDrugs = true;_canRecruit = false;_canBuyBoats=true};
if (_civ getvariable ["gundealer",false]) then {_canSellDrugs = false;_canRecruit = false;_canBuyGuns=true;_canIntel=false;_canLocMission=true};
if (_civ getvariable ["employee",false]) then {_canSellDrugs = false;_canRecruit = false;_canBuyGuns=false;_canIntel=false};
if (_civ getvariable ["notalk",false]) then {_canSellDrugs = false;_canRecruit = false;_canBuyGuns=false;_canIntel=false};
if (_civ getvariable ["factionrep",false]) then {_canSellDrugs = false;_canRecruit = false;_canBuyGuns=false;_canIntel=false;_canMission=true};

if (_civ call OT_fnc_hasOwner) then {_canRecruit = false;_canIntel = false};

if !((_civ getvariable ["garrison",""]) isEqualTo "") then {_canRecruit = false;_canIntel = false};

if (_canRecruit) then {
	_options pushBack [
		format["Recruit Civilian (-$%1)",_civprice],OT_fnc_recruitCiv
	];
};

if (_canLocMission) then {
	_options pushBack [format["Request Mission"], {
		[] call OT_fnc_getLocalMission;
	}];
	_missions = player getVariable ["mytasks",[]];
	if(count _missions > 0) then {
		_options pushBack [format["Cancel All Missions"], {
			player setVariable ["mytasks",[],true];
		}];
	};
};

if (_canMission) then {
	_factionName = _civ getvariable ["factionrepname",""];
	_faction = _civ getvariable ["faction",""];
	private _standing = [_town] call OT_fnc_standing;
	_options pushback format["<t align='center' size='2'>%1</t><br/><br/><t align='center' size='0.8'>Current Standing: +%2",_factionName,_standing];
	_options pushBack [format["Request Mission"], {
		private _civ = OT_interactingWith;
		[_civ getvariable ["faction",""],_civ getvariable ["factionrepname",""]] call OT_fnc_getMission;
	}];
	_options pushBack [format["Buy Gear"], {
		private _civ = OT_interactingWith;
		_faction = _civ getvariable ["faction",""];
		private _standing = [_town] call OT_fnc_standing;

		_gear = spawner getvariable[format["facweapons%1",_faction],[]];
		_s = [];
		{
			_s pushback [_x,-1];
		}foreach(_gear);
		createDialog "OT_dialog_buy";
		["Tanoa",_standing,_s,1.2] call OT_fnc_buyDialog;
	}];
	_options pushBack [format["Buy Blueprints"], {
		private _civ = OT_interactingWith;
		_faction = _civ getvariable ["faction",""];
		_factionName = _civ getvariable ["factionrepname",""];
		private _standing = [_town] call OT_fnc_standing;

		_gear = spawner getvariable[format["facvehicles%1",_faction],[]];
		_s = [];
		_blueprints = server getVariable ["GEURblueprints",[]];

		{
			if !(_x in _blueprints) then {
				_cost = cost getVariable[_x,[100,0,0,0]];
				_req = 0;
				_base = _cost select 0;
				if(_base > 1000) then {_req = 10};
				if(_base > 5000) then {_req = 20};
				if(_base > 10000) then {_req = 40};
				if(_base > 20000) then {_req = 50};
				if(_base > 30000) then {_req = 60};
				if(_base > 40000) then {_req = 70};
				if(_base > 50000) then {_req = 80};
				if(_base > 60000) then {_req = 90};
				if(_base > 100000) then {_req = 95};

				_s pushback [_x,-1,_standing >= _req,format["+%1 standing to %2 required for this blueprint",_req,_factionName]];
			};
		}foreach(_gear);
		createDialog "OT_dialog_buy";
		["Tanoa",_standing,_s,10] call OT_fnc_buyDialog;
	}];
	_missions = player getVariable ["mytasks",[]];
	if(count _missions > 0) then {
		_options pushBack [format["Cancel All Missions"], {
			player setVariable ["mytasks",[],true];
		}];
	};
};

if (_canBuy) then {
	_options pushBack [
		"Buy",{
			private _civ = OT_interactingWith;
			private _town = (getpos player) call OT_fnc_nearestTown;
			private _standing = [_town] call OT_fnc_standing;

			_bp = _civ getVariable "shop";
			_s = [];
			{
				_pos = _x select 0;
				if(format["%1",_pos] == _bp) exitWith {
					_s = _x select 1;
				};
			}foreach(server getVariable [format["activeshopsin%1",_town],[]]);

			player setVariable ["shopping",_civ,false];
			createDialog "OT_dialog_buy";
			[_town,_standing,_s] call OT_fnc_buyDialog;
		}
	];
};

if (_canBuyClothes) then {
	_options pushBack [
		"Buy Clothing",{
			private _civ = OT_interactingWith;
			private _town = (getpos player) call OT_fnc_nearestTown;
			player setVariable ["shopping",_civ,false];
			createDialog "OT_dialog_buy";
			[_town,[_town] call OT_fnc_standing] call OT_fnc_buyClothesDialog;
		}
	];
};

if (_canBuyBoats) then {
	_options pushBack [
		"Buy Boat",{
			createDialog "OT_dialog_buy";
			{
				private _civ = OT_interactingWith;
				_cls = _x select 0;
				private _town = (getpos player) call OT_fnc_nearestTown;
				private _standing = [_town] call OT_fnc_standing;

				_price = [_town,_cls,_standing] call OT_fnc_getPrice;
				if("fuel depot" in (server getVariable "OT_NATOabandoned")) then {
					_price = round(_price * 0.5);
				};
				_idx = lbAdd [1500,format["%1",_cls call ISSE_Cfg_Vehicle_GetName]];
				lbSetPicture [1500,_idx,_cls call ISSE_Cfg_Vehicle_GetPic];
				lbSetData [1500,_idx,_cls];
				lbSetValue [1500,_idx,_price];
			}foreach(OT_boats);
		}
	];
	_options pushBack [
		"Ferry Service",{
			"Where do you want to go?" call OT_fnc_notifyMinor;
			_ferryoptions = [];
			{
				private _p = markerPos(_x);
				private _t = _p call OT_fnc_nearestTown;
				private _dist = (player distance _p);
				private _cost = floor(_dist * 0.005);
				private _go = {
					private _destpos = _this;
					player setVariable ["OT_ferryDestination",_destpos,false];
					private _desttown = _destpos call OT_fnc_nearestTown;
					private _pos = (getpos player) findEmptyPosition [10,100,OT_vehType_ferry];
					if (count _pos == 0) exitWith {"Not enough space, please clear an area nearby" call OT_fnc_notifyMinor};
					private _cost = floor((player distance _destpos) * 0.005);
					player setVariable ["OT_ferryCost",_cost,false];
					_money = player getVariable "money";
					if(_money < _cost) exitWith {"You cannot afford that!" call OT_fnc_notifyMinor};

					[-_cost] call money;
					_veh = OT_vehType_ferry createVehicle _pos;

					clearWeaponCargoGlobal _veh;
					clearMagazineCargoGlobal _veh;
					clearBackpackCargoGlobal _veh;
					clearItemCargoGlobal _veh;

					private _dir = 0;
					while {!(surfaceIsWater ([_pos,800,_dir] call BIS_fnc_relPos)) and _dir < 360} do {
						_dir = _dir + 45;
					};

					_veh setDir _dir;
					player reveal _veh;
					createVehicleCrew _veh;
					_veh lockDriver true;
					private _driver = driver _veh;
					player moveInCargo _veh;

					_driver globalchat format["Departing for %1 in 15 seconds",_desttown];

					sleep 10;
					_driver globalchat format["Departing in 5 seconds",_desttown];
					sleep 5;

					private _g = group (driver _veh);
					private _wp = _g addWaypoint [_destpos,50];
					_wp setWaypointType "MOVE";
					_wp setWaypointSpeed "NORMAL";

					_veh addEventHandler ["GetOut", {
						params ["_vehicle","_position","_unit"];
						_unit setVariable ["OT_ferryDestination",[],false];
					}];

					systemChat format["Departing for %1, press Y to skip (-$%2)",_desttown,_cost];

					waitUntil {!alive player or !alive _veh or !alive _driver or (vehicle player == player) or (player distance _destpos < 80)};

					if(vehicle player == _veh and alive _driver) then {
						_driver globalchat format["We've arrived in %1, enjoy your stay",_desttown];
					};
					sleep 30;
					if(vehicle player == _veh and alive _driver) then {
						moveOut player;
						_driver globalchat "k, bye";
					};
					if(random 100 > 90) then {
						[player] spawn OT_fnc_NATOsearch;
					};
					if(!alive _driver) exitWith{};
					_timeout = time + 800;

					_wp = _g addWaypoint [_pos,0];
					_wp setWaypointType "MOVE";
					_wp setWaypointSpeed "NORMAL";

					waitUntil {_veh distance _pos < 100 or time > _timeout};
					if(!alive _driver) exitWith{};

					deleteVehicle _driver;
					deleteVehicle _veh;
				};
				if(_dist > 1000) then {
					_ferryoptions pushback [format["%1 (-$%2)",_t,_cost],_go,_p];
				};
			}foreach(OT_ferryDestinations);
			_ferryoptions spawn playerDecision;
		}
	];
};

if (_canBuyVehicles) then {
	_options pushBack [
		"Buy Vehicles",buyVehicleDialog
	];
};

if (_canBuyGuns) then {
	_options pushBack [
		"Buy",gunDealerDialog
	];
};

if (_canSell) then {
	_options pushBack [
		"Sell",{
			private _civ = OT_interactingWith;
			private _town = (getpos player) call OT_fnc_nearestTown;
			private _standing = [_town] call OT_fnc_standing;

			_bp = _civ getVariable "shop";
			_s = [];
			{
				_pos = _x select 0;
				if(format["%1",_pos] == _bp) exitWith {
					_s = _x select 1;
				};
			}foreach(server getVariable [format["activeshopsin%1",_town],[]]);

			_playerstock = player call OT_fnc_unitStock;
			player setVariable ["shopping",_civ,false];
			createDialog "OT_dialog_sell";
			[_playerstock,_town,_standing,_s] call OT_fnc_sellDialog;
		}
	];
};
OT_drugSelling = "";
OT_drugQty = 0;

if (_canSellDrugs) then {
	{
		_drugcls = _x;
		if(((items player) find _x) > -1 and !(_civ getVariable["OT_askedDrugs",false])) then {

			_drugname = _x call ISSE_Cfg_Weapons_GetName;
			_options pushBack [format ["Sell %1",_drugname],{
				OT_drugSelling = _this;
				_drugcls = _this;
				_drugname = _drugcls call ISSE_Cfg_Weapons_GetName;
				if(((items player) find _drugcls) == -1) exitWith {};
				_num = 0;
				{
					if(_x select 0 == _drugcls) exitWith {_num = _x select 1};
				}foreach(player call OT_fnc_unitStock);
				OT_drugQty = _num;

				private _town = (getpos player) call OT_fnc_nearestTown;
				private _price = [_town,_drugcls] call OT_fnc_getDrugPrice;
				private _civ = OT_interactingWith;
				_civ setVariable["OT_askedDrugs",true,true];


				player globalchat ([format["Would you like to buy some %1?",_drugname],format["Wanna buy some %1?",_drugname],format["Hey, want some %1?",_drugname],format["You wanna buy some %1?",_drugname],format["Pssst! %1?",_drugname],format["Hey you looking for any %1?",_drugname]] call BIS_fnc_selectRandom);

				if(side _civ == civilian) then {
					_price = round(_price * 1.2);
					if(player call unitSeenNATO) then {
						[player] remoteExec ["OT_fnc_NATOsearch",2,false];
					}else{
						if((random 100) > 68) then {
							[_civ,player,["How much?",format["$%1",_price],"OK"],
							{

								[
									round(
										([(getpos player) call OT_fnc_nearestTown,OT_drugSelling] call OT_fnc_getDrugPrice)*1.2
									)
								] call money;
								player removeItem OT_drugSelling;
								OT_interactingWith addItem OT_drugSelling;
								OT_interactingWith setVariable ["OT_Talking",false,true];
								private _town = (getpos player) call OT_fnc_nearestTown;
								if((random 100 > 50) and !isNil "_town") then {
									[_town,-1] call stability;
								};
								if(random 100 > 80) then {
									1 call influence;
								};
							}] spawn OT_fnc_doConversation;
						}else{
							[_civ,player,["No, thank you"],{(player getvariable "hiringciv") setVariable ["OT_Talking",false,true];}] spawn OT_fnc_doConversation;
						};
					};
				}else{
					_price = ["Tanoa",_drugcls] call OT_fnc_getDrugPrice;
					if(player call unitSeenNATO) then {
						[player] remoteExec ["OT_fnc_NATOsearch",2,false];
					}else{
						if((random 100) > 5) then {
							[_civ,player,[format["OK I'll give you $%1 for each",_price],"OK"],{[(["Tanoa",OT_drugSelling] call OT_fnc_getDrugPrice) * OT_drugQty] call money;for "_t" from 1 to OT_drugQty do {player removeItem OT_drugSelling};OT_interactingWith setVariable ["OT_Talking",false,true];}] spawn OT_fnc_doConversation;
							[_town,-OT_drugQty] call stability;
						}else{
							[_civ,player,["No, go away!"],{(player getvariable "hiringciv") setVariable ["OT_Talking",false,true];player setCaptive false;}] spawn OT_fnc_doConversation;
							if(player call unitSeenCRIM) then {
								hint "You are dealing on enemy turf";
								player setCaptive false;
							};
						};
					};
				};
			},_drugcls];
		};
	}foreach(OT_allDrugs);
};

_options pushBack ["Cancel",{

}];

_options spawn playerDecision;
