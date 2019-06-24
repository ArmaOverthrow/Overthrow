{
    private _squad = _x;
    private _leader = leader _x;
    private _pos = getpos _leader;
    if(_pos#2 > 150) then {
        //Parachute
        private _vehicle = vehicle _leader;
        private _paras = (units _squad) - [driver _vehicle, gunner _vehicle, commander _vehicle];
        private _dir = direction _vehicle;
        private _chuteheight = 100;
        _paras allowGetIn false;

        {
        	spawner setvariable [format["eject_%1",[_x] call OT_fnc_getBuildID],getUnitLoadout _x,false];
        	removeBackpackGlobal _x;
        	_x disableCollisionWith _vehicle;// Sometimes units take damage when being ejected.
        	_x addBackpackGlobal "B_parachute";
        	unassignVehicle _x;
            moveOut _x;
        	_x action ["Eject",_vehicle];
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
        		sleep 1;
        		private _inv = name _unit;
        		private _id = [_unit] call OT_fnc_getBuildID;
        		_unit setUnitLoadout (spawner getvariable [format["eject_%1",_id],[]]);
        		spawner setvariable [format["eject_%1",_id],nil,false];
        		_unit allowDamage true;
        	};
        } forEach _paras;
    }else{
        if(_pos#2 > 2) exitWith {hint "Must be at least 150m high to parachute safely"};
        //get out
        _squad leaveVehicle (vehicle player);
        { unassignVehicle _x; } forEach (units _squad);
        (units _x) orderGetIn false;
        (units _squad) allowGetIn false;
    };
    player hcSelectGroup [_squad,false];
}foreach(hcSelected player);
