private ["_paras","_vehicle","_chuteHeight","_dir"];
_vehicle = _this select 0;
_chuteheight = if ( count _this > 1 ) then { _this select 1 } else { 100 };

_paras = assignedcargo _vehicle;
_dir = direction _vehicle;

paraLandSafe =
{
	private ["_unit"];
	_unit = _this select 0;
	_chuteheight = _this select 1;
	if (isPlayer _unit) then {[_unit,_chuteheight] spawn OpenPlayerchute};
	waitUntil { !(alive _unit) or isTouchingGround _unit or (position _unit select 2) < 20 };

	_unit allowDamage false; //So they dont hit trees or die on ground impact

	waitUntil { !(alive _unit) or isTouchingGround _unit or (position _unit select 2) < 1 };

	_unit action ["eject",_unit];
	sleep 1;
	_inv = name _unit;
	_id = [_unit] call OT_fnc_getBuildID;
	_unit setUnitLoadout (spawner getvariable [format["eject_%1",_id],[]]);
	spawner setvariable [format["eject_%1",_id],nil,false];
	_unit allowDamage true;
};

OpenPlayerChute =
{
	private ["_paraPlayer"];
	_paraPlayer = _this select 0;
	_chuteheight = _this select 1;
	waitUntil {(position _paraPlayer select 2) <= _chuteheight};
	_paraPlayer action ["openParachute",_unit];
};



{
	spawner setvariable [format["eject_%1",[_x] call OT_fnc_getBuildID],getUnitLoadout _x,false];
	removeBackpackGlobal _x;
	_x disableCollisionWith _vehicle;// Sometimes units take damage when being ejected.
	_x addBackpackGlobal "B_parachute";
	unassignvehicle _x;
	moveout _x;
	_x setDir (_dir + 90);// Exit the chopper at right angles.
	sleep 1;
} forEach _paras;


{
	[_x,_chuteheight] spawn paraLandSafe;
} forEach _paras;
