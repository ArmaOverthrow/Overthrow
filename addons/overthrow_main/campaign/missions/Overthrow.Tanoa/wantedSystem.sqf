private _unit = _this;

private _timer = -1;

_unit setCaptive true;
_unit setVariable ["hiding",0,false];

_unit addEventHandler ["take", {
	_me = _this select 0;
	_container = _this select 1;

	if (captive _me) then {
		_type = typeof _container;
		if(_container isKindOf "Man") then {
			_container setvariable ["looted",true,true];
			[_container] spawn {
				_n = _this select 0;
				sleep 600;
				if !(isNil "_n") then {
					hideBody _n;
				}
			};
			if (!(_container call OT_fnc_hasOwner) and (_me call unitSeen)) then {
				//Looting dead bodies is illegal
				_me setCaptive false;
				_me spawn revealToNATO;
				_me spawn revealToCRIM;
			};
		};
	};
}];

_unit addEventHandler ["Fired", {
	_me = _this select 0;
	_weaponFired = _this select 1;
	_range = 800;
	if (captive _me) then {
		//See if anyone heard the shots
		_silencer = _me weaponAccessories currentMuzzle _me select 0;
		if(!isNil "_silencer" && {_silencer != ""}) then {
			//Shot was suppressed
			_range = 50;
		};

		if({(side _x == west || side _x == east) and ((leader _x) distance _me) < _range} count (allgroups) > 0) exitWith {
			_me setCaptive false;
			_me spawn revealToNATO;
		};
	};
}];

private _delay = 3;

while {alive _unit} do {
	sleep 3;
	//check wanted status
	if(isplayer _unit and !(_unit getVariable["OT_healed",false])) then {
		if(_unit getVariable ["ACE_isUnconscious", false]) then {
			//Look for a medic
			private _medic = objNull;
			private _havepi = false;
			if((items player) find "ACE_epinephrine" > -1) then {_havepi = true};
			{
				if(_havepi or ((side _x == resistance or (_x call OT_fnc_hasOwner)) and !(isPlayer _x))) then {
					if(_havepi or ((items _x) find "ACE_epinephrine" > -1)) then {
						_medic = _x;
					};
				};
				if(!isNull _medic) exitWith{};
			}foreach(player nearentities["CAManBase",50]);
			if(!isNull _medic) then {
				_medic globalchat "On my way to help you";
				[_medic,_unit] call OT_fnc_orderRevivePlayer;
			}else{
				if(isMultiplayer) then {
					_numplayers = count([] call CBA_fnc_players);
					if(_numplayers > 1) then {
						format["%1 is unconscious",name player] remoteExec ["systemChat",0,false];
						_unit setVariable ["OT_healed",true,true];
					}else{
						"You are unconscious, there is no one nearby with Epinephrine to revive you" call notify_minor;
						sleep 5;
						_unit setDamage 1; //rip
					}
				}else{
					player allowdamage false;
					titleText ["You are unconscious, there is no one nearby with Epinephrine to revive you. Respawning...", "BLACK FADED", 2];
					{
						if((_x select [0,4]) == "ace_") then {
							player setVariable [_x,nil];
						};
					}foreach(allvariables player);
					player setdamage 0;
					player setCaptive true;
					sleep 5;
					player setpos (player getVariable "home");
					removeAllWeapons player;
					removeAllItems player;
					removeAllAssignedItems player;
					removeBackpack player;
					removeVest player;
					removeGoggles player;
					removeHeadgear player;

					{
						if((_x select [0,4]) == "ace_") then {
							player setVariable [_x,nil];
						};
					}foreach(allvariables player);
					player setDamage 0;

					-1 call influence;
					sleep 2;
					player setDamage 0;
					player linkItem "ItemMap";
					player switchMove "";
					titleText ["", "BLACK IN", 5];
					sleep 10;
					player allowdamage true;
				};
			}
		}else{
			_unit setVariable ["OT_healed",false,true];
		};
	};

	if !(captive _unit) then {
		//CURRENTLY WANTED
		if(_timer >= 0) then {
			_timer = _timer + 3;
			_unit setVariable ["hiding",30 - _timer,false];
			if(_timer >= 30) then {
				_unit setCaptive true;
			}else{
				if (_unit call unitSeen) then {
					_unit setCaptive false;
					_timer = 0;
					_unit setVariable ["hiding",30,false];
				};
			};
		}else{
			if !(_unit call unitSeen) then {
				_unit setVariable ["hiding",30,false];
				_timer = 0;
			};
		};
	}else{
		//CURRENTLY NOT WANTED
		_timer = -1;
		_unit setVariable ["hiding",0,false];
		private _playerpos = getpos _unit;
		private _altitude = _playerpos select 2;

		if(((vehicle player) isKindOf "Air") and _altitude > 5) then {
			if(captive _unit) then {
				_base = (getpos player) call OT_fnc_nearestObjective;
				if !(isNil "_base") then {
					_base params ["_obpos","_obname"];
					if(_obname in OT_allAirports) then {
						if !(_obname in (server getVariable ["NATOabandoned",[]])) then {
							if(_obpos distance _playerpos < 2000) exitWith {
								if(isPlayer _unit) then {
									"This is a no-fly zone" call notify_minor;
								};
								_unit setCaptive false;
								(vehicle _unit) spawn revealToNATO;
								_delay = 90;
							};
						};
					};
				};
			};
		}else{
			if(_unit call unitSeenCRIM) then {
				sleep 0.1;
				//chance they will just notice you if your global rep is very high or low
				if(count attachedObjects _unit > 0) exitWith {
					{
						if(typeOf _x in OT_staticWeapons) exitWith {
							_unit setCaptive false;
							_unit spawn revealToNATO;
							if(isPlayer _unit) then {
								"A gang has seen the static weapon" call notify_minor;
							};
						};
					}foreach(attachedObjects _unit);
				};
				if((vehicle _unit) != _unit) exitWith {
					_bad = false;
					call {
						if !(typeof (vehicle _unit) in (OT_allVehicles+OT_allBoats)) exitWith {
							_bad = true; //They are driving or in a non-civilian vehicle including statics
						};
						if(driver (vehicle _unit) == _unit) exitWith{};//Drivers are not checked for weapons because you cannot shoot and drive, otherwise...
						if ((primaryWeapon _unit != "") or (secondaryWeapon _unit != "") or (handgunWeapon _unit != "") or ((headgear _unit) in OT_illegalHeadgear) or ((vest _unit) in OT_illegalVests)) then {
							_bad = true;
						};
					};

					if(_bad) then {
						//Set the whole car wanted
						{
							_x setCaptive false;
						}foreach(crew vehicle _unit);
						(vehicle _unit) spawn revealToCRIM;
					};
				};
				if ((primaryWeapon _unit != "") or (secondaryWeapon _unit != "") or (handgunWeapon _unit != "")) exitWith {
					if(isPlayer _unit) then {
						"A gang has seen your weapon" call notify_minor;
					};
					_unit setCaptive false;
					_unit spawn revealToNATO;
				};
				_totalrep = abs(_unit getVariable ["rep",0]) * 0.5;
				if((_totalrep > 50) and (random 1000 < _totalrep)) exitWith {
					_unit setCaptive false;
					if(isPlayer _unit) then {
						"A gang has recognized you" call notify_minor;
					};
					_unit spawn revealToCRIM;
				};
			}else{
				if(_unit call unitSeenNATO) then {
					sleep 0.1;
					_town = (getpos _unit) call OT_fnc_nearestTown;
					_totalrep = ((_unit getVariable ["rep",0]) * -0.25) + ((_unit getVariable [format["rep%1",_town],0]) * -1);
					if((_totalrep > 50) and (random 1000 < _totalrep)) exitWith {
						_unit setCaptive false;
						if(isPlayer _unit) then {
							"NATO has recognized you" call notify_minor;
						};
						_unit spawn revealToNATO;
					};
					if(count attachedObjects _unit > 0) exitWith {
						{
							if(typeOf _x in OT_staticWeapons) exitWith {
								_unit setCaptive false;
								_unit spawn revealToNATO;
								if(isPlayer _unit) then {
									"NATO has seen the static weapon" call notify_minor;
								};
							};
						}foreach(attachedObjects _unit);
					};
					if((vehicle _unit) != _unit) exitWith {
						_bad = false;
						call {
							if !(typeof (vehicle _unit) in (OT_allVehicles+OT_allBoats)) exitWith {
								_bad = true; //They are driving or in a non-civilian vehicle including statics
							};
							if(driver (vehicle _unit) == _unit) exitWith{};//Drivers are not checked for weapons because you cannot shoot and drive, otherwise...
							if ((primaryWeapon _unit != "") or (secondaryWeapon _unit != "") or (handgunWeapon _unit != "") or ((headgear _unit) in OT_illegalHeadgear) or ((vest _unit) in OT_illegalVests)) then {
								_bad = true;
							};
						};

						if(_bad) then {
							//Set the whole car wanted
							_unit setcaptive false;
							(vehicle _unit) spawn revealToNATO;
						};
					};
					if ((primaryWeapon _unit != "") or (secondaryWeapon _unit != "") or (handgunWeapon _unit != "")) exitWith {
						_bad = false;
						if((primaryWeapon _unit) != "ACE_FakePrimaryWeapon") then {
							_bad = true;
						};
						if((secondaryWeapon _unit != "") or (handgunWeapon _unit != "")) then {
							_bad = true;
						};
						if(_bad) then {
							_unit setCaptive false;
							_unit spawn revealToNATO;
						};
					};
					if ((headgear _unit in OT_illegalHeadgear) or (vest _unit in OT_illegalVests)) exitWith {
						if(isPlayer _unit) then {
							"You are wearing Gendarmerie gear" call notify_minor;
						};
						_unit setCaptive false;
						_unit spawn revealToNATO;
					};
					_base = (getpos player) call OT_fnc_nearestObjective;
					if !(isNil "_base") then {
						_base params ["_obpos","_obname"];
						if !(_obname in (server getVariable ["NATOabandoned",[]])) then {
							_dist = 200;
							if (_obname in OT_allComms) then {
								_dist = 60;
							};
							if(_obname in OT_NATO_priority) then {
								_dist = 500;
							};
							if(_obpos distance (getpos player) < _dist) exitWith {
								if(isPlayer _unit) then {
									"You are in a restricted area" call notify_minor;
								};
								_unit setCaptive false;
								_unit spawn revealToNATO;
							};
						};
					};
				};
			};
		};
	};
	private _attack = server getVariable ["NATOattacking",""];
	if(_attack != "") then {
		_pos = server getVariable _attack;
		private _playerpos = getpos _unit;
		if(_pos distance _playerpos < 500) then {
			private _altitude = _playerpos select 2;
			_unit setCaptive false;
			_unit setVariable ["hiding",30,false];
			if(_altitude > 5) then {
				//Radar is active here
				(vehicle _unit) spawn revealToNATO;
			};
		};
	};
};
