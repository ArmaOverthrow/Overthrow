private _idx = lbCurSel 1500;
private _cls = lbData [1500,_idx];
private _price = lbValue [1500,_idx];

private _money = player getVariable "money";
if(_money < _price) exitWith {"You cannot afford that!" call OT_fnc_notifyMinor};

_veh = cursorTarget;
if(_veh getVariable ["OT_attachedClass",""] != "") exitWith {hint "This vehicle already has a weapon attached"};

closeDialog 0;
if(!alive _veh) exitWith {};


[_veh,_cls,_price] spawn {
	_veh = _this select 0;
	_cls = _this select 1;
	_price = _this select 2;

	private _item = [];
	{
		if((_x select 4) == _cls and (typeof _veh) == (_x select 1)) exitWith {_item = _x};
	}foreach(OT_workshop);

	if(count _item > 0) then {
		_free = _item select 3;
		if(backpack player == _free) then {
			removeBackpack player;
		};
	};

	disableUserInput true;

	"Attaching weapon to vehicle" call OT_fnc_notifyMinor;
	[30,false] call OT_fnc_progressBar;
	sleep 30;
	disableUserInput false;
	if((!alive player) or (!alive _veh)) exitWith {};

	_money = player getVariable "money";
	_money = _money - _price;
	player setvariable ["money",_money,true];

	_veh setVariable ["OT_attachedClass",_cls,true];
	[_veh] call OT_fnc_initAttached;

};
