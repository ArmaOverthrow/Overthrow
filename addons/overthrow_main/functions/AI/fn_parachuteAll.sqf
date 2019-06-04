params ["_vehicle", ["_chuteheight", 100]];

sleep 5; //Give the helicopter a chance to stop/slow Down

private _paras = assignedcargo _vehicle;
private _dir = direction _vehicle;

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
	[_x,_chuteheight] spawn {
		params ["_unit", "_chuteheight"];

		// land safe if player
		if (isPlayer _unit) then {
			[_unit,_chuteheight] spawn {
				params ["_paraPlayer","_chuteheight"];
				waitUntil {(position _paraPlayer select 2) <= _chuteheight};
				_paraPlayer action ["openParachute",_paraPlayer];
			};
		};
		waitUntil { !(alive _unit) || isTouchingGround _unit || (position _unit select 2) < 20 };

		_unit allowDamage false; //So they dont hit trees or die on ground impact

		waitUntil { !(alive _unit) || isTouchingGround _unit || (position _unit select 2) < 1 };

		_unit action ["Eject",vehicle _unit];
		sleep 2;
		private _inv = name _unit;
		private _id = [_unit] call OT_fnc_getBuildID;
		_unit setUnitLoadout (spawner getvariable [format["eject_%1",_id],[]]);
		spawner setvariable [format["eject_%1",_id],nil,false];
		_unit allowDamage true;
	};
} forEach _paras;

_vehicle setVariable ["OT_deployedTroops",true,false];
