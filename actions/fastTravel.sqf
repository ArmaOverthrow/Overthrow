if !(captive player) exitWith {"You cannot fast travel while wanted" call notify_minor};

if((vehicle player) != player) then {
	if (driver (vehicle player) != player)  exitWith {"You are not the driver of this vehicle" call notify_minor};
	if({!captive _x} count (crew vehicle player) != 0)  exitWith {"There are wanted people in this vehicle" call notify_minor};
};
posTravel = [];
"Click near a building or camp you own" call notify_minor;
openMap true;

onMapSingleClick "posTravel = _pos;";

waitUntil {sleep 0.1; (count posTravel > 0) or (not visiblemap)};
onMapSingleClick "";

if !(visibleMap) exitWith {};

_handled = false;

if(posTravel distance player < 250) exitWith {
	"You cannot fast travel less than 250m. Just walk!" call notify_minor;
	openMap false;
};

if([posTravel,"Misc"] call canPlace) then {
	_handled = true;
	player allowDamage false;
	disableUserInput true;
	
	cutText ["Fast traveling, please wait","BLACK",2];			
	sleep 2;
	openMap false;
	if((vehicle player) != player) then {
		if (driver vehicle player == player) then {
			_tam = 10;
			_roads = [];
			while {true} do {
				_roads = posTravel nearRoads _tam;
				if (count _roads < 1) then {_tam = _tam + 10};
				if (count _roads > 0) exitWith {};
			};
			{_x allowDamage false} foreach(crew vehicle player);					
			_road = _roads select 0;
			_pos = position _road findEmptyPosition [1,120,typeOf (vehicle player)];
			vehicle player setPos _pos;
		};				
	}else{
		player setpos posTravel;		
	};				

	disableUserInput false;
	cutText ["","BLACK IN",3]
};

if !(_handled) then {
	"You must click near a base, camp or owned building" call notify_minor;
	openMap false;
}else{
	if((vehicle player) != player) then {
		_crew = crew vehicle player;
		sleep 5;
		{_x allowDamage true} foreach(_crew);		
	}else{
		sleep 5;		
	};	
	player allowDamage true;
};