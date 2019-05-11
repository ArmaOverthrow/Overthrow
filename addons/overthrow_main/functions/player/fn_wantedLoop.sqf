params ["_unit"];

//actually a loop
if!(alive _unit) exitWith {};

//check wanted status
private _timer = _unit getVariable ["OT_wantedTimer",0];
private _hiding = _unit getVariable ["OT_hiding",0];
if !(captive _unit) then {
	//CURRENTLY WANTED
	if(_timer >= 0) then {
		_timer = _timer + 3;
		_hiding = 30 - _timer;
		if(_hiding <= 0) then {
			//hidden for 30 seconds
			_unit setCaptive true;
		}else{
			// seen again?
			if (_unit call OT_fnc_unitSeen) then {
				_unit setCaptive false;
				_timer = 0;
				_hiding = 30;
			};
		};
	}else{
		// Wanted state just started, wait for the first time we are not seen
		if !(_unit call OT_fnc_unitSeen) then {
			_hiding = 30;
			_timer = 0;
		};
	};
}else{
	//CURRENTLY NOT WANTED

	// reset vars for next wanted state
	_timer = -1;
	_hiding = 0;

	private _playerpos = getPosATL _unit;
	private _vehicle = vehicle _unit;

	private _gottem = false;

	//Enemy radar detection/No-fly zones
	if((typeOf _vehicle isKindOf ["Air",configFile>>"CfgVehicles"]) && (_playerpos select 2) > 30) then {
		private _base = _playerpos call OT_fnc_nearestObjective;
		if !(isNil "_base") then {
			_base params ["_obpos","_obname"];
			if(
				_obname in OT_allAirports
				&& { !(_obname in (server getVariable ["NATOabandoned",[]])) }
				&& { _obpos distance2D _playerpos < 2000 }
			) then {
				if(isPlayer _unit) then {
					"This is a no-fly zone" call OT_fnc_notifyMinor;
				};
				_unit setCaptive false;
				[vehicle _unit] call OT_fnc_revealToNATO;
				_gottem = true;
			};
		};
	};

	if(_unit call OT_fnc_unitSeenCRIM && !_gottem) then {
		// carrying a static weapon .. illegal
		if (_unit call OT_fnc_carriesStaticWeapon) exitWith {
			_unit setCaptive false;
			[_unit] call OT_fnc_revealToNATO;
			if(isPlayer _unit) then {
				"A gang has seen the static weapon" call OT_fnc_notifyMinor;
			};
		};

		// driving with weapons, illegal clothing/gear, in illegal vehicles
		if(!(_vehicle isEqualTo _unit) && { _unit call OT_fnc_illegalInCar }) exitWith {
			//Set the whole car wanted
			{
				_x setCaptive false;
			}foreach(crew vehicle _unit);
			[vehicle _unit] call OT_fnc_revealToCRIM;
		};

		// carrying a weapon .. illegal
		if (_unit call OT_fnc_hasWeaponEquipped) exitWith {
			if(isPlayer _unit) then {
				"A gang has seen your weapon" call OT_fnc_notifyMinor;
			};
			_unit setCaptive false;
			[_unit] call OT_fnc_revealToNATO;
		};

		// detected because fame
		if(_unit call OT_fnc_detectedByReputation) exitWith {
			_unit setCaptive false;
			if(isPlayer _unit) then {
				"A gang has recognized you" call OT_fnc_notifyMinor;
			};
			[_unit] call OT_fnc_revealToCRIM;
		};
	}else{
		if(_unit call OT_fnc_unitSeenNATO && !_gottem) then {
			// smoking
			if(_unit getvariable ["ot_isSmoking",false]) exitWith {
				_unit setCaptive false;
				[_unit] call OT_fnc_revealToNATO;
				if(isPlayer _unit) then {
					"NATO has seen your spliff!" call OT_fnc_notifyMinor;
				};
			};
			if(_unit call OT_fnc_carriesStaticWeapon) exitWith {
				_unit setCaptive false;
				[_unit] call OT_fnc_revealToNATO;
				if(isPlayer _unit) then {
					"NATO has seen the static weapon" call OT_fnc_notifyMinor;
				};
			};
			if(!(_vehicle isEqualTo _unit) && { _unit call OT_fnc_illegalInCar }) exitWith {
				//Set the whole car wanted
				_unit setcaptive false;
				{
					_x setcaptive false;
				}forEach(units _vehicle);
				[vehicle _unit] call OT_fnc_revealToNATO;

				//Record any threats as known targets
				(vehicle _unit) call OT_fnc_NATOreportThreat;
			};
			if(_unit call OT_fnc_hasWeaponEquipped) exitWith {
				_unit setCaptive false;
				[_unit] call OT_fnc_revealToNATO;
			};
			if ((headgear _unit in OT_illegalHeadgear) || { (vest _unit in OT_illegalVests) }) exitWith {
				if(isPlayer _unit) then {
					"You are wearing Gendarmerie gear" call OT_fnc_notifyMinor;
				};
				_unit setCaptive false;
				[_unit] call OT_fnc_revealToNATO;
			};
			if !(hmd _unit isEqualTo "") exitWith {
				if(isPlayer _unit) then {
					"NATO has spotted your NV Goggles" call OT_fnc_notifyMinor;
				};
				_unit setCaptive false;
				[_unit] call OT_fnc_revealToNATO;
			};
			private _unitpos = getPosATL _unit;
			private _base = _unitpos call OT_fnc_nearestObjective;
			if !(isNil "_base") then {
				_base params ["_obpos","_obname"];
				private _dist = _obname call {
					if (_this in OT_allComms) exitWith {40};
					if(_this in OT_NATO_priority) exitWith {500};
					200
				};
				if(_obpos distance _unitpos < _dist) exitWith {
					if(isPlayer _unit) then {
						"You are in a restricted area" call OT_fnc_notifyMinor;
					};
					_unit setCaptive false;
					[_unit] call OT_fnc_revealToNATO;
				};
			};
		};
	};
};

// NATO attacks
private _attack = server getVariable ["NATOattacking",""];
if!(_attack isEqualTo "") then {
	private _pos = server getVariable [_attack, [-5000,-5000,0]];
	private _playerpos = getPosATL _unit;
	if(_pos distance2D _playerpos < 1000) then {
		//Radar is active here
		if((_playerpos select 2) > 30) then {
			_unit setCaptive false;
			_hiding = 30;
			_timer = 0;
			[vehicle _unit] call OT_fnc_revealToNATO;
		};
	};
};

// save the vars
_unit setVariable ["OT_wantedTimer",_timer,true];
_unit setVariable ["OT_hiding",_hiding,true];

// loop
[
	OT_fnc_wantedLoop,
	_this,
	3
] call CBA_fnc_waitAndExecute;
