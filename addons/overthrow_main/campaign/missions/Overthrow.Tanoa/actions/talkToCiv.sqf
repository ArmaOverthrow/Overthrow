private _civ = player getvariable "hiringciv";

private _town = (getpos player) call nearestTown;
private _standing = player getvariable format["rep%1",_town];
private _civprice = [_town,"CIV",_standing] call getPrice;
private _influence = player getvariable "influence";
private _money = player getvariable "money";

private _options = [];

if(_money >= _civprice) then {
	_options pushBack [
		format["Recruit Civilian (-$%1)",_civprice],recruitCiv
	];
};
if(_influence >= 1) then {
	_options pushBack ["Ask about Gendarmerie (-1 influence)",{
		
	}];
};
if(((items player) find "OT_Ganja") > -1 and !(_civ getVariable["OT_askedDrugs",false])) then {
	
	_options pushBack ["Sell Ganja",{
		if(((items player) find "OT_Ganja") == -1) exitWith {};
		
		private _town = (getpos player) call nearestTown;
		private _price = [_town,"OT_Ganja"] call getDrugPrice;
		private _civ = player getvariable "hiringciv";
		_civ setVariable["OT_askedDrugs",true,true];
		_civ setVariable["OT_talking",true,true];
		if((random 100) > 75) then {
			if(player call unitSeenNATO) then {
				[player] remoteExec ["NATOsearch",2];
			};
			[player,_civ,["Would you like to buy some ganja?","How much?",format["$%1",_price],"OK"],{[([(getpos player) call nearestTown,"OT_Ganja"] call getDrugPrice)] call money;player removeItem "OT_Ganja";(player getvariable "hiringciv") setVariable ["OT_Talking",false,true];}] spawn doConversation;
		}else{
			[player,_civ,["Would you like to buy some ganja?","No, thank you"],{(player getvariable "hiringciv") setVariable ["OT_Talking",false,true];}] spawn doConversation;
		};
	}];
};

_options pushBack ["Cancel",{
	
}];

_options spawn playerDecision;

					