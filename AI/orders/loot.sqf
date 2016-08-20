_sorted = [];

if(vehicle player != player) then {
	_sorted = [vehicle player];
}else{
	_objects = player nearEntities [["LandVehicle",AIT_item_Storage],20];
	if(count _objects == 0) exitWith {
		"Cannot find any containers or vehicles within 20m of you" call notify_minor;
	};
	_sorted = [_objects,[],{_x distance player},"ASCEND"] call BIS_fnc_SortBy;
};

if(count _sorted == 0) exitWith {};
_target = _sorted select 0;

format["Units will loot any dead bodies within 80m into this %1",(typeof _target) call ISSE_Cfg_Vehicle_GetName] call notify_minor;

_deadguys = [];
{
	if !((_x distance player > 80) or (alive _x) or (_x getVariable ["looted",false])) then {
		_deadguys pushback _x;
	};	
}foreach(entities "Man");

{
	[_x,_target,_deadguys] spawn {	
		_wasincar = false;
		_car = objNull;
		
		_unit = _this select 0;
		
		if((vehicle _unit) != _unit) then {
			_car = (vehicle _unit);
			doGetOut _unit;
			_wasincar = true;			
		};
		
		_t = _this select 1;
		_deadguys = _this select 2;
				
		_unit doMove getpos _t;
		
		_timeout = time + 120;
		waitUntil {sleep 1; (!alive _unit) or (isNull _t) or (_unit distance _t < 2) or (_timeOut < time) or (unitReady _unit)};		
		if(!alive _unit or (isNull _t) or (_timeOut < time)) exitWith {};
		
		[_unit,_t] call dumpStuff;
				
		while {true} do {
			_timeout = time + 120;
			_got = false;
			_deadguy = objNull;
			{
				if !(_x getVariable ["looted",false]) exitWith {
					_deadguy = _x;
					_got = true;
				};
			}foreach(_deadguys);
			if(!_got) exitWith {_unit globalChat "All done sir!"};
			_deadguy setVariable ["looted",true,true];
			
			_unit doMove getpos _deadguy;
			waitUntil {sleep 1; (!alive _unit) or (isNull _t) or (_unit distance _deadguy < 2) or (_timeOut < time) or (unitReady _unit)};		
			if((!alive _unit) or (_timeOut < time)) exitWith {hint "0"};
			
			[_deadguy,_unit] call takeStuff;
			[_deadguy] spawn {
				sleep 600;
				_n = _this select 0;
				if!(isNil "_n") then {
					deleteVehicle (_this select 0);
				}
			};			
			sleep 2;
			if(primaryWeapon _unit == "") then {
				_weapon = objNull;
				{
					if !(_x getVariable ["looted",false]) exitWith {
						_weapon = _x;
						_weapon setVariable ["looted",true,true];
					};
				}foreach(_unit nearentities ["WeaponHolderSimulated",30]);
				if !(isNull _weapon) then {
					_unit doMove getpos _weapon;
					waitUntil {sleep 1; (!alive _unit) or (_unit distance _weapon < 2) or (_timeOut < time) or (unitReady _unit)};		
					if(alive _unit and (_timeOut > time)) then {
						_s = (weaponsItems _weapon) select 0;
						
						_unit addWeapon (_s select 0);
						_i = _s select 1;
						if(_i != "") then {_unit addPrimaryWeaponItem _i};
						_i = _s select 2;
						if(_i != "") then {_unit addPrimaryWeaponItem _i};
						_i = _s select 3;
						if(_i != "") then {_unit addPrimaryWeaponItem _i};						
						deleteVehicle _weapon;
						sleep 1;
					};
				};
			};
			if(!alive _unit) exitWith {hint "1"};
			_timeout = time + 120;
			_unit doMove getpos _t;
			waitUntil {sleep 1; (!alive _unit) or (isNull _t) or (_unit distance _t < 2) or (_timeOut < time) or (unitReady _unit)};		
			if((!alive _unit) or (_timeOut < time)) exitWith {hint "2"};
			
			[_unit,_t] call dumpStuff;
			sleep 1;
		};
		
		if(_wasincar) then {
			_unit assignAsCargo _car;
			[_unit] orderGetIn true;
		};
	};
	sleep 0.1;
}foreach(groupSelectedUnits player);