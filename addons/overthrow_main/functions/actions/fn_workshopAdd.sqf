private _idx = lbCurSel 1500;
private _cls = lbData [1500,_idx];
private _price = lbValue [1500,_idx];

private _money = player getVariable ["money",0];
if(_money < _price) exitWith {"You cannot afford that!" call OT_fnc_notifyMinor};

private _veh = cursorTarget;
if(_veh getVariable ["OT_attachedClass",""] != "") exitWith {hint "This vehicle already has a weapon attached"};

closeDialog 0;
if(!alive _veh) exitWith {};


private _item = [];
{
	if((_x select 4) == _cls && (typeof _veh) == (_x select 1)) exitWith {_item = _x};
}foreach(OT_workshop);

if(count _item > 0) then {
	private _free = _item select 3;
	if(backpack player isEqualTo _free) then {
		removeBackpack player;
	};
};

disableUserInput true;

"Attaching weapon to vehicle" call OT_fnc_notifyMinor;
[30,false] call OT_fnc_progressBar;
[
	{
		params ["_veh","_cls","_price"];
		disableUserInput false;
		if((!alive player) || (!alive _veh)) exitWith {};

		_money = player getVariable ["money",0];
		_money = _money - _price;
		player setvariable ["money",_money,true];

		_veh setVariable ["OT_attachedClass",_cls,true];
		[_veh] call OT_fnc_initAttached;
	},
	[_veh,_cls,_price],
	30
] call CBA_fnc_waitAndExecute;
