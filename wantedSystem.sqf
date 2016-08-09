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

while {alive _unit} do {
	sleep 2;	
	
	//check wanted status
	if !(captive _unit) then {
		//CURRENTLY WANTED
		if(_timer >= 0) then {
			_timer = _timer + 2;	
			_unit setVariable ["hiding",30 - _timer,true];
			if(_timer >= 30) then {
				_unit setCaptive true;
			}else{
				if (_unit call unitSeen) then {
					_unit setCaptive false;
					_timer = 0;
					_unit setVariable ["hiding",30,true];
				};
			};
		}else{				
			if !(_unit call unitSeen) then {
				_lastkill = _unit getVariable ["lastkill",0];
				if((time - _lastkill) > 120) then {
					_unit setVariable ["hiding",30,true];	
					_timer = 0;	
				};
			};
		};
	}else{
		//CURRENTLY NOT WANTED
		_timer = -1;
		_unit setVariable ["hiding",0,true];
		
		if(_unit call unitSeenCRIM) then {
			//chance they will just notice you if your global rep is very high or low
			_totalrep = abs(_unit getVariable ["rep",0]) * 0.5;
			if(random 1000 < _totalrep) then {
				_unit setCaptive false;
				"A gang has recognized you" call notify_minor;
			}else{
				if ((primaryWeapon _unit != "") or (secondaryWeapon _unit != "") or (handgunWeapon _unit != "") or (headgear _unit in AIT_illegalHeadgear) or (vest _unit in AIT_illegalVests)) then {				
					_unit setCaptive false;	
					{
						if((side _x == east) and (_x distance _unit < 200)) then {
							_x reveal [_unit,1.5];					
						};
					}foreach(player nearentities ["Man",200]);
				};
			};
		}else{	
			//chance they will just notice you if your local or global rep is very low
			//The info you came here for is: Your global rep needs to be 4 x your local rep in order to cancel out this effect
			if(_unit call unitSeenNATO) then {
				_town = (getpos _unit) call nearestTown;
				_totalrep = ((_unit getVariable ["rep",0]) * -0.25) + ((_unit getVariable format["rep%1",_town]) * -1);
				if(random 250 < _totalrep) then {
					_unit setCaptive false;
					"NATO has recognized you" call notify_minor;
				};
			}else{
				if ((primaryWeapon _unit != "") or (secondaryWeapon _unit != "") or (handgunWeapon _unit != "") or (headgear _unit in AIT_illegalHeadgear) or (vest _unit in AIT_illegalVests)) then {				
					_unit setCaptive false;	
					{
						if((side _x == west) and (_x distance _unit < 800)) then {
							_x reveal [_unit,1.5];					
						};
					}foreach(player nearentities ["Man",800]);
				};
			};
		};
	};
};