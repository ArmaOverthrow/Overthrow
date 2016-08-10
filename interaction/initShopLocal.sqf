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
		_name = "";
		if(_cls in AIT_allBackpacks) then {
			_name = _cls call ISSE_Cfg_Vehicle_GetName;
		}else{
			_name = _cls call ISSE_Cfg_Weapons_GetName;
		};
		_idx = lbAdd [1500,format["%1 x %2 ($%3)",_num,_name,_price]];
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
		if!(_cls in AIT_allMagazines + AIT_illegalItems + AIT_illegalHeadgear + AIT_illegalVests + AIT_allWeapons) then {
			_num = _x select 1;			
			_price = [_town,_cls,_standing] call getSellPrice;
			_mynum = 0;
			_s = _b getVariable "stock";
			{
				_c = _x select 0;
				if(_c == _cls) exitWith {_mynum = _x select 1};				
			}foreach(_s);
						
			if(_mynum > 10) then {
				_price = ceil(_price * 0.75);
			};
			if(_mynum > 20) then {
				_price = ceil(_price * 0.5);
			};
			if(_mynum > 50) then {
				_price = 1;
			};
			if(_price <= 0) then {_price = 1};
			
			_name = "";
			if(_cls in AIT_allBackpacks) then {
				_name = _cls call ISSE_Cfg_Vehicle_GetName;
			}else{
				_name = _cls call ISSE_Cfg_Weapons_GetName;
			};
			_idx = lbAdd [1500,format["%1 x %2 ($%3)",_num,_name,_price]];
			lbSetData [1500,_idx,_cls];
		};
	}foreach(_s);
	
},_shopkeeper,1.5,false,true,"","",5];

_shopkeeper addAction ["Ask about weapons", {
	_me = _this select 3;
	_me removeAction 2;
	
	_town = (getpos player) call nearestTown;	
	_pos = server getVariable [format["gundealer%1",_town],false];
	
	if(typename _pos != "ARRAY") exitWith {
		"Not in this town, I'm sorry" call notify_talk;
	};
	
	_standing = player getVariable 'rep';
	_ok = false;
	
	if(_standing > -20) then {
		_ok = (random 100) > (60 - _standing);		
	};
	
	if(_ok) then {
		"Sure, I can hook you up with a guy. I'll mark him on your map." call notify_talk;

		_mrk = createMarkerLocal [format["gundealer%1",_town],_pos];
		_mrk setMarkerType "hd_objective";
		_mrk setMarkerColor "ColorWhite";
		_mrk setMarkerAlpha 0;
		_mrk setMarkerAlphaLocal 1;
		_mrk setMarkerShape "ICON";
	}else{
		if(_standing < -19) then {
			"I don't think I should be telling someone like you that" call notify_talk;
		}else{
			if(_standing < 20) then {
				"No idea what you're talking about" call notify_talk;
			}else{
				"With all due respect, I must decline" call notify_talk;
			}
		};		
	};
},_shopkeeper,1.5,false,true,"","",5];