_shopkeeper = _this;

_shopkeeper addAction ["Buy", {
	_b = nearestBuilding getPos player;
	_s = _b getVariable "stock";
	_town = (getpos player) call nearestTown;
	_standing = player getVariable format['rep%1',_town];
	createDialog "AIT_dialog_buy";
	{			
		_cls = _x select 0;
		_num = _x select 1;
		_price = [_town,_cls,_standing] call getPrice;
		_idx = lbAdd [1500,format["%1 x %2 ($%3)",_num,_cls call ISSE_Cfg_Weapons_GetName,_price]];
		lbSetData [1500,_idx,_cls];
	}foreach(_s);
	
},_shopkeeper,1.5,false,true,"","",5];

_shopkeeper addAction ["Sell", {
	_b = nearestBuilding getPos player;
	_s = player call unitStock;
	_town = (getpos player) call nearestTown;
	_standing = (player getVariable format['rep%1',_town]) * -1;
	createDialog "AIT_dialog_sell";
	{			
		_cls = _x select 0;
		_num = _x select 1;
		_price = [_town,_cls,_standing+40] call getPrice;
		_idx = lbAdd [1500,format["%1 x %2 ($%3)",_num,_cls call ISSE_Cfg_Weapons_GetName,_price]];
		lbSetData [1500,_idx,_cls];
	}foreach(_s);
	
},_shopkeeper,1.5,false,true,"","",5];

_shopkeeper addAction ["Ask about weapons", {
	_me = _this select 3;
	_me removeAction 2;
	
	_town = (getpos player) call nearestTown;	
	_standing = (player getVariable format['rep%1',_town]);
	_ok = false;
	
	if(_standing > -20) then {
		_ok = (random 100) > (80 - _standing);		
	};
	
	if(_ok) then {
		hint "I have heard about a guy that sells guns, I'll mark it on your map";
		_pos = server getVariable format["gundealer%1",_town];
		_mrk = createMarkerLocal [format["gundealer%1",_town],_pos];
		_mrk setMarkerType "hd_objective";
		_mrk setMarkerColor "ColorWhite";
		_mrk setMarkerAlpha 0;
		_mrk setMarkerAlphaLocal 1;
		_mrk setMarkerShape "ICON";
	}else{
		if(_standing < -19) then {
			hint "I don't think I should be telling someone like you that";
		}else{
			if(_standing < 20) then {
				hint "I'm sorry, who are you?";
			}else{
				hint "With all due respect, I must decline";
			}
		};		
	};
},_shopkeeper,1.5,false,true,"","",5];