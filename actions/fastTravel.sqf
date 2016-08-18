if !(captive player) exitWith {"You cannot fast travel while wanted" call notify_minor};

if((vehicle player) != player) then {
	if (driver vehicle player == player)  exitWith {"You are not the driver of this vehicle" call notify_minor};
	if({!captive _x} count (crew vehicle player) != 0)  exitWith {"There are wanted people in this vehicle" call notify_minor};
};
posTravel = [];
hint "Click near a building or camp you own";
openMap true;

onMapSingleClick "posTravel = _pos;";

waitUntil {sleep 0.1; (count posTravel > 0) or (not visiblemap)};
onMapSingleClick "";

if !(visibleMap) exitWith {};

_handled = false;
_estate = posTravel call getNearestOwned;
if(typename _estate == "OBJECT") then {
	_b = _estate;	
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
			_pos = position _road findEmptyPosition [1,50,typeOf (vehicle player)];
			vehicle player setPos _pos;
		};				
	}else{
		if((typeof _b) == AIT_item_tent) then {
			player setpos ([(getpos _b),5,getDir _b] call BIS_fnc_relPos);//Make sure they dont land on the fire
		}else{
			player setpos (getpos _b);
		};
		
	};				

	disableUserInput false;
	cutText ["","BLACK IN",3]
};

if !(_handled) then {
	"You don't own any buildings or camps near there" call notify_minor;
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