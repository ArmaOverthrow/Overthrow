private _cls = _this;

private _data = [];
{
	if((_x select 0) isEqualTo _cls) exitWith {_data = _x};
}foreach(OT_recruitables);

private _primary = _data select 1;
private _tertiary = _data select 2;
private _range = _data select 3;
private _uniform = _data select 4;
private _bino = _data select 5;

private _warehouseWpn = false;
private _warehouseScope = false;
private _warehouseTertiary = false;
private _warehousePistol = false;

//calculate cost
private _cost = floor(([OT_nation,"CIV",0] call OT_fnc_getPrice) * 1.5);

private _wpn = [_primary] call OT_fnc_findWeaponInWarehouse;
if(_wpn isEqualTo "") then {
	private _possible = [];
	{
		private _weapon = [_x] call BIS_fnc_itemType;
		private _weaponType = _weapon select 1;
		if(_weaponType == "AssaultRifle" && (_x find "_GL_") > -1) then {_weaponType = "GrenadeLauncher"};
		if(_weaponType == "AssaultRifle" && (_x find "srifle_") == 0) then {_weaponType = "SniperRifle"};
		if(_weaponType == _primary) then {_possible pushback _x};
	}foreach(OT_allWeapons);
	private _sorted = [_possible,[],{(cost getvariable [_x,[200]]) select 0},"ASCEND"] call BIS_fnc_SortBy;
	_wpn = _sorted select 0;
	private _price =((cost getVariable [_wpn,[200]]) select 0);
	_cost = _cost + _price;
}else{
	_warehouseWpn = true;
};
private _pwpn = ["Pistol"] call OT_fnc_findWeaponInWarehouse;
if(_pwpn != "") then {
	_warehousePistol = true;
};

private _scope = [_range] call OT_fnc_findScopeInWarehouse;
if(_scope isEqualTo "") then {
	private _possible = [];
	{
		private _name = _x;
		private _max = 0;
		private _allModes = "true" configClasses ( configFile >> "cfgWeapons" >> _name >> "ItemInfo" >> "OpticsModes" );
		{
			_max = _max max getNumber (_x >> "distanceZoomMax");
		}foreach(_allModes);
		if(_max >= _range) then {_possible pushback _name};
	}foreach(OT_allOptics);
	private _sorted = [_possible,[],{(cost getvariable [_x,[200]]) select 0},"ASCEND"] call BIS_fnc_SortBy;
	_scope = _sorted select 0;
	if(_scope != "") then {
		private _price = ((cost getVariable [_scope,[200]]) select 0);
		_cost = _cost + _price;
	};
}else{
	_warehouseScope = true;
};

if(count _tertiary > 0) then {
	private _got = false;
	{
		private _d = warehouse getvariable [format["item_%1",_x],[_x,0]];
		_d params ["_cls",["_num",0,[0]]];
		if(_num > 0) then {
			_tertiary = _x;
			_got = true;
		};
	}foreach(_tertiary);

	if(_got) then {
		_warehouseTertiary = true;
	}else{
		_tertiary = _tertiary select 0;
		private _price = ((cost getVariable [_tertiary,[1000]]) select 0);
		_cost = _cost + _price;
	};
}else{
	_tertiary = "";
};

[_cost,_cls,_wpn,_warehouseWpn,_pwpn,_warehousePistol,_tertiary,_warehouseTertiary,_scope,_warehouseScope,_uniform,_bino]
