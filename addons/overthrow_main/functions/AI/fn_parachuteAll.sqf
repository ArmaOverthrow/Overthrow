private ["_paras","_vehicle","_chuteHeight","_dir"];
_vehicle = _this select 0;
_chuteheight = if ( count _this > 1 ) then { _this select 1 } else { 100 };
_vehicle allowDamage false;
_paras = assignedcargo _vehicle;
_dir = direction _vehicle;

paraLandSafe =
{
	private ["_unit"];
	_unit = _this select 0;
	_chuteheight = _this select 1;
	(vehicle _unit) allowDamage false;
	if (isPlayer _unit) then {[_unit,_chuteheight] spawn OpenPlayerchute};
	waitUntil { !(alive _unit) or isTouchingGround _unit or (position _unit select 2) < 1 };

	if(!alive _unit) then {
		deleteVehicle _unit;
	}else{
		[_unit, "eject", vehicle _unit] remoteExec ["action",_unit,false];
		sleep 1;
		_inv = name _unit;

		_unit setUnitLoadout (spawner getvariable [format["eject_%1",name _unit],[]]);
		spawner setvariable [format["eject_%1",name _unit],nil,false];

		_unit allowdamage true;// Now you can take damage.
	};
};

OpenPlayerChute =
{
	private ["_paraPlayer"];
	_paraPlayer = _this select 0;
	_chuteheight = _this select 1;
	waitUntil {(position _paraPlayer select 2) <= _chuteheight};
	[_paraPlayer, "openParachute"] remoteExec ["action",_unit,false];
};



{
	spawner setvariable [format["eject_%1",name _x],getUnitLoadout _x,false];
	[_x] remoteExec ["removeBackpack",_x];
	_x disableCollisionWith _vehicle;// Sometimes units take damage when being ejected.
	_x allowdamage false;// Trying to prevent damage.
	[_x, "B_parachute"] remoteExec ["addBackPack",_x];
	unassignvehicle _x;
	moveout _x;
	_x setDir (_dir + 90);// Exit the chopper at right angles.
	sleep 1;
} forEach _paras;

_vehicle allowDamage true;

{
	[_x,_chuteheight] spawn paraLandSafe;
} forEach _paras;
