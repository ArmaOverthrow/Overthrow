private ["_sorted","_target","_deadguys","_wasincar","_unit","_t","_got","_timeout","_weapon","_myunits"];

_sorted = [];
_myunits = groupSelectedUnits player;

_active = true;

_tt = _myunits select 0;
if(vehicle _tt != _tt) then {
	_sorted = [vehicle _tt];
}else{
	_objects = _tt nearEntities [["LandVehicle",OT_item_Storage,OT_items_distroStorage select 0],20];
	if(count _objects == 0) exitWith {
		"Cannot find any containers or vehicles within 20m of first selected unit" call notify_minor;
	};
	_sorted = [_objects,[],{_x distance _tt},"ASCEND"] call BIS_fnc_SortBy;
};

if(count _sorted == 0) exitWith {};
_target = _sorted select 0;

_tt groupChat format["Looting nearby bodies into the %1",(typeof _target) call ISSE_Cfg_Vehicle_GetName];

{
	[_x,_target] spawn {	
		_wasincar = false;
		_car = objNull;
		
		_unit = _this select 0;
		
		if((vehicle _unit) != _unit) then {
			_car = (vehicle _unit);
			doGetOut _unit;
			_wasincar = true;			
		};
		
		_t = _this select 1;
						
		_unit doMove getpos _t;
		
		_timeout = time + 120;
		waitUntil {sleep 1; (!alive _unit) or (isNull _t) or (_unit distance _t < 2) or (_timeOut < time) or (unitReady _unit)};		
		if(!alive _unit or (isNull _t) or (_timeOut < time)) exitWith {};
		
		if !([_unit,_t] call dumpStuff) then {
			_unit globalchat "This vehicle is full, cancelling loot order";
			_active = false;
		};			
				
		while {true and _active} do {
			_deadguys = [];
			{
				if !((_x distance player > 100) or (alive _x) or (_x getVariable ["looted",false])) then {
					_deadguys pushback _x;
				};	
			}foreach(entities "Man");
			if(count _deadguys == 0) exitWith {};
			_sorted = [_deadguys,[],{_x distance _t},"ASCEND"] call BIS_fnc_SortBy;
			
			_timeout = time + 120;
			_deadguy = _sorted select 0;
			_deadguy setVariable ["looted",true,true];
			
			_unit doMove getpos _deadguy;
			waitUntil {sleep 1; (!alive _unit) or (isNull _t) or (_unit distance _deadguy < 2) or (_timeOut < time) or (unitReady _unit)};		
			if((!alive _unit) or (_timeOut < time)) exitWith {};
			
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
				}foreach(_unit nearentities ["WeaponHolderSimulated",10]);
				if !(isNull _weapon) then {
					_unit doMove getpos _weapon;
					waitUntil {sleep 1; (!alive _unit) or (_unit distance _weapon < 2) or (_timeOut < time) or (unitReady _unit)};		
					if(alive _unit and (_timeOut > time)) then {
						_s = (weaponsItems _weapon) select 0;
						
						_unit addWeapon ([(_s select 0)] call BIS_fnc_baseWeapon);
						_i = _s select 1;
						if(_i != "") then {_unit addItem _i};
						_i = _s select 2;
						if(_i != "") then {_unit addItem _i};
						_i = _s select 3;
						if(_i != "") then {_unit addItem _i};
						deleteVehicle _weapon;
						sleep 1;
					};
				};
			};
			if(!alive _unit) exitWith {};
			_timeout = time + 120;
			_unit doMove getpos _t;
			waitUntil {sleep 1; (!alive _unit) or (isNull _t) or (_unit distance _t < 2) or (_timeOut < time) or (unitReady _unit)};		
			if((!alive _unit) or (_timeOut < time)) exitWith {};
			
			if !([_unit,_t] call dumpStuff) exitWith {
				_unit globalchat "This vehicle is full, cancelling loot order";
				_active = false;
			};			
			
			sleep 1;
		};
		while {true and _active} do {
			_got = false;
			_weapon = objNull;
			{
				if !(_x getVariable ["looted",false]) exitWith {
					_weapon = _x;
					_got = true;
					_weapon setVariable ["looted",true,true];
				};
			}foreach(_unit nearentities ["WeaponHolderSimulated",100]);
			
			if(!_got) exitWith {_unit globalchat "All done, sir!"};
			
			_timeout = time + 120;
			_unit doMove getpos _weapon;
			waitUntil {sleep 1; (!alive _unit) or (_unit distance _weapon < 2) or (_timeOut < time) or (unitReady _unit)};		
			if(alive _unit and (_timeOut > time)) then {
				_s = (weaponsItems _weapon) select 0;				
				_cls = (_s select 0);
				_unit addWeapon ([(_s select 0)] call BIS_fnc_baseWeapon);
				_i = _s select 1;
				if(_i != "") then {_unit addItem _i};
				_i = _s select 2;
				if(_i != "") then {_unit addItem _i};
				_i = _s select 3;
				if(_i != "") then {_unit addItem _i};
				deleteVehicle _weapon;
				sleep 1;
			};
			if(!alive _unit) exitWith {};
			_timeout = time + 120;
			_unit doMove getpos _t;
			waitUntil {sleep 1; (!alive _unit) or (isNull _t) or (_unit distance _t < 2) or (_timeOut < time) or (unitReady _unit)};		
			if((!alive _unit) or (_timeOut < time)) exitWith {};
			
			[_unit,_t] call dumpStuff;
		};
		
		if(_wasincar) then {
			_unit assignAsCargo _car;
			[_unit] orderGetIn true;
		};
	};
	sleep 0.1;
}foreach(_myunits);