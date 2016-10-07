private ["_unit","_timer","_bad","_rep","_totalrep"];
_unit = _this;

_timer = -1;

_unit setCaptive true;
_unit setVariable ["hiding",false,false];

_unit addEventHandler ["take", {
	_me = _this select 0;
	_container = _this select 1;
	
	if (captive _me) then {		
		_type = typeof _container;
		if(_container isKindOf "Man") then {
			if (!(_container call hasOwner) and (_me call unitSeen)) then {
				//Looting dead bodies is illegal
				_me setCaptive false;
				_me spawn revealToNATO;
				_me spawn revealToCRIM;
			}
		};
	};
	
	if(_container isKindOf "Man" and !(_container call hasOwner)) then {
		_container setVariable ["looted",true,true];
		[_container] spawn {
			sleep 300;
			_n = _this select 0;
			if!(isNil "_n") then {
				hideBody (_this select 0);
			}
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
		
		if({side _x == west || side _x == east} count (_me nearentities ["Man",_range]) > 0) then {
			_me setCaptive false;
		};
	};
}];

while {alive _unit} do {
	sleep 3;	
	
	//check wanted status
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
				_lastkill = _unit getVariable ["lastkill",0];
				if((time - _lastkill) > 120) then {
					_unit setVariable ["hiding",30,false];	
					_timer = 0;	
				};
			};
		};
	}else{
		//CURRENTLY NOT WANTED
		_timer = -1;
		_unit setVariable ["hiding",0,false];
		
		if(_unit call unitSeenCRIM) then {
			sleep 0.1;
			//chance they will just notice you if your global rep is very high or low
			if(count attachedObjects _unit > 0) exitWith {
				{
					if(typeOf _x in OT_staticWeapons) exitWith {
						_unit setCaptive false;
						_unit spawn revealToNATO;
						if(isPlayer _unit) then {
							hint "A gang has seen the static weapon";
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
					hint "A gang has seen your weapon";
				};
				_unit setCaptive false;	
				_unit spawn revealToNATO;
			};
			_totalrep = abs(_unit getVariable ["rep",0]) * 0.5;
			if((_totalrep > 50) and (random 10000 < _totalrep)) exitWith {
				_unit setCaptive false;
				if(isPlayer _unit) then {
					hint "A gang has recognized you";
				};
				_unit spawn revealToCRIM;
			};
		}else{				
			if(_unit call unitSeenNATO) then {
				sleep 0.1;
				_town = (getpos _unit) call nearestTown;
				_totalrep = ((_unit getVariable ["rep",0]) * -0.25) + ((_unit getVariable [format["rep%1",_town],0]) * -1);
				if((_totalrep > 50) and (random 10000 < _totalrep)) exitWith {					
					_unit setCaptive false;
					if(isPlayer _unit) then {
						hint "NATO has recognized you";
					};
					_unit spawn revealToNATO;
				};
				if(count attachedObjects _unit > 0) exitWith {
					{
						if(typeOf _x in OT_staticWeapons) exitWith {
							_unit setCaptive false;
							_unit spawn revealToNATO;
							if(isPlayer _unit) then {
								hint "NATO has seen the static weapon";
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
						(vehicle _unit) spawn revealToNATO;
					};
				};
				if ((primaryWeapon _unit != "") or (secondaryWeapon _unit != "") or (handgunWeapon _unit != "")) exitWith {	
					if(isPlayer _unit) then {
						hint "NATO has seen your weapon";
					};
					_unit setCaptive false;	
					_unit spawn revealToNATO;
				};
				if ((headgear _unit in OT_illegalHeadgear) or (vest _unit in OT_illegalVests)) exitWith {
					if(isPlayer _unit) then {
						hint "You are wearing Gendarmerie gear";
					};
					_unit setCaptive false;	
					_unit spawn revealToNATO;
				};
				_base = (getpos player) call nearestObjective;
				if !(isNil "_base") then {
					_dist = 200;
					if(((_base select 1) find "Comm") == 0) then {
						_dist = 20;
					};
					if((_base select 0) distance (getpos player) < _dist) exitWith {	
						if(isPlayer _unit) then {
							hint "You are in a restricted area";
						};
						_unit setCaptive false;	
						_unit spawn revealToNATO;
					}
				};
			};			
		};
	};
};