if !(captive player) exitWith {"You cannot fast travel while wanted" call notify_minor};

if((vehicle player) != player) then {
	if (driver (vehicle player) != player)  exitWith {"You are not the driver of this vehicle" call notify_minor};
	if({!captive _x} count (crew vehicle player) != 0)  exitWith {"There are wanted people in this vehicle" call notify_minor};
};

"Click near a friendly base/camp or a building you own" call notify_minor;
openMap true;

["fastTravel", "onMapSingleClick", {
	private _starttown = player call nearestTown;
	private _region = server getVariable format["region_%1",_starttown];
	if !([_pos,_region] call fnc_isInMarker) exitWith {
		"You cannot fast travel between islands" call notify_minor;
		openMap false;
	};
	if(_pos distance player < 150) exitWith {
		"You cannot fast travel less than 150m. Just walk!" call notify_minor;
		openMap false;
	};
	private _handled = false;

	_buildings =  _pos nearObjects [OT_item_Tent,30];
	if !(_buildings isEqualTo []) then {			
		_handled = true;				
	};

	if !(_handled) then {
		if([_pos,"Misc"] call canPlace) then {
			_handled = true;		
		};
	};

	if !(_handled) then {
		
		"You must click near a friendly base/camp or a building you own" call notify_minor;
		openMap false;
	}else{
		player allowDamage false;
		disableUserInput true;
		
		cutText ["Fast travelling","BLACK",2];
		_pos spawn {
			private _pos = _this;
			sleep 2;
			
			if((vehicle player) != player) then {
				if ((driver vehicle player) == player) then {
					_tam = 10;
					_roads = [];
					while {true} do {
						_roads = _pos nearRoads _tam;
						if (count _roads < 1) then {_tam = _tam + 10};
						if (count _roads > 0) exitWith {};
					};
					{_x allowDamage false} foreach(crew vehicle player);					
					_road = _roads select 0;
					_pos = position _road findEmptyPosition [1,120,typeOf (vehicle player)];
					vehicle player setPos _pos;
				};				
			}else{
				player setpos _pos;		
			};				

			disableUserInput false;
			cutText ["","BLACK IN",3];
				
			if((vehicle player) != player) then {
				_crew = crew vehicle player;
				{_x allowDamage true} foreach(_crew);		
			};
			player allowDamage true;
			openMap false;
		};
	};
	["fastTravel", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
}, nil] call BIS_fnc_addStackedEventHandler;
