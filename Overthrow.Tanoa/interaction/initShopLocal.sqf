_shopkeeper = _this;

_shopkeeper addAction ["Buy", {
	_civ = _this select 0;	
	_bp = _civ getVariable "shop";
	_s = [];
	_town = (getpos _civ) call nearestTown;
	{
		_pos = _x select 0;
		if(format["%1",_pos] == _bp) exitWith {
			_s = _x select 1;
		};
	}foreach(server getVariable [format["activeshopsin%1",_town],[]]);

	_standing = player getVariable format['rep%1',_town];
	player setVariable ["shopping",_civ,false];
	createDialog "AIT_dialog_buy";
	[_town,_standing,_s] call buyDialog;
	
},_shopkeeper,1.5,false,true,"","alive _target",5];

_shopkeeper addAction ["Sell", {
	_civ = _this select 0;	
	_bp = _civ getVariable "shop";
	
	_s = [];
	_town = (getpos _civ) call nearestTown;
	{
		_pos = _x select 0;
		if(format["%1",_pos] == _bp) exitWith {
			_s = _x select 1;
		};
	}foreach(server getVariable [format["activeshopsin%1",_town],[]]);
	
	_playerstock = player call unitStock;	
	_standing = (player getVariable format['rep%1',_town]) * -1;
	player setVariable ["shopping",_civ,false];
	createDialog "AIT_dialog_sell";
	[_playerstock,_town,_standing,_s] call sellDialog;
	
},_shopkeeper,1.5,false,true,"","alive _target",5];

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
},_shopkeeper,1.5,false,true,"","alive _target",5];