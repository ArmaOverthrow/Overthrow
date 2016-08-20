_unit = _this;
private ["_unit","_timer"];

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
			}
		};
	};
	
	if(_container isKindOf "Man" and !(_container call hasOwner)) then {
		_container setVariable ["looted",true,true];
		[_container] spawn {
			sleep 300;
			_n = _this select 0;
			if!(isNil "_n") then {
				deleteVehicle (_this select 0);
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
			_timer = _timer + 2;	
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
			sleep 0.05;
			//chance they will just notice you if your global rep is very high or low
			if(vehicle _unit != _unit) exitWith {
				_bad = false;
				call {
					if !(typeof (vehicle _unit) in AIT_allVehicles) exitWith {
						_bad = true; //They are driving or in a non-civilian vehicle including statics
					};
					//Check if unit is turned out and showing a weapon						
					if([_unit] call CBA_fnc_isTurnedOut) then {
						if ((primaryWeapon _unit != "") or (secondaryWeapon _unit != "") or (handgunWeapon _unit != "") or ((headgear _unit) in AIT_illegalHeadgear) or ((vest _unit) in AIT_illegalVests)) then {
							_bad = true;
						};
					};
				};
				
				if(_bad) then {
					_unit setCaptive false;
					{
						if(side _x == east) then {
							_x reveal [_unit,1.5];					
						};
					}foreach(player nearentities ["Man",200]);
				};
			};
			_totalrep = abs(_unit getVariable ["rep",0]) * 0.5;
			if((_totalrep > 50) and (random 10000 < _totalrep)) exitWith {
				_unit setCaptive false;
				if(isPlayer _unit) then {
					hint "A gang has recognized you";
				};
				{
					if(side _x == east) then {
						_x reveal [_unit,1.5];
					};
				}foreach(player nearentities ["Man",200]);
			};			
			if ((primaryWeapon _unit != "") or (secondaryWeapon _unit != "") or (handgunWeapon _unit != "") or ((headgear _unit) in AIT_illegalHeadgear) or ((vest _unit) in AIT_illegalVests)) exitWith {	
				if(isPlayer _unit) then {
					hint "A gang spotted your weapon";
				};
				_unit setCaptive false;	
				{
					if(side _x == east) then {
						_x reveal [_unit,1.5];
					};
				}foreach(player nearentities ["Man",200]);
			};
			
		}else{				
			if(_unit call unitSeenNATO) then {
				sleep 0.05;
				_town = (getpos _unit) call nearestTown;
				_totalrep = ((_unit getVariable ["rep",0]) * -0.25) + ((_unit getVariable [format["rep%1",_town],0]) * -1);
				if((_totalrep > 50) and (random 10000 < _totalrep)) exitWith {					
					_unit setCaptive false;
					if(isPlayer _unit) then {
						hint "NATO has recognized you";
					};
					{
						if(side _x == west) then {
							_x reveal [_unit,1.5];
						};
						sleep 0.05;
					}foreach(player nearentities ["Man",200]);
				};
				if(((vehicle _unit) != _unit) or count attachedObjects _unit > 0) exitWith {
					_bad = false;
					call {
						if(count attachedObjects _unit > 0) exitWith {
							{
								if(typeOf _x in AIT_staticMachineGuns) exitWith {_bad = true};
							}foreach(attachedObjects _unit);
						};
						if !(typeof (vehicle _unit) in AIT_allVehicles) exitWith {
							_bad = true; //They are driving or in a non-civilian vehicle including statics
						};
						//Check if unit is turned out and showing a weapon						
						if([_unit] call CBA_fnc_isTurnedOut) then {
							if ((primaryWeapon _unit != "") or (secondaryWeapon _unit != "") or (handgunWeapon _unit != "") or ((headgear _unit) in AIT_illegalHeadgear) or ((vest _unit) in AIT_illegalVests)) then {
								_bad = true;
							};
						};
					};
					
					if(_bad) then {
						_unit setCaptive false;
						{
							if(side _x == west) then {
								_x reveal [_unit,1.5];					
							};
							sleep 0.05;
						}foreach(player nearentities ["Man",800]);
					};
				};
				if ((primaryWeapon _unit != "") or (secondaryWeapon _unit != "") or (handgunWeapon _unit != "")) exitWith {	
					if(isPlayer _unit) then {
						hint "NATO has seen your weapon";
					};
					_unit setCaptive false;	
					{
						if(side _x == west) then {
							_x reveal [_unit,1.5];					
						};
						sleep 0.05;
					}foreach(player nearentities ["Man",800]);
				};
				if ((headgear _unit in AIT_illegalHeadgear) or (vest _unit in AIT_illegalVests)) exitWith {
					if(isPlayer _unit) then {
						hint "You are wearing Gendarmerie gear";
					};
					_unit setCaptive false;	
					{
						if(side _x == west) then {
							_x reveal [_unit,1.5];					
						};
						sleep 0.05;
					}foreach(player nearentities ["Man",200]);
				};
			};			
		};
	};
};