_target = vehicle player;

if(_target == player) exitWith {};

if(count (player nearObjects [OT_portBuilding,30]) == 0) exitWith {};

private _town = player call OT_fnc_nearestTown;
_doillegal = false;
if(_town in (server getVariable ["NATOabandoned",[]])) then {
	_doillegal = true;
}else{
	hint format ["Only legal items may be exported while NATO controls %1",_town];
};

"Exporting inventory" call OT_fnc_notifyMinor;
[5,false] call OT_fnc_progressBar;
sleep 5;
_total = 0;
{
	_count = 0;
	_cls = _x select 0;
	_num = _x select 1;
	if(_doillegal or _cls in (OT_allItems + OT_allBackpacks + OT_Resources + OT_allClothing)) then {
		_baseprice = [OT_nation,_cls,0] call OT_fnc_getSellPrice;
		_costprice = round(_baseprice * 0.6); //The cost of export
		if(_cls in OT_allDrugs) then {
			_costprice = round(_baseprice * 0.5);
		};
		if(_cls in OT_illegalItems) then {
			_costprice = round(_baseprice * 0.3);
		};

		_total = _total + (_costprice * _num);
		call {
			if(_cls isKindOf ["Rifle",configFile >> "CfgWeapons"]) exitWith {
				[_target, _cls, _num] call CBA_fnc_removeWeaponCargo;
			};
			if(_cls isKindOf ["Launcher",configFile >> "CfgWeapons"]) exitWith {
				[_target, _cls, _num] call CBA_fnc_removeWeaponCargo;
			};
			if(_cls isKindOf ["Pistol",configFile >> "CfgWeapons"]) exitWith {
				[_target, _cls, _num] call CBA_fnc_removeWeaponCargo;
			};
			if(_cls isKindOf ["CA_Magazine",configFile >> "CfgMagazines"]) exitWith {
				[_target, _cls, _num] call CBA_fnc_removeMagazineCargo;
			};
			if(_cls isKindOf "Bag_Base") exitWith {
				[_target, _cls, _num] call CBA_fnc_removeBackpackCargo;
			};
			if !([_target, _cls, _num] call CBA_fnc_removeItemCargo) then {
				[_target, _cls, _num] call CBA_fnc_removeWeaponCargo;
			};
		};
	};
}foreach(_target call OT_fnc_unitStock);

[_total] call OT_fnc_money;
