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

	_attachat = [0,0,0];
	if(count _item > 0) then {
		_free = _item select 3;
		if(backpack player == _free) then {
			removeBackpack player;
		};
		_attachat = _item select 5;
	};

	disableUserInput true;

	"Attaching weapon to vehicle" call OT_fnc_notifyMinor;
	[30,false] call progressBar;
	sleep 30;
	disableUserInput false;
	if((!alive player) or (!alive _veh)) exitWith {};

	_wpn = _cls createVehicle [0,0,0];
	_wpn attachto [_veh,_attachat select 0];
	[[_wpn,_attachat select 1],"mpSetDir",true,true] spawn BIS_fnc_MP;

	_money = player getVariable "money";
	_money = _money - _price;
	player setvariable ["money",_money,true];
	_veh setVariable ["OT_attachedClass",_cls,true];
	_veh setVariable["OT_attachedClass",_wpn,true];
	_veh setVariable["OT_Local",false,true];

	[_veh] call OT_fnc_initAttached;

	_veh animate ["hideRearDoor",1];
	_veh animate["hideSeatsRear",1];

	[[_wpn,"GetOut",{(_this select 2) moveInany (attachedTo(_this select 0)); 	doGetOut (_this select 2); }],"addEventHandler",true,true] spawn BIS_fnc_MP;

	 _Dname = getText (configFile >> "cfgVehicles" >> (typeof _wpn) >> "displayName");
	 [[_veh,format["Get in %1 as Gunner",_Dname],"<img size='2' image='\a3\ui_f\data\IGUI\Cfg\Actions\getingunner_ca.paa'/>"],"OT_UpdateGetInState",true,true] spawn BIS_fnc_MP;
};
