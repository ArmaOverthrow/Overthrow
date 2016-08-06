if !(captive player) exitWith {hint "You cannot buy an ammobox while wanted"};

_price = 150;

_money = player getVariable "money";
if(_money < _price) exitWith {format["You need $%1",_price] call notify_minor};

_buildings =  (getpos player) nearObjects 10;
_handled = false;
_building = objNULL;
{
	_owner = _x getVariable "owner";
	if(!isNil "_owner") then {
		if ((typeof _x) in AIT_allBuyableBuildings and _owner == player) exitWith {
			_handled = true;
			
			playSound "ClickSoft";
			player setVariable ["money",_money-_price,true];			
			
			_cosa = (AIT_items_Storage select 0) createVehicle (getpos player);
			
			clearWeaponCargoGlobal _cosa;
			clearMagazineCargoGlobal _cosa;
			clearBackpackCargoGlobal _cosa;
			clearItemCargoGlobal _cosa;	
			
			_cosa enableSimulationGlobal false;
			_cosa attachTo [player,[0,2,1]];
			_idx = player addAction ["Drop Here", {{detach _x} forEach attachedObjects player; removeAllActions player},nil,0,false,true,"",""];

			waitUntil {sleep 0.05; (count attachedObjects player == 0) or (vehicle player != player) or (!alive player) or (!isPlayer player)};

			{detach _x} forEach attachedObjects player;
			player removeAction _idx;

			_cosa setPosATL [getPosATL _cosa select 0,getPosATL _cosa select 1,getPosATL player select 2];
			_cosa setVariable ["owner",player,true];
			sleep 1;
			_cosa addAction ["Move this", "actions\move.sqf",nil,0,false,true,"",""];
			_cosa enableSimulationGlobal true;
			
			_owned = player getVariable "owned";
			_owned pushback _cosa;
			player setVariable ["owned",_owned,true];
		};
	};
	
}foreach(_buildings);

if !(_handled) then {	
	"You don't own any buildings nearby" call notify_minor;
};

