_unit = _this;
private ["_unit","_timer"];

_timer = -1;

_unit setCaptive true;
_unit setVariable ["hiding",false,true];

_unit addEventHandler ["take", {
	_me = _this select 0;
	_container = _this select 1;
	_type = typeof _container;
	if(_container isKindOf "Man") then {
		if !(_container call hasOwner) then {
			//Looting dead bodies is illegal
			_me setCaptive false;
			{
				if((side _x == west) and (_x knowsabout _unit > 1)) then {
					_x reveal [_unit,1.5];					
				};
			}foreach(allUnits);
		}
	};
}];

while {true and alive _unit} do {
	sleep 2;	
	
	//check wanted status
	if !(captive _unit) then {
		//CURRENTLY WANTED
		if(_timer >= 0) then {
			_timer = _timer + 2;	
			_unit setVariable ["hiding",30 - _timer,true];
			if(_timer >= 30) then {
				_unit setCaptive true;
			};
			if((blufor knowsabout _unit) > 1) then {
				_unit setVariable ["hiding",30,true];
				_timer = 0;
			}
		}else{
			if((blufor knowsabout _unit) > 1) then {
				_unit setVariable ["hiding",30,true];
				_timer = 0;
			};
		};
	}else{
		//CURRENTLY NOT WANTED
		_timer = -1;
		_unit setVariable ["hiding",0,true];
		if((blufor knowsabout _unit) > 1) then {
			//Police can see you, don't do anything bad ok
			
			//LAW 1: You may not show a weapon (in front of the cops)
			if ((primaryWeapon _unit != "") or (secondaryWeapon _unit != "") or (handgunWeapon _unit != "")) then {				
				_unit setCaptive false;
				//reveal you to all cops/military within 2km
				{
					if((side _x == west) and (_x distance _unit < 2000)) then {
						_x reveal [_unit,1.5];					
					};
				}foreach(allUnits);
				
			}else{
				//Chance they will recognize you
				if(isPlayer _unit) then {
					_town = (getpos _unit) call nearestTown;
					_rep = _unit getVariable format["rep%1",_town];
					
					if(_rep < 0) then {
						_chance = abs _rep;
						if((random 100) < _chance) then {
							_unit setCaptive false;
							//reveal you to all cops/military within 800m
							{
								if((side _x == west) and (_x distance _unit < 800)) then {
									_x reveal [_unit,1.5];						
								};
							}foreach(allUnits);
						};					
					};
				}
			};
			
			//LAW 2: You can't wear the shit you steal off the cops, dude, not in front of them, I mean come on
			if ((headgear _unit in AIT_illegalHeadgear) or (vest _unit in AIT_illegalVests)) then {	
				_unit setCaptive false;				
				{
					if((side _x == west) and (_x distance _unit < 200)) then {
						_x reveal [_unit,1.5];					
					};
				}foreach(allUnits);
			};
		};
		if((opfor knowsabout _unit) > 1) then {
			//Criminals can see you
			if ((primaryWeapon _unit != "") or (secondaryWeapon _unit != "") or (handgunWeapon _unit != "")) then {
				_unit setCaptive false;
				//reveal you to all gang members
				{
					if((side _x == east) and (_x distance _unit < 800)) then {
						_x reveal [_unit,1.5];
					};
				}foreach(allUnits);
				
			};
		};
	};
};