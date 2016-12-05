private _civ = OT_interactingWith;

private _town = (getpos player) call nearestTown;
private _standing = player getvariable format["rep%1",_town];
private _civprice = [_town,"CIV",_standing] call getPrice;
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

if !((_civ getvariable ["shop",[]]) isEqualTo []) then {_canSellDrugs = true;_canRecruit = false;_canBuy=true;_canSell=true;_canBuyClothes=true};
if (_civ getvariable ["carshop",false]) then {_canSellDrugs = true;_canRecruit = false;_canBuyVehicles=true};
if (_civ getvariable ["harbor",false]) then {_canSellDrugs = true;_canRecruit = false;_canBuyBoats=true};
if (_civ getvariable ["gundealer",false]) then {_canSellDrugs = false;_canRecruit = false;_canBuyGuns=true;_canIntel=false};

if (_civ call hasOwner) then {_canRecruit = false;_canIntel = false};

if !((_civ getvariable ["garrison",""]) isEqualTo "") then {_canRecruit = false;_canIntel = false};

if (_canRecruit) then {
	_options pushBack [
		format["Recruit Civilian (-$%1)",_civprice],recruitCiv
	];
};

if (_canIntel) then {
	_options pushBack ["Probe for intel (-1 Influence)", getIntel];
};

if (_canBuy) then {
	_options pushBack [
		"Buy",{
			private _civ = OT_interactingWith;
			private _town = (getpos player) call nearestTown;
			private _standing = player getvariable format["rep%1",_town];

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
			[_town,_standing,_s] call buyDialog;
		}
	];
};

if (_canBuyClothes) then {
	_options pushBack [
		"Buy Clothing",{
			private _civ = OT_interactingWith;
			private _town = (getpos player) call nearestTown;
			private _standing = player getvariable format["rep%1",_town];
			player setVariable ["shopping",_civ,false];
			createDialog "OT_dialog_buy";
			[_town,_standing] call buyClothesDialog;
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
				private _town = (getpos player) call nearestTown;
				private _standing = player getvariable format["rep%1",_town];

				_price = [_town,_cls,_standing] call getPrice;
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
			"Where do you want to go?" call notify_minor;
			_ferryoptions = [];
			{
				private _p = markerPos(_x);
				private _t = _p call nearestTown;
				private _dist = (player distance _p);
				private _cost = floor(_dist * 0.005);
				private _go = {
					private _destpos = _this;
					player setVariable ["OT_ferryDestination",_destpos,false];
					private _desttown = _destpos call nearestTown;
					private _pos = (getpos player) findEmptyPosition [10,100,OT_vehType_ferry];
					if (count _pos == 0) exitWith {"Not enough space, please clear an area nearby" call notify_minor};
					private _cost = floor((player distance _destpos) * 0.005);
					player setVariable ["OT_ferryCost",_cost,false];
					_money = player getVariable "money";
					if(_money < _cost) exitWith {"You cannot afford that!" call notify_minor};

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
						[player] spawn NATOsearch;
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
			private _town = (getpos player) call nearestTown;
			private _standing = player getvariable format["rep%1",_town];

			_bp = _civ getVariable "shop";
			_s = [];
			{
				_pos = _x select 0;
				if(format["%1",_pos] == _bp) exitWith {
					_s = _x select 1;
				};
			}foreach(server getVariable [format["activeshopsin%1",_town],[]]);

			_playerstock = player call unitStock;
			player setVariable ["shopping",_civ,false];
			createDialog "OT_dialog_sell";
			[_playerstock,_town,_standing,_s] call sellDialog;
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
				}foreach(player call unitStock);
				OT_drugQty = _num;

				private _town = (getpos player) call nearestTown;
				private _price = [_town,_drugcls] call getDrugPrice;
				private _civ = OT_interactingWith;
				_civ setVariable["OT_askedDrugs",true,true];


				player globalchat ([format["Would you like to buy some %1?",_drugname],format["Wanna buy some %1?",_drugname],format["Hey, want some %1?",_drugname],format["You wanna buy some %1?",_drugname],format["Pssst! %1?",_drugname],format["Hey you looking for any %1?",_drugname]] call BIS_fnc_selectRandom);

				if(side _civ == civilian) then {
					_price = round(_price * 1.2);
					if(player call unitSeenNATO) then {
						[player] remoteExec ["NATOsearch",2,false];
					}else{
						if((random 100) > 68) then {
							[_civ,player,["How much?",format["$%1",_price],"OK"],
							{

								[
									round(
										([(getpos player) call nearestTown,OT_drugSelling] call getDrugPrice)*1.2
									)
								] call money;
								player removeItem OT_drugSelling;
								OT_interactingWith addItem OT_drugSelling;
								OT_interactingWith setVariable ["OT_Talking",false,true];
								private _town = (getpos player) call nearestTown;
								if((random 100 > 50) and !isNil "_town") then {
									[_town,-1] call stability;
								};
								if(random 100 > 80) then {
									1 call influence;
								};
							}] spawn doConversation;
						}else{
							[_civ,player,["No, thank you"],{(player getvariable "hiringciv") setVariable ["OT_Talking",false,true];}] spawn doConversation;
						};
					};
				}else{
					_price = ["Tanoa",_drugcls] call getDrugPrice;
					if(player call unitSeenNATO) then {
						[player] remoteExec ["NATOsearch",2,false];
					}else{
						if((random 100) > 5) then {
							[_civ,player,[format["OK I'll give you $%1 for each",_price],"OK"],{[(["Tanoa",OT_drugSelling] call getDrugPrice) * OT_drugQty] call money;for "_t" from 1 to OT_drugQty do {player removeItem OT_drugSelling};OT_interactingWith setVariable ["OT_Talking",false,true];}] spawn doConversation;
							[_town,-OT_drugQty] call stability;
						}else{
							[_civ,player,["No, go away!"],{(player getvariable "hiringciv") setVariable ["OT_Talking",false,true];player setCaptive false;}] spawn doConversation;
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
