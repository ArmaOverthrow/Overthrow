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

if !((_civ getvariable ["shop",[]]) isEqualTo []) then {_canSellDrugs = false;_canRecruit = false;_canBuy=true;_canSell=true;_canBuyClothes=true};
if (_civ getvariable ["carshop",false]) then {_canSellDrugs = false;_canRecruit = false;_canBuyVehicles=true};
if (_civ getvariable ["harbor",false]) then {_canSellDrugs = false;_canRecruit = false;_canBuyBoats=true};
if (_civ getvariable ["gundealer",false]) then {_canSellDrugs = false;_canRecruit = false;_canBuyGuns=true};

if (_civ call hasOwner) then {_canRecruit = false;_canIntel = false};

if !((_civ getvariable ["garrison",""]) isEqualTo "") then {_canRecruit = false};

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
								player removeItem OT_drugSelling;OT_interactingWith addItem OT_drugSelling;OT_interactingWith setVariable ["OT_Talking",false,true];															
								
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
						if((random 100) > 1) then {				
							[_civ,player,[format["OK I'll give you $%1 for each",_price],"OK"],{[(["Tanoa",OT_drugSelling] call getDrugPrice) * OT_drugQty] call money;for "_t" from 1 to OT_drugQty do {player removeItem OT_drugSelling};OT_interactingWith setVariable ["OT_Talking",false,true];}] spawn doConversation;
						}else{
							[_civ,player,["No, go away!"],{(player getvariable "hiringciv") setVariable ["OT_Talking",false,true];player setCaptive false;}] spawn doConversation;
						};
					};
					if(player call unitSeenCRIM) then {
						hint "You are dealing on enemy turf";
						player setCaptive false;
					};
				};
			},_drugcls];
		};
	}foreach(OT_allDrugs);
};

_options pushBack ["Cancel",{
	
}];

_options spawn playerDecision;

					